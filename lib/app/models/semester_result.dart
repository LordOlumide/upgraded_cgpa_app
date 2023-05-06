import 'package:upgraded_cgpa_app/app/models/course_result.dart';

class SemesterResult {
  final List<CourseResult> _courses = [];

  List<CourseResult> get courses => _courses;

  SemesterResult();

  void add(CourseResult courseResult) {
    _courses.add(courseResult);
  }

  void removeCourse(int courseResultIndex) {
    _courses.removeAt(courseResultIndex);
  }

  int get totalNoOfCourses {
    return _courses.length;
  }

  int get totalNoOfnoOfUnits {
    int nOOfnoOfUnits = 0;
    for (CourseResult course in _courses) {
      nOOfnoOfUnits += course.noOfUnits;
    }
    return nOOfnoOfUnits;
  }

  double get semesterGPA {
    int cumulativeScore = 0;
    int cumulativenoOfUnits = 0;
    for (CourseResult course in _courses) {
      cumulativeScore += course.gpaScore * course.noOfUnits;
      cumulativenoOfUnits += course.noOfUnits;
    }
    return cumulativenoOfUnits != 0 ? cumulativeScore / cumulativenoOfUnits : 0;
  }

  @override
  String toString() {
    return 'Semester Results: \n${_courses.map((e) => e.toString())}\n';
  }
}
