import 'package:flutter_riverpod/flutter_riverpod.dart';

/// For each state, false means it's not selected, true means it's selected
class CourseSelectionStates extends StateNotifier<List<bool>> {
  CourseSelectionStates(
    int noOfCourses,
  ) : super([]) {
    // To initialize the state false * noOfCourses
    for (int i = 0; i < noOfCourses; i++) {
      state.add(false);
    }
    state = [...state];
  }

  String get appBarTitle {
    if (selectedCardCount < 0) {
      throw Exception('Exception: CourseSelectionStates.selectedCardCount < 0');
    } else if (selectedCardCount == 0) {
      return '';
    } else if (selectedCardCount == 1) {
      return '$selectedCardCount course selected';
    } else {
      return '$selectedCardCount courses selected';
    }
  }

  bool get allCoursesAreSelected {
    bool returnValue = true;
    for (bool i in state) {
      if (i == false) {
        returnValue = false;
      }
    }
    return returnValue;
  }

  int get selectedCardCount {
    int count = 0;
    for (bool i in state) {
      if (i == true) {
        count++;
      }
    }
    return count;
  }

  toggleStateOfCourse({required int index}) {
    state[index] = !state[index];
    state = [...state];
  }

  void toggleAllCoursesAreSelected() {
    bool newState = !allCoursesAreSelected;
    for (int i = 0; i < state.length; i++) {
      state[i] = newState;
    }
    state = [...state];
  }
}
