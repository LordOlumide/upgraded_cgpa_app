import 'package:flutter/material.dart';
import 'package:upgraded_cgpa_app/app/ui/screens/course_view_screen/course_view_screen.dart';
import 'package:upgraded_cgpa_app/app/ui/screens/home_screen.dart';
import 'package:upgraded_cgpa_app/app/ui/screens/semester_view_screen.dart';
import 'package:upgraded_cgpa_app/app/ui/screens/welcome_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.screenId:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());

      case HomeScreen.screenId:
        return MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        });

      case SemesterScreen.screenId:
        int argument = settings.arguments as int;

        return MaterialPageRoute(
            builder: (context) => SemesterScreen(yearResultIndex: argument));

      case CourseScreen.screenId:
        Map argumentsMap = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (context) => CourseScreen(
                  yearResultIndex: argumentsMap['yearResultIndex'],
                  isFirstSemester: argumentsMap['isFirstSemester'],
                ));

      default:
        throw Exception('Route not found!');
    }
  }
}
