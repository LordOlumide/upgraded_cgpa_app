import 'package:flutter/material.dart';
import 'package:upgraded_cgpa_app/app/ui/screens/home_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.screenId:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        throw Exception('Route not found');
    }
  }
}
