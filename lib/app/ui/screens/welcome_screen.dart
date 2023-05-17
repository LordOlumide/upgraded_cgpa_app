import 'package:flutter/material.dart';
import 'package:upgraded_cgpa_app/app/ui/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const screenId = 'Welcome screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to CGPA App',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),

                  // Use offline button
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    onPressed: () {
                      Navigator.pushNamed(context, HomeScreen.screenId);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'Use Offline',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
