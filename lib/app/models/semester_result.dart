import 'package:upgraded_cgpa_app/app/models/course_result.dart';

class SemesterResult {
  final bool isFirstSemester;

  final List<CourseResult> _courses = [];

  List<CourseResult> get courses => _courses;

  SemesterResult({
    required this.isFirstSemester,
  });
}
