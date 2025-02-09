import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:nounews_app/models/article_model.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/extensions/text_style_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/res/utils/date_utils.dart';
import 'package:nounews_app/view/widgets/feed_chip.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    super.key,
    required this.article,
  });

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Row(
        children: [
          if (article.thumbnailUrl != null)
            AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: article.hashCode,
                transitionOnUserGestures: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  child: Image.network(
                    article.thumbnailUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          border: Border.all(
                            color: context.colorScheme.surfaceContainer,
                            width: 3,
                          ),
                        ),
                        child: const Icon(TablerIcons.wifi_off, size: 32),
                      );
                    },
                  ),
                ),
              ),
            ),
          const SizedBox(width: kPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (article.feedName != null) ...[
                  FeedChip(feedName: article.feedName!),
                ],
                const SizedBox(height: kPadding / 2),
                Expanded(
                  child: Center(
                    child: Text(
                      article.title,
                      style: context.textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                const SizedBox(height: kPadding / 2),
                Row(
                  children: [
                    if (article.publishedAt != null)
                      Text(
                        dfDateWords.format(article.publishedAt!),
                        style: context.textTheme.bodySmall.secondary(context),
                      ),
                    const Spacer(),
                    const Icon(TablerIcons.share_2),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
