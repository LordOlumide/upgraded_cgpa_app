import 'package:flutter/cupertino.dart';
import 'package:upgraded_cgpa_app/app/dummy_courses.dart';
import 'package:upgraded_cgpa_app/app/models/course_result.dart';
import 'package:upgraded_cgpa_app/app/models/year_result.dart';

class Database extends ChangeNotifier {
  static final List<YearResult> _mainDatabase = [];

  List<YearResult> get mainDatabase => _mainDatabase;

  void initialize([bool withDummyData = false]) {
    addDummyData();
  }

  addNewYear() {
    _mainDatabase.add(YearResult(year: _mainDatabase.length + 1));
    notifyListeners();
  }

  deleteYear({required int yearResultIndex}) {
    _mainDatabase.removeAt(yearResultIndex);
    for (YearResult yearResult in _mainDatabase) {
      yearResult.year = _mainDatabase.indexOf(yearResult) + 1;
    }
    notifyListeners();
  }

  addYear() {
    _mainDatabase.add(YearResult(year: _mainDatabase.length + 1));
    notifyListeners();
  }

  double get currentCGPA {
    int cumulativeScore = 0;
    int cumulativeUnits = 0;
    for (YearResult year in _mainDatabase) {
      for (CourseResult course in year.firstSem.courses) {
        cumulativeScore += course.gpaScore * course.noOfUnits;
        cumulativeUnits += course.noOfUnits;
      }
      for (CourseResult course in year.secondSem.courses) {
        cumulativeScore += course.gpaScore * course.noOfUnits;
        cumulativeUnits += course.noOfUnits;
      }
    }
    // if cumulative units == 0, 0/0 = NaN
    return cumulativeUnits != 0 ? cumulativeScore / cumulativeUnits : 0;
  }

  Future<void> addCourse({
    required CourseResult newCourse,
    required int yearResultIndex,
    required bool isFirstSemester,
  }) async {
    isFirstSemester == true
        ? _mainDatabase[yearResultIndex].addCourseToFirstSem(newCourse)
        : _mainDatabase[yearResultIndex].addCourseToSecondSem(newCourse);

    notifyListeners();
  }

  Future<void> editCourse({
    required CourseResult newCourse,
    required int yearResultIndex,
    required bool isFirstSemester,
    required int courseResultIndex,
  }) async {
    isFirstSemester == true
        ? _mainDatabase[yearResultIndex]
            .firstSem
            .courses[courseResultIndex]
            .updateCourse(newCourse: newCourse)
        : _mainDatabase[yearResultIndex]
            .secondSem
            .courses[courseResultIndex]
            .updateCourse(newCourse: newCourse);

    notifyListeners();
  }

  Future<void> deleteCourse({
    required int yearResultIndex,
    required bool isFirstSemester,
    required int courseResultIndex,
    required String courseToDeleteID,
  }) async {
    isFirstSemester == true
        ? _mainDatabase[yearResultIndex]
            .firstSem
            .removeCourse(courseResultIndex)
        : _mainDatabase[yearResultIndex]
            .secondSem
            .removeCourse(courseResultIndex);

    notifyListeners();
  }

  void addDummyData() {
    // add more dummy data
    for (int i = 0; i < dummyResults.length; i += 2) {
      addNewYear();
      for (CourseResult dummyCourse in dummyResults[i]) {
        addCourse(
          newCourse: dummyCourse,
          yearResultIndex: _mainDatabase.length - 1,
          isFirstSemester: true,
        );
      }
      for (CourseResult dummyCourse in dummyResults[i + 1]) {
        addCourse(
          newCourse: dummyCourse,
          yearResultIndex: _mainDatabase.length - 1,
          isFirstSemester: false,
        );
      }
    }
  }
}
