import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:nounews_app/models/article_model.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/res/utils/date_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArticleDetailsPage extends StatelessWidget {
  const ArticleDetailsPage({
    super.key,
    required this.article,
  });

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          spacing: kPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.thumbnailUrl != null)
              Hero(
                transitionOnUserGestures: true,
                tag: article.hashCode,
                child: Image.network(
                  width: double.infinity,
                  article.thumbnailUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (article.feedTitle != null)
                    Text(
                      article.feedTitle!,
                    ),
                  Text(
                    switch (article.publishedAt) {
                      final DateTime publishedAt => dfDateWords.format(publishedAt),
                      _ => 'Unknown date',
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Text(
                article.title,
                style: context.textTheme.titleLarge,
              ),
            ),
            if (article.description != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Text(article.description!),
              ),
            ],
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: DuoButton.icon(
                onPressed: () {
                  launchUrlString(article.referenceUrl);
                },
                icon: const Icon(TablerIcons.book),
                label: const Text('Open full article'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
