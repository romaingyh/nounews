import 'package:nounews_app/models/feed_model.dart';
import 'package:nounews_app/providers/auth_provider.dart';
import 'package:nounews_app/res/extensions/iterable_extension.dart';
import 'package:nounews_app/res/extensions/map_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_feeds_provider.g.dart';

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

  Future<void> follow(Set<int> feedsIds) async {
    final userId = ref.read(authProvider).valueOrNull?.id;
    if (userId == null) {
      state = AsyncError("Not authenticated", StackTrace.current);
      return;
    }

    final prevState = await future;

    final followedFeedsIds = prevState.map((e) => e.id).toSet();

    final toFollow = feedsIds.difference(followedFeedsIds);
    final toUnfollow = followedFeedsIds.difference(feedsIds);

    if (toFollow.isEmpty && toUnfollow.isEmpty) {
      return;
    }

    state = const AsyncLoading();

    try {
      for (final feedId in toUnfollow) {
        await _client.from('user_feed_subscriptions').delete().eq('user_id', userId).eq('feed_id', feedId);
      }

      await _client.from('user_feed_subscriptions').insert(
        [
          for (final feedId in toFollow)
            {
              'feed_id': feedId,
              'user_id': userId,
            },
        ],
      );

      ref.invalidateSelf();
    } catch (err, stack) {
      state = AsyncError(err, stack);
    }
  }
}
