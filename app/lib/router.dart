import 'package:flutter/material.dart';
import 'package:nounews_app/routes.dart';
import 'package:nounews_app/view/pages/add_feed_page.dart';
import 'package:nounews_app/view/pages/onboarding_page.dart';

Route<T>? onGenerateRoute<T>(RouteSettings settings) => switch (settings.name) {
      Routes.onboarding => MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        ),
      Routes.addFeed => MaterialPageRoute(
          builder: (_) => const AddFeedPage(),
          fullscreenDialog: true,
          //fullscreenDialog: true,
        ),
      _ => null,
    };
