import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgraded_cgpa_app/app/core/app_theme/theme.dart';
import 'package:upgraded_cgpa_app/app/ui/routing/app_router.dart';
import 'package:upgraded_cgpa_app/app/ui/screens/welcome_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

Future<void> main() async {
  // final dir = await getApplicationDocumentsDirectory();
  // final isar = await Isar.open(
  //   [EmailSchema],
  //   directory: dir.path,
  // );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CGPA App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: WelcomeScreen.screenId,
    );
  }
}
