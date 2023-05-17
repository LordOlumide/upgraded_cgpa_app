import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgraded_cgpa_app/app/dummy_courses.dart';
import 'package:upgraded_cgpa_app/app/models/course_result.dart';
import 'package:upgraded_cgpa_app/app/models/year_result.dart';

final databaseProvider = StateNotifierProvider<Database, List<YearResult>>(
  (ref) => Database()..initialize(),
);

/// Note: To change the state of anything, the state variable must be
/// reassigned. Not just changed. Reassigned. Cos StateNotifier should not
/// provider mutable state. So add this line to every function that changes
/// the state: """state = [...state];"""
class Database extends StateNotifier<List<YearResult>> {
  Database() : super([]);

  void initialize() {
    addDummyData();
  }

  void addNewYear() {
    state.add(YearResult(year: state.length + 1));
    state = [...state];
  }

  void deleteYear() {
    state.removeLast();
    state = [...state];
  }

  double get currentCGPA {
    int cumulativeScore = 0;
    int cumulativeUnits = 0;
    for (YearResult year in state) {
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

  void addCourse({
    required CourseResult newCourse,
    required int yearResultIndex,
    required bool isFirstSemester,
  }) async {
    isFirstSemester == true
        ? state[yearResultIndex].addCourseToFirstSem(newCourse)
        : state[yearResultIndex].addCourseToSecondSem(newCourse);
    state = [...state];
  }

  void editCourse({
    required CourseResult newCourse,
    required int yearResultIndex,
    required bool isFirstSemester,
    required int courseResultIndex,
  }) async {
    isFirstSemester == true
        ? state[yearResultIndex]
            .firstSem
            .courses[courseResultIndex]
            .updateCourse(newCourse: newCourse)
        : state[yearResultIndex]
            .secondSem
            .courses[courseResultIndex]
            .updateCourse(newCourse: newCourse);
    state = [...state];
  }

  void deleteCourse({
    required int yearResultIndex,
    required bool isFirstSemester,
    required int courseResultIndex,
    required String courseToDeleteID,
  }) async {
    isFirstSemester == true
        ? state[yearResultIndex].firstSem.removeCourse(courseResultIndex)
        : state[yearResultIndex].secondSem.removeCourse(courseResultIndex);
    state = [...state];
  }

  void addDummyData() {
    // add more dummy data
    for (int i = 0; i < dummyResults.length; i += 2) {
      addNewYear();
      for (CourseResult dummyCourse in dummyResults[i]) {
        addCourse(
          newCourse: dummyCourse,
          yearResultIndex: state.length - 1,
          isFirstSemester: true,
        );
      }
      for (CourseResult dummyCourse in dummyResults[i + 1]) {
        addCourse(
          newCourse: dummyCourse,
          yearResultIndex: state.length - 1,
          isFirstSemester: false,
        );
      }
    }
  }
}
