import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/models/feed_preview_model.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/view/widgets/articles_list.dart';

class FeedPreviewPage extends ConsumerWidget {
  const FeedPreviewPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = context.routeArgument<FeedPreviewModel>();

    return ColoredBox(
      color: context.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Text(
              'Preview${model.feedTitle != null ? ' - ${model.feedTitle}' : ''}',
              style: context.textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ArticlesList(articles: model.articles),
          ),
          Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Row(
              children: [
                OutlinedDuoButton.icon(
                  onPressed: () {
                    context.navigator.pop();
                  },
                  icon: const Icon(TablerIcons.arrow_left),
                  label: const Text("Back"),
                ),
                const SizedBox(width: kPadding),
                Expanded(
                  child: DuoButton(
                    onPressed: () {},
                    child: const Text("Looks good, add this feed"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
