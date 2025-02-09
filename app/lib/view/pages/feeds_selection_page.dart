import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/models/feed_model.dart';
import 'package:nounews_app/providers/timeline_providers.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/routes.dart';
import 'package:nounews_app/view/widgets/common/async_value_widgets.dart';
import 'package:nounews_app/view/widgets/search_bar.dart';

class FeedsSelectionPage extends ConsumerStatefulWidget {
  const FeedsSelectionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedsSelectionPageState();
}

class _FeedsSelectionPageState extends ConsumerState<FeedsSelectionPage> {
  final List<FeedModel> _selectedFeeds = [];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NouNews")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            spacing: kPadding,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Start by following feeds you're interested in",
                style: context.textTheme.titleLarge,
              ),
              Expanded(
                child: ref.watch(feedsProvider(query: _searchQuery)).when(
                      error: asyncErrorWidgetBuilder,
                      loading: asyncLoadingWidgetBuilder,
                      data: (feeds) {
                        return _buildFeedsList(feeds);
                      },
                    ),
              ),
              MySearchBar(
                hintText: 'Search news feeds',
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedsList(List<FeedModel> feeds) {
    return Center(
      child: SingleChildScrollView(
        child: Wrap(
          runAlignment: WrapAlignment.center,
          spacing: kPadding,
          runSpacing: kPadding,
          children: [
            for (final feed in feeds)
              FilterChip(
                label: Text(feed.name),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                selected: _selectedFeeds.contains(feed),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedFeeds.add(feed);
                    } else {
                      _selectedFeeds.remove(feed);
                    }
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      spacing: kPadding,
      children: [
        Expanded(
          child: OutlinedDuoButton.icon(
            onPressed: () {
              context.navigator.pushNamed(Routes.addFeed);
            },
            icon: const Icon(TablerIcons.plus),
            label: const Text('Add a new feed'),
          ),
        ),
        Expanded(
          child: DuoButton.icon(
            onPressed: switch (_selectedFeeds.isEmpty) {
              true => null,
              false => () {
                  ref.read(userFeedsProvider.notifier).follow(_selectedFeeds);
                },
            },
            iconAlignment: IconAlignment.end,
            icon: const Icon(TablerIcons.arrow_right),
            label: const Text('Done'),
          ),
        ),
      ],
    );
  }
}
