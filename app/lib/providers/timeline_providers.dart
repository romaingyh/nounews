import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/models/article_model.dart';
import 'package:nounews_app/models/feed_model.dart';
import 'package:nounews_app/providers/user_feeds_provider.dart';
import 'package:nounews_app/res/extensions/iterable_extension.dart';
import 'package:nounews_app/res/extensions/map_extension.dart';
import 'package:nounews_app/res/extensions/ref_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'timeline_providers.g.dart';

@riverpod
FutureOr<List<ArticleModel>> timelineArticles(
  Ref ref, {
  String? searchQuery,
}) async {
  await ref.debounce();

  final userFeeds = await ref.watch(userFeedsProvider.future);

  final feedsIds = userFeeds.map((e) => e.id).toList();

  var query = Supabase.instance.client
      .from('articles')
      .select('*, feed_id ( feed_id, feed_title )')
      .inFilter('feed_id', feedsIds);

  if (searchQuery != null && searchQuery.trim().length >= 3) {
    query = query.textSearch('title', searchQuery);
  }

  return query.order('published_at', ascending: false).withConverter(
        (data) => data.mapEmptySafe((json) => ArticleModel.fromJson(json.flattened)).toList(),
      );
}

@riverpod
class TimelineHiddenFeeds extends _$TimelineHiddenFeeds {
  @override
  List<int> build() {
    return [];
  }

  void toggle(int feedId) {
    if (state.contains(feedId)) {
      state = state.where((id) => id != feedId).toList();
    } else {
      state = [...state, feedId];
    }
  }
}

@riverpod
bool isFeedHidden(Ref ref, FeedModel feed) {
  return ref.watch(
    timelineHiddenFeedsProvider.select((hiddenFeeds) => hiddenFeeds.contains(feed.id)),
  );
}
