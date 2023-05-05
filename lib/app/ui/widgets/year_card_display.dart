import 'package:flutter/material.dart';
import 'package:upgraded_cgpa_app/app/helpers/int_to_position.dart';
import 'package:upgraded_cgpa_app/app/models/year_result.dart';

class YearCardDisplay extends StatelessWidget {
  final YearResult result;

  const YearCardDisplay({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Theme.of(context).textTheme.bodyLarge!.color,
      title: Text('${intToPosition(result.year)} year'),
    );
  }
}
