import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/material.dart';
import 'package:nounews_app/res/theme/colors.dart';
import 'package:nounews_app/res/theme/constants.dart';

final lightTheme = _buildTheme(
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,
  secondaryColor: kSecondaryColor,
  surfaceColor: kLightSurfaceColor,
  surfaceContainerColor: kLightSurfaceContainerColor,
  onSurfaceColor: kLightPrimaryTextColor,
  onSurfaceVariantColor: kLightSecondaryTextColor,
  dividerColor: kLightDividerColor,
);

final darkTheme = _buildTheme(
  brightness: Brightness.dark,
  primaryColor: kPrimaryColor,
  secondaryColor: kSecondaryColor,
  surfaceColor: kDarkSurfaceColor,
  surfaceContainerColor: kDarkSurfaceContainerColor,
  onSurfaceColor: kDarkPrimaryTextColor,
  onSurfaceVariantColor: kDarkSecondaryTextColor,
  dividerColor: kDarkDividerColor,
);

ThemeData _buildTheme({
  required Brightness brightness,
  required Color primaryColor,
  required Color secondaryColor,
  required Color surfaceColor,
  required Color surfaceContainerColor,
  required Color onSurfaceColor,
  required Color onSurfaceVariantColor,
  required Color dividerColor,
  String fontFamily = 'FunnelSans',
}) {
  final textTheme = Typography.material2021()
      .black
      .apply(
        fontFamily: fontFamily,
        bodyColor: onSurfaceColor,
        displayColor: onSurfaceColor,
        decorationColor: onSurfaceColor,
      )
      .merge(
        const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontWeight: FontWeight.w500),
        ),
      );

  return ThemeData(
    colorScheme: switch (brightness) {
      Brightness.light => ColorScheme.light(
          primary: primaryColor,
          primaryContainer: primaryColor.withValues(alpha: 0.8),
          onPrimaryContainer: surfaceColor,
          secondary: secondaryColor,
          secondaryContainer: secondaryColor.withValues(alpha: 0.8),
          onSecondaryContainer: surfaceColor,
          surface: surfaceColor,
          surfaceContainer: surfaceContainerColor,
          onSurface: onSurfaceColor,
          onSurfaceVariant: onSurfaceVariantColor,
        ),
      Brightness.dark => ColorScheme.dark(
          primary: primaryColor,
          onPrimaryContainer: surfaceColor,
          secondary: secondaryColor,
          onSecondaryContainer: surfaceColor,
          surface: surfaceColor,
          surfaceContainer: surfaceContainerColor,
          onSurface: onSurfaceColor,
          onSurfaceVariant: onSurfaceVariantColor,
        ),
    },
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      color: surfaceColor,
      titleTextStyle: TextStyle(
        color: onSurfaceColor,
        fontSize: 22,
        fontWeight: FontWeight.w900,
      ),
    ),
    cardTheme: CardTheme(
      color: surfaceColor,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.transparent,
      selectedColor: primaryColor,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      side: BorderSide(color: dividerColor),
    ),
    dividerTheme: DividerThemeData(color: dividerColor),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 42),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
      ),
    ),
    fontFamily: fontFamily,
    iconTheme: IconThemeData(color: onSurfaceColor),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceContainerColor,
      border: WidgetStateInputBorder.resolveWith(
        (states) {
          final isFocused = states.contains(WidgetState.focused);
          final hasError = states.contains(WidgetState.error);

          final (color, width) = switch ((hasError, isFocused)) {
            (true, true) => (Colors.red, 4.0),
            (true, false) => (Colors.red, 2.0),
            (false, true) => (dividerColor, 4.0),
            (false, false) => (dividerColor, 2.0),
          };

          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderSide: BorderSide(color: color, width: width),
          );
        },
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: textTheme.titleMedium,
      subtitleTextStyle: textTheme.titleSmall,
      contentPadding: const EdgeInsets.symmetric(horizontal: kPadding),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      backgroundColor: surfaceColor,
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(color: onSurfaceColor),
      ),
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(color: onSurfaceColor, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor),
        minimumSize: const Size(double.infinity, 42),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
      ),
    ),
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    extensions: <ThemeExtension>{
      DuoButtonThemeExtension(
        style: DuoButton.styleFrom(
          borderRadius: kBorderRadius,
          minimumSize: const Size(double.infinity, 42),
        ),
      ),
      OutlinedDuoButtonThemeExtension(
        style: OutlinedDuoButton.styleFrom(
          borderRadius: kBorderRadius,
        ),
      ),
    },
  );
}
