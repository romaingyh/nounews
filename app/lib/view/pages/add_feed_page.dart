import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/models/feed_preview_model.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/view/pages/feed_preview_page.dart';
import 'package:nounews_app/view/widgets/feed_creation_animated_icon.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _addFeedFormKey = GlobalKey<FormState>();

class _AddFeedRoutes {
  static const String creationForm = '/creation_form';
  static const String preview = '/preview';
}

class AddFeedPage extends StatelessWidget {
  const AddFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a new feed")),
      body: SafeArea(
        child: Navigator(
          initialRoute: _AddFeedRoutes.creationForm,
          onGenerateRoute: (settings) => switch (settings.name) {
            _AddFeedRoutes.creationForm => MaterialPageRoute(
                builder: (context) => const _FeedCreationForm(),
                settings: settings,
              ),
            _AddFeedRoutes.preview => MaterialPageRoute<int?>(
                builder: (context) => const FeedPreviewPage(),
                settings: settings,
              ),
            _ => null
          },
        ),
      ),
    );
  }
}

class _FeedCreationForm extends ConsumerStatefulWidget {
  const _FeedCreationForm();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __FeedCreationFormPageState();
}

class __FeedCreationFormPageState extends ConsumerState<_FeedCreationForm> {
  final _textController = TextEditingController(text: "https://www.numerama.com/feed");

  bool _isLoading = false;

  String? _errorMessage;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // TODO: Check if there is an existing feed before creating a new one
  Future<void> _createFeedFromUri(Uri uri) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await Supabase.instance.client.functions.invoke(
        'preview_feed',
        body: {
          'url': uri.toString(),
        },
      );

      final json = response.data as Map<String, dynamic>;
      final model = FeedPreviewModel.fromJson(json);

      if (mounted) {
        context.navigator.pushNamed(_AddFeedRoutes.preview, arguments: model);
      }
    } on FunctionException catch (e) {
      setState(() => _errorMessage = e.details.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addFeedFormKey,
      child: Container(
        color: context.colorScheme.surface,
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          spacing: kPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: FeedCreationAnimatedIcon(
                  isLoading: _isLoading,
                  errorMessage: _isLoading ? null : _errorMessage,
                ),
              ),
            ),
            Text(
              "To communicate latest news, many websites use the RSS protocol with an RSS feed url, which can end with a .rss extension (not always).",
              style: context.textTheme.titleSmall,
            ),
            RichText(
              text: TextSpan(
                style: context.textTheme.titleSmall,
                children: const [
                  TextSpan(
                    text: "Search for RSS icon ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  WidgetSpan(
                    child: Icon(TablerIcons.rss, size: 18),
                  ),
                  TextSpan(
                    text: " on the website.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text(
              "If the website doesn't provide an RSS feed, enter the url of the page where the news are. An AI will extract the news.",
              style: context.textTheme.titleSmall,
            ),
            const SizedBox(height: kPadding),
            TextFormField(
              controller: _textController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'You must enter a url';
                }

                final isValidUrl = Uri.tryParse(value)?.hasAbsolutePath ?? false;

                if (!isValidUrl) {
                  return 'Invalid url';
                }

                return null;
              },
              decoration: const InputDecoration(hintText: "https://www.numerama.com/feed/"),
            ),
            ValueListenableBuilder(
              valueListenable: _textController,
              builder: (context, value, child) => DuoButton.icon(
                onPressed: (value.text.trim().isEmpty || _isLoading)
                    ? null
                    : () {
                        if (_addFeedFormKey.currentState!.validate()) {
                          final uri = Uri.parse(value.text);
                          _createFeedFromUri(uri);
                        }
                      },
                iconAlignment: IconAlignment.end,
                icon: const Icon(TablerIcons.file_search),
                label: const Text("Create feed preview"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
