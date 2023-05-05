import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upgraded_cgpa_app/app/core/theme.dart';
import 'package:upgraded_cgpa_app/app/providers/database_provider.dart';
import 'package:upgraded_cgpa_app/app/ui/routing/app_router.dart';
import 'package:upgraded_cgpa_app/app/ui/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Database(),
        ),
      ],
      child: MaterialApp(
        title: 'CGPA App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: HomeScreen.screenId,
      ),
    );
  }
}
