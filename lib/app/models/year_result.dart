import 'package:upgraded_cgpa_app/app/models/semester_result.dart';

class YearResult {
  int year;

  YearResult({required this.year});

  SemesterResult firstSem = SemesterResult(isFirstSemester: true);
  SemesterResult secondSem = SemesterResult(isFirstSemester: false);
}
