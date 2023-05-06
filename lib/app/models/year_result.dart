import 'package:upgraded_cgpa_app/app/models/course_result.dart';
import 'package:upgraded_cgpa_app/app/models/semester_result.dart';

class YearResult {
  int year;

  YearResult({required this.year});

  SemesterResult firstSem = SemesterResult();
  SemesterResult secondSem = SemesterResult();

  addCourseToFirstSem(CourseResult courseResult) {
    firstSem.add(courseResult);
  }

  addCourseToSecondSem(CourseResult courseResult) {
    secondSem.add(courseResult);
  }

  int get noOfFirstSemCourses => firstSem.courses.length;
  int get noOfSecondSemCourses => secondSem.courses.length;

  double get yearGPA {
    int cumulativeScore = 0;
    int cumulativenoOfUnits = 0;
    for (CourseResult course in firstSem.courses) {
      cumulativeScore += course.gpaScore * course.noOfUnits;
      cumulativenoOfUnits += course.noOfUnits;
    }
    for (CourseResult course in secondSem.courses) {
      cumulativeScore += course.gpaScore * course.noOfUnits;
      cumulativenoOfUnits += course.noOfUnits;
    }
    // if cumulative noOfUnits == 0, 0/0 = NaN
    return cumulativenoOfUnits != 0 ? cumulativeScore / cumulativenoOfUnits : 0;
  }

  bool isEmpty() =>
      firstSem.courses.isEmpty && secondSem.courses.isEmpty ? true : false;
}
