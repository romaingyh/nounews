import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:nounews_app/models/feed_preview_model.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/view/widgets/articles_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedPreviewPage extends StatefulWidget {
  const FeedPreviewPage();

  @override
  State<FeedPreviewPage> createState() => _FeedPreviewPageState();
}

class _FeedPreviewPageState extends State<FeedPreviewPage> {
  bool _isLoading = false;

  String? _errorMessage;

// TODO: Check if there is an existing feed before creating a new one
  Future<void> _addFeed({
    required String title,
    required String url,
  }) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await Supabase.instance.client.functions.invoke(
        'add_feed',
        body: {'feed_title': title, 'feed_url': url},
      );

      final data = response.data as Map<String, dynamic>;
      final feedId = data['feed_id'] as int;

      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop(feedId);
      }
    } on FunctionException catch (e) {
      setState(() => _errorMessage = e.details.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.routeArgument<FeedPreviewModel>();

    return ColoredBox(
      color: context.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Text(
              'Preview - ${model.feedTitle}',
              style: context.textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ArticlesList(articles: model.articles),
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: kPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Center(
                child: Text(
                  _errorMessage!,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.error,
                  ),
                ),
              ),
            ),
          ],
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
                    onPressed: _isLoading
                        ? null
                        : () {
                            _addFeed(
                              title: model.feedTitle,
                              url: model.feedUrl,
                            );
                          },
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
