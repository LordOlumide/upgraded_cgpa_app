import 'package:upgraded_cgpa_app/app/utils/uuid_generator.dart';

class CourseResult {
  String? uniqueId;
  String courseTitle;
  String courseName;
  int score;
  int noOfUnits;
  // The following properties autoAssign on creation and refresh on edit
  late int gpaScore;
  late String grade;

  CourseResult({
    this.uniqueId,
    required this.courseTitle,
    required this.courseName,
    required this.score,
    required this.noOfUnits,
  }) {
    uniqueId = uniqueId ?? generateTimeBasedId();
    updateGradeAndGpaScore();
  }

  updateGradeAndGpaScore() {
    if (score < 40) {
      grade = 'F';
      gpaScore = 0;
    } else if (score < 45) {
      grade = 'E';
      gpaScore = 1;
    } else if (score < 50) {
      grade = 'D';
      gpaScore = 2;
    } else if (score < 60) {
      grade = 'C';
      gpaScore = 3;
    } else if (score < 70) {
      grade = 'B';
      gpaScore = 4;
    } else {
      grade = 'A';
      gpaScore = 5;
    }
  }

  updateCourse({required CourseResult newCourse}) {
    courseTitle = newCourse.courseTitle;
    courseName = newCourse.courseName;
    score = newCourse.score;
    noOfUnits = newCourse.noOfUnits;
    updateGradeAndGpaScore();
  }

  factory CourseResult.fromMap(Map<String, dynamic> json) => CourseResult(
        courseTitle: json['courseTitle'],
        courseName: json['courseName'],
        score: json['score'],
        noOfUnits: json['noOfnoOfUnits'],
      );

  Map<String, dynamic> toMap() => {
        'courseTitle': courseTitle,
        'courseName': courseName,
        'score': score,
        'noOfnoOfUnits': noOfUnits,
      };

  @override
  String toString() {
    return '{courseTitle: $courseTitle, courseName: $courseName, '
        'score: $score, noOfnoOfUnits: $noOfUnits, gpaScore: $gpaScore, grade: $grade}';
  }
}
