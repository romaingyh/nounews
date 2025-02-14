import 'package:flutter/material.dart';
import 'package:nounews_app/routes.dart';
import 'package:nounews_app/view/pages/add_feed_page.dart';
import 'package:nounews_app/view/pages/feeds_selection_page.dart';
import 'package:nounews_app/view/pages/onboarding_page.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) => switch (settings.name) {
      Routes.onboarding => MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
          settings: settings,
        ),
      Routes.feedsSelection => MaterialPageRoute(
          builder: (_) => const FeedsSelectionPage(),
          settings: settings,
          fullscreenDialog: true,
        ),
      Routes.addFeed => MaterialPageRoute<int?>(
          builder: (_) => const AddFeedPage(),
          settings: settings,
          fullscreenDialog: true,
        ),
      _ => null,
    };
