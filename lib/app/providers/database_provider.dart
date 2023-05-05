import 'package:flutter/cupertino.dart';
import 'package:upgraded_cgpa_app/app/models/year_result.dart';
import 'package:upgraded_cgpa_app/main.dart';

class Database extends ChangeNotifier {
  static final List<YearResult> _mainDatabase = [];

  List<YearResult> get mainDatabase => _mainDatabase;

  addYear() {
    _mainDatabase.add(YearResult(year: _mainDatabase.length + 1));
    notifyListeners();
  }
}
