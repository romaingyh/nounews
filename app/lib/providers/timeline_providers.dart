import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/models/article_model.dart';
import 'package:nounews_app/models/equatable_list_wrapper.dart';
import 'package:nounews_app/models/feed_model.dart';
import 'package:nounews_app/providers/auth_provider.dart';
import 'package:nounews_app/res/extensions/iterable_extension.dart';
import 'package:nounews_app/res/extensions/map_extension.dart';
import 'package:nounews_app/res/extensions/ref_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'timeline_providers.g.dart';

@riverpod
class UserFeeds extends _$UserFeeds {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  FutureOr<List<FeedModel>> build() async {
    final user = await ref.watch(authProvider.selectAsync((data) => data));
    if (user == null) {
      throw StateError('User not authenticated');
    }

    return _client.from('user_feed_subscriptions').select('*, feed_id (*)').eq('user_id', user.id).withConverter(
          (data) => data.mapEmptySafe((json) => FeedModel.fromJson(json.flattened)).toList(),
        );
  }

  Future<void> follow(List<FeedModel> feeds) async {
    final prevState = await future;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final userId = ref.read(authProvider).valueOrNull?.id;
      if (userId == null) {
        throw StateError('User not authenticated');
      }

      await _client.from('user_feed_subscriptions').insert(
        [
          for (final feed in feeds)
            {
              'feed_id': feed.id,
              'user_id': userId,
            },
        ],
      );

      return [...feeds, ...prevState];
    });
  }
}

@riverpod
FutureOr<List<ArticleModel>> feedsArticles(Ref ref, EquatableListWrapper<FeedModel> feeds) async {
  final feedsIds = feeds.list.map((e) => e.id).toList();

  return Supabase.instance.client
      .from('articles')
      .select('*, feed_id ( feed_id, feed_name )')
      .inFilter('feed_id', feedsIds)
      .order('published_at', ascending: false)
      .withConverter(
        (data) => data.mapEmptySafe((json) => ArticleModel.fromJson(json.flattened)).toList(),
      );
}

@riverpod
FutureOr<List<FeedModel>> feeds(
  Ref ref, {
  String? query,
}) async {
  await ref.debounce();

  var request = Supabase.instance.client.from('feeds').select();

  if (query != null && query.trim().length > 2) {
    request = request.ilike('feed_name', '%$query%');
  }

  return request.withConverter(
    (data) => data.mapEmptySafe((json) => FeedModel.fromJson(json)).toList(),
  );
}
