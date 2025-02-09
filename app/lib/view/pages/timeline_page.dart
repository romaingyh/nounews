import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/models/equatable_list_wrapper.dart';
import 'package:nounews_app/models/feed_model.dart';
import 'package:nounews_app/providers/timeline_providers.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/view/widgets/articles_list.dart';
import 'package:nounews_app/view/widgets/common/async_value_widgets.dart';
import 'package:nounews_app/view/widgets/drawer_visibility_button.dart';
import 'package:nounews_app/view/widgets/search_bar.dart';

class TimelinePage extends ConsumerStatefulWidget {
  const TimelinePage({
    super.key,
    required this.feeds,
  });

  final List<FeedModel> feeds;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimelinePageState();
}

class _TimelinePageState extends ConsumerState<TimelinePage> {
  final List<int> _visibleFeedIds = <int>[];

  @override
  void initState() {
    for (final feed in widget.feeds) {
      _visibleFeedIds.add(feed.id);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerVisibilityButton(),
        title: const Text('NouNews'),
        backgroundColor: context.colorScheme.surface,
      ),
      drawerEdgeDragWidth: context.screenSize.width * 0.75,
      drawer: Drawer(
        backgroundColor: context.colorScheme.surface,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: MySearchBar(),
          ),
          const SizedBox(height: kPadding),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              itemCount: widget.feeds.length,
              separatorBuilder: (_, __) => const SizedBox(width: kPadding),
              itemBuilder: (BuildContext context, int index) {
                final feed = widget.feeds[index];

                final isSelected = _visibleFeedIds.contains(feed.id);

                return FilterChip(
                  label: Text(feed.name),
                  side: isSelected ? BorderSide.none : null,
                  labelStyle: isSelected ? const TextStyle(color: Colors.white) : null,
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _visibleFeedIds.add(feed.id);
                      } else {
                        _visibleFeedIds.remove(feed.id);
                      }
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: kPadding),
          const Divider(height: 1),
          Expanded(
            child: ref.watch(feedsArticlesProvider(EquatableListWrapper(widget.feeds))).when(
                  error: asyncErrorWidgetBuilder,
                  loading: asyncLoadingWidgetBuilder,
                  data: (articles) {
                    final visibleArticles = articles
                        .where(
                          (article) => _visibleFeedIds.contains(article.feedId),
                        )
                        .toList();

                    return ArticlesList(articles: visibleArticles);
                  },
                ),
          ),
        ],
      ),
    );
  }
}
