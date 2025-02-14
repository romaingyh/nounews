import 'package:flutter/material.dart';
import 'package:nounews_app/models/article_model.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/view/pages/article_details_page.dart';
import 'package:nounews_app/view/widgets/article_tile.dart';
import 'package:nounews_app/view/widgets/common/entry_animated_widget.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({
    super.key,
    required this.articles,
    this.padding = kPadding,
    this.spacing = kPadding * 2,
  });

  final List<ArticleModel> articles;

  final double padding;

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      cacheExtent: 0,
      padding: EdgeInsets.symmetric(vertical: padding),
      itemCount: articles.length,
      separatorBuilder: (_, __) => SizedBox(height: spacing),
      itemBuilder: (context, index) {
        final article = articles[index];

        return EntryAnimatedWidget(
          type: AnimationType.fade,
          duration: kSlowAnimationDuration,
          child: InkWell(
            onTap: () {
              context.navigator.push(
                MaterialPageRoute<void>(
                  builder: (context) => ArticleDetailsPage(article: article),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: ArticleTile(article: article),
            ),
          ),
        );
      },
    );
  }
}
