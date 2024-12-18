import 'package:isar/isar.dart';

/// Storage reference format
///   = "Y-$YearResultIndex - S-${isFirstSemester ? 1 : 2} - C-${courseResult.uniqueId}"
/// Example: "Y-0 S-2 C-XXXXXXXXXXXXXXXXX" refers to a course in 1st year, 2nd semester
class IsarDBManager {
  void init() {}
}
