import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Size get screenSize => MediaQuery.sizeOf(this);

  NavigatorState get navigator => Navigator.of(this);

  dynamic get _routeArguments => ModalRoute.of(this)?.settings.arguments;

  T routeArgument<T>() {
    final args = _routeArguments;

    if (args is Map) {
      for (final value in args.values) {
        if (value is T) {
          return value;
        }
      }
      throw Exception("No argument of type $T found in route arguments");
    } else {
      return args as T;
    }
  }

  T? routeArgumentByKey<T>(String key) {
    final args = _routeArguments;
    if (args == null) return null;

    if (args is Map) {
      return args[key] as T;
    } else {
      throw Exception("Route arguments is not a Map, maybe use getRouteArgument<T>() instead");
    }
  }
}
