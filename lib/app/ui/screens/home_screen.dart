import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upgraded_cgpa_app/app/core/theme.dart';
import 'package:upgraded_cgpa_app/app/providers/database_provider.dart';
import 'package:upgraded_cgpa_app/app/ui/widgets/year_card_display.dart';

class HomeScreen extends StatelessWidget {
  static const screenId = 'Home screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Material(
              elevation: 2,
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'CGPA Calculator',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        children: [
                          const TextSpan(text: 'Your CGPA: '),
                          TextSpan(
                            text: Provider.of<Database>(context)
                                .currentCGPA
                                .toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).approvalGreenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Consumer<Database>(
              builder: (context, database, child) {
                return ListView(
                  children: [
                    for (int i = 0; i < database.mainDatabase.length; i++)
                      YearCardDisplay(yearResultIndex: i)
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Provider.of<Database>(context, listen: false).addYear();
        },
      ),
    );
  }
}
