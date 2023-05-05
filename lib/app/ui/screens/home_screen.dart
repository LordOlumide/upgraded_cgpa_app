import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upgraded_cgpa_app/app/providers/database_provider.dart';
import 'package:upgraded_cgpa_app/app/ui/widgets/year_card_display.dart';

class HomeScreen extends StatelessWidget {
  static const screenId = 'Home screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Material(
              elevation: 3,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'CGPA Calculator',
                      style: TextStyle(fontSize: 26),
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
                    for (int i = 0;
                        i < Provider.of<Database>(context).mainDatabase.length;
                        i++)
                      YearCardDisplay(
                          result:
                              Provider.of<Database>(context).mainDatabase[i])
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
          print(Provider.of<Database>(context, listen: false)
              .mainDatabase
              .length);
        },
      ),
    );
  }
}
