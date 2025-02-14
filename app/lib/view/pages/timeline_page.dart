import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/models/article_model.dart';
import 'package:nounews_app/providers/timeline_providers.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/view/widgets/articles_list.dart';
import 'package:nounews_app/view/widgets/drawer_visibility_button.dart';
import 'package:nounews_app/view/widgets/search_bar.dart';
import 'package:nounews_app/view/widgets/timeline_drawer.dart';

class TimelinePage extends ConsumerStatefulWidget {
  const TimelinePage({
    super.key,
  });

  @override
  ConsumerState<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends ConsumerState<TimelinePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final articles = ref.watch(timelineArticlesProvider(searchQuery: _searchQuery));

    return Scaffold(
      appBar: AppBar(
        leading: const DrawerVisibilityButton(),
        title: const Text('NouNews'),
        backgroundColor: context.colorScheme.surface,
      ),
      drawerEdgeDragWidth: context.screenSize.width * 0.75,
      drawer: const TimelineDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: MySearchBar(
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          const SizedBox(height: kPadding),
          const Divider(height: 1),
          Expanded(
            child: switch (articles) {
              AsyncData(value: final articles) => _buildArticlesList(articles),
              AsyncError(:final error) => Text(error.toString()),
              _ => const CircularProgressIndicator.adaptive(),
            },
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesList(List<ArticleModel> articles) {
    final hiddenFeedsIds = ref.watch(timelineHiddenFeedsProvider);

    final visibleArticles = articles.where((article) => !hiddenFeedsIds.contains(article.feedId)).toList();

    return RefreshIndicator.adaptive(
      onRefresh: () => ref.refresh(timelineArticlesProvider(searchQuery: _searchQuery).future),
      child: ArticlesList(articles: visibleArticles),
    );
  }
}
