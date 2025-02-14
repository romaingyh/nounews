import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/providers/timeline_providers.dart';
import 'package:nounews_app/providers/user_feeds_provider.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/routes.dart';
import 'package:nounews_app/view/widgets/common/async_value_widgets.dart';

class TimelineDrawer extends ConsumerWidget {
  const TimelineDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: context.colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Feeds',
                style: context.textTheme.titleLarge,
              ),
              Expanded(
                child: ref.watch(userFeedsProvider).when(
                      error: asyncErrorWidgetBuilder,
                      loading: asyncLoadingWidgetBuilder,
                      data: (feeds) {
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: kPadding),
                          itemCount: feeds.length,
                          separatorBuilder: (_, __) => const SizedBox(height: kPadding / 2),
                          itemBuilder: (BuildContext context, int index) {
                            final feed = feeds[index];

                            final isSelected = !ref.watch(isFeedHiddenProvider(feed));

                            return Align(
                              alignment: Alignment.centerLeft,
                              child: FilterChip(
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    switch (isSelected) {
                                      true => Icon(
                                          TablerIcons.eye,
                                          color: context.colorScheme.onSecondaryContainer,
                                        ),
                                      false => Icon(
                                          TablerIcons.eye_off,
                                          color: context.colorScheme.onSurfaceVariant,
                                        ),
                                    },
                                    const SizedBox(width: kPadding / 2),
                                    Flexible(child: Text(feed.title)),
                                  ],
                                ),
                                side: isSelected ? BorderSide.none : null,
                                selected: isSelected,
                                onSelected: (_) {
                                  ref.read(timelineHiddenFeedsProvider.notifier).toggle(feed.id);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
              DuoButton.icon(
                onPressed: () {
                  context.navigator.pushNamed(Routes.feedsSelection);
                },
                icon: const Icon(TablerIcons.search),
                label: const Text('Explore more feeds'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
