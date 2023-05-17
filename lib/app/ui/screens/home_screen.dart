import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgraded_cgpa_app/app/core/app_theme/theme.dart';
import 'package:upgraded_cgpa_app/app/data/riverpod_providers/database_provider.dart';
import 'package:upgraded_cgpa_app/app/ui/widgets/year_card_display.dart';

class HomeScreen extends ConsumerWidget {
  static const screenId = 'Home screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
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
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                          children: [
                            const TextSpan(text: 'Your CGPA: '),
                            TextSpan(
                              text: ref
                                  .watch(databaseProvider.notifier.select(
                                      (provider) => provider.currentCGPA))
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: ListView(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  children: [
                    for (int i = 0; i < ref.watch(databaseProvider).length; i++)
                      YearCardDisplay(
                        yearResultIndex: i,
                        deleteThisYear: () {
                          // TODO: implement delete middle year by index
                          ref.read(databaseProvider.notifier).deleteYear();
                        },
                      )
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1.5,
              thickness: 1.5,
              color: Colors.black54,
            ),

            // "Add New Year" button
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: ElevatedButton(
                onPressed: () {
                  ref.watch(databaseProvider.notifier).addNewYear();
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context)
                          .floatingActionButtonTheme
                          .backgroundColor!),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                child: Text(
                  'Add New Year',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
