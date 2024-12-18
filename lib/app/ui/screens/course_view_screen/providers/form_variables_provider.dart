import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgraded_cgpa_app/app/models/course_result.dart';

final formVariablesProvider = Provider.autoDispose<FormVariables>((ref) {
  FormVariables variables = FormVariables()..initializeControllers();
  ref.onDispose(() {
    variables.disposeControllers();
  });
  return variables;
});

class FormVariables {
  // TextEditingControllers
  late TextEditingController courseTitleController;
  late TextEditingController courseNameController;
  late TextEditingController scoreController;
  late TextEditingController unitsController;

  initializeControllers() {
    courseTitleController = TextEditingController();
    courseNameController = TextEditingController();
    scoreController = TextEditingController();
    unitsController = TextEditingController();
  }

  manuallyAssign({
    required String courseTitle,
    required String courseName,
    required String score,
    required String noOfUnits,
  }) {
    courseTitleController.text = courseTitle;
    courseNameController.text = courseName;
    scoreController.text = score;
    unitsController.text = noOfUnits;
  }

  disposeControllers() {
    courseTitleController.dispose();
    courseNameController.dispose();
    scoreController.dispose();
    unitsController.dispose();
  }

  resetControllers() {
    courseTitleController.clear();
    courseNameController.clear();
    scoreController.clear();
    unitsController.clear();
  }

  CourseResult toCourse({String? uniqueID}) {
    return CourseResult(
      uniqueId: uniqueID,
      courseTitle: courseTitleController.text,
      courseName: courseNameController.text,
      score: double.parse(scoreController.text).toInt(),
      noOfUnits: double.parse(unitsController.text).toInt(),
    );
  }

  @override
  String toString() {
    return 'title: ${courseTitleController.text}, '
        'name: ${courseNameController.text}, '
        'score: ${scoreController.text}, '
        'units: ${unitsController.text}';
  }
}
