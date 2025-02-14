import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/providers/user_feeds_provider.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';
import 'package:nounews_app/view/pages/feeds_selection_page.dart';
import 'package:nounews_app/view/pages/timeline_page.dart';
import 'package:nounews_app/view/widgets/common/async_value_widgets.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: context.colorScheme.surface,
      child: AnimatedSwitcher(
        duration: kMediumAnimationDuration,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: ref.watch(userFeedsProvider).when(
              loading: asyncLoadingWidgetBuilder,
              error: asyncErrorWidgetBuilder,
              data: (feeds) {
                if (feeds.isEmpty) {
                  return const FeedsSelectionPage(isOnboarding: true);
                }

                return const TimelinePage();
              },
            ),
      ),
    );
  }
}
