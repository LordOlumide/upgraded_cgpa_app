import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color lightPrimaryColor = const Color(0xffd5f8cc);
  static Color lightSecondaryColor = const Color(0xffdfe5ff);
  static Color lightBackgroundColor = const Color(0xffc7c7c7);
  static Color lightFloatingActionButtonColor = const Color(0xffb3cef8);
  static Color lightScaffoldBackgroundColor = const Color(0xfffefff2);
  static Color lightTextColor = Colors.black87;
  static Color lightGreenColor = Colors.green;

  static Color darkPrimaryColor = const Color(0xFF232323);
  static Color darkSecondaryColor = const Color(0xFF7700b2);
  static Color darkBackgroundColor = const Color(0xffbcbcbc);
  static Color darkFloatingActionButtonColor = const Color(0xFFb41eff);
  static Color darkGreenColor = Colors.green[300]!;

  const AppTheme._();

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  static ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: lightPrimaryColor,
      secondary: lightSecondaryColor,
      background: lightBackgroundColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightFloatingActionButtonColor,
    ),
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.white),
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: darkPrimaryColor,
      secondary: darkSecondaryColor,
      background: darkBackgroundColor,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.black),
    ),
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkFloatingActionButtonColor,
    ),
  );

  static setStatusAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? lightBackgroundColor
          : darkBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  static void refreshSystemOverlay() {
    AppTheme.currentSystemBrightness == Brightness.light
        ? AppTheme.setStatusAndNavigationBarColors(ThemeMode.light)
        : AppTheme.setStatusAndNavigationBarColors(ThemeMode.dark);
  }
}

extension ThemeExtension on ThemeData {
  Color get approvalGreenColor => this.brightness == Brightness.light
      ? AppTheme.lightGreenColor
      : AppTheme.darkGreenColor;
}
