import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/models/feed_model.dart';
import 'package:nounews_app/providers/feeds_provider.dart';
import 'package:nounews_app/providers/user_feeds_provider.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/routes.dart';
import 'package:nounews_app/view/widgets/common/async_value_widgets.dart';
import 'package:nounews_app/view/widgets/search_bar.dart';

class FeedsSelectionPage extends ConsumerStatefulWidget {
  const FeedsSelectionPage({
    super.key,
    this.isOnboarding = false,
  });

  final bool isOnboarding;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedsSelectionPageState();
}

class _FeedsSelectionPageState extends ConsumerState<FeedsSelectionPage> {
  final Set<int> _selectedFeedsIds = {};

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    ref.read(userFeedsProvider).whenData(
      (feeds) {
        _selectedFeedsIds.addAll(feeds.map((feed) => feed.id));
      },
    );
  }

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
                switch (widget.isOnboarding) {
                  true => "Start by following feeds you're interested in",
                  false => "Foolow feeds you're interested in",
                },
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
                label: Text(feed.title),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                selected: _selectedFeedsIds.contains(feed.id),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedFeedsIds.add(feed.id);
                    } else {
                      _selectedFeedsIds.remove(feed.id);
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
            onPressed: () async {
              final feedId = await context.navigator.pushNamed<int?>(Routes.addFeed);
              ref.invalidate(feedsProvider);

              if (mounted && feedId != null) {
                setState(() => _selectedFeedsIds.add(feedId));
              }
            },
            icon: const Icon(TablerIcons.plus),
            label: const Text('Add a new feed'),
          ),
        ),
        Expanded(
          child: DuoButton.icon(
            onPressed: switch (_selectedFeedsIds.isEmpty) {
              true => null,
              false => () {
                  ref.read(userFeedsProvider.notifier).follow(_selectedFeedsIds);

                  if (!widget.isOnboarding) {
                    context.navigator.pop();
                  }
                },
            },
            iconAlignment: IconAlignment.end,
            icon: switch (widget.isOnboarding) {
              true => const Icon(TablerIcons.arrow_right),
              false => const Icon(TablerIcons.check),
            },
            label: const Text('Done'),
          ),
        ),
      ],
    );
  }
}
