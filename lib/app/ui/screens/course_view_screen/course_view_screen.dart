import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgraded_cgpa_app/app/data/riverpod_providers/database_provider.dart';
import 'package:upgraded_cgpa_app/app/models/course_result.dart';
import 'package:upgraded_cgpa_app/app/models/semester_result.dart';
import 'package:upgraded_cgpa_app/app/ui/screens/course_view_screen/course_states_provider.dart';
import 'package:upgraded_cgpa_app/app/ui/screens/course_view_screen/form_variables_provider.dart';
import 'package:upgraded_cgpa_app/app/ui/widgets/course_card_display.dart';
import 'package:upgraded_cgpa_app/app/ui/widgets/course_input_sheet.dart';
import 'package:upgraded_cgpa_app/app/ui/widgets/delete_popup.dart';
import 'package:upgraded_cgpa_app/app/utils/int_to_position.dart';

class CourseScreen extends ConsumerStatefulWidget {
  static const screenId = 'Course screen';
  final int yearResultIndex;
  final bool isFirstSemester;

  const CourseScreen({
    Key? key,
    required this.yearResultIndex,
    required this.isFirstSemester,
  }) : super(key: key);

  @override
  ConsumerState<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends ConsumerState<CourseScreen> {
  final courseSelectionStatesProvider =
      StateNotifierProvider.autoDispose<CourseSelectionStates, List<bool>>(
    (ref) {
      final int noOfCourses = ref.read(databaseProvider).length;
      return CourseSelectionStates(noOfCourses);
    },
  );

  bool inSelectionMode = false;

  void refreshStatesList() {
    ref.invalidate(courseSelectionStatesProvider);
  }

  void deactivateInSelectionMode() {
    setState(() {
      inSelectionMode = false;
    });
    refreshStatesList();
  }

  void activateInSelectionMode(int activatingCourseIndex) {
    setState(() {
      inSelectionMode = true;
    });
    ref
        .read(courseSelectionStatesProvider.notifier)
        .toggleStateOfCourse(index: activatingCourseIndex);
  }

  @override
  Widget build(BuildContext context) {
    SemesterResult semesterResult = widget.isFirstSemester == true
        ? ref.watch(databaseProvider)[widget.yearResultIndex].firstSem
        : ref.watch(databaseProvider)[widget.yearResultIndex].secondSem;

    /// This stores the input from the course_input_sheet temporarily to be converted to a Course object.
    FormVariables formVariables = ref.watch(formVariablesProvider);
    // TODO: Test this by opening input sheet as edit, inputting data, then
    // opening input sheet as add

    void addNewCourse() {
      CourseResult newCourse = formVariables.toCourse();
      ref.read(databaseProvider.notifier).addCourse(
            newCourse: newCourse,
            yearResultIndex: widget.yearResultIndex,
            isFirstSemester: widget.isFirstSemester,
          );
      refreshStatesList();
    }

    void editCourse({required int courseResultIndex}) {
      String courseToBeReplacedID =
          semesterResult.courses[courseResultIndex].uniqueId!;
      CourseResult newCourse =
          formVariables.toCourse(uniqueID: courseToBeReplacedID);

      ref.read(databaseProvider.notifier).editCourse(
            newCourse: newCourse,
            yearResultIndex: widget.yearResultIndex,
            isFirstSemester: widget.isFirstSemester,
            courseResultIndex: courseResultIndex,
          );
      refreshStatesList();
    }

    /// Have to delete by uniqueID only because index changes during batch-deleting
    void massDelete() {
      List<bool> statesList = ref.read(courseSelectionStatesProvider);
      List<String> uniqueIDsToBeDeleted = [];
      for (int i = 0; i < statesList.length; i++) {
        if (statesList[i] == true) {
          uniqueIDsToBeDeleted.add(semesterResult.courses[i].uniqueId!);
        }
      }
      showDialog<bool>(
        context: context,
        builder: (context) => const DeletePopup(
            objectToDeleteName: 'the selected courses'), // TODO: course(s)
      ).then((value) {
        if (value == true) {
          for (String id in uniqueIDsToBeDeleted) {
            ref.read(databaseProvider.notifier).deleteCourse(
                  yearResultIndex: widget.yearResultIndex,
                  isFirstSemester: widget.isFirstSemester,
                  courseResultIndex: semesterResult.courses
                      .indexWhere((course) => course.uniqueId == id),
                  courseToDeleteID: id,
                );
          }
          deactivateInSelectionMode();
        }
      });
    }

    /// bool addNotEdit is true when this function is called to add a new course
    /// and false when it's called to edit an existing course.
    void bringUpBottomSheet(
        {required bool addNotEdit, required VoidCallback onFormSubmitted}) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: CourseInputSheet(
              addNotEdit: addNotEdit,
              courseTitleController: formVariables.courseTitleController,
              courseNameController: formVariables.courseNameController,
              scoreController: formVariables.scoreController,
              unitsController: formVariables.unitsController,
            ),
          ),
        ),
      ).then((value) {
        if (value == true) {
          onFormSubmitted();
        }
        // Reset the controllers after the screen is dismissed
        formVariables.resetControllers();
      });
    }

    return WillPopScope(
      onWillPop: () async {
        if (inSelectionMode == true) {
          deactivateInSelectionMode();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: inSelectionMode
            ? AppBar(
                toolbarHeight: 50,
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 1,
                title: Text(
                  ref.watch(courseSelectionStatesProvider.notifier
                      .select((provider) => provider.appBarTitle)),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                titleSpacing: 0,
                leading: IconButton(
                  onPressed: () {
                    deactivateInSelectionMode();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                actions: [
                  Checkbox(
                    value: ref.watch(courseSelectionStatesProvider.notifier
                        .select((provider) => provider.allCoursesAreSelected)),
                    activeColor: const Color.fromARGB(255, 101, 199, 121),
                    onChanged: (_) {
                      ref
                          .read(courseSelectionStatesProvider.notifier)
                          .toggleAllCoursesAreSelected();
                    },
                  )
                ],
              )
            : AppBar(
                toolbarHeight: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 0,
              ),
        body: SafeArea(
          child: Column(
            children: [
              Material(
                elevation: 1,
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  padding: inSelectionMode
                      ? const EdgeInsets.fromLTRB(30, 5, 10, 10)
                      : const EdgeInsets.fromLTRB(30, 40, 10, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Year
                      Text(
                        '${intToPosition(widget.yearResultIndex + 1)} Year',
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Text(
                            widget.isFirstSemester == true
                                ? '1st Semester: '
                                : '2nd Semester: ',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${semesterResult.courses.length} '
                            '${semesterResult.courses.length == 1 ? 'course' : 'courses'}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text(
                            'Semester GPA: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            semesterResult.semesterGPA.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30, top: 5),
                      child: Text(
                        'Courses: ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Courses
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 80, top: 6),
                        itemCount: semesterResult.courses.length,
                        itemBuilder: (context, courseIndex) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: CourseCard(
                                yearResultIndex: widget.yearResultIndex,
                                isFirstSemester: widget.isFirstSemester,
                                courseResultIndex: courseIndex,
                                inSelectionMode: inSelectionMode,
                                isSelected: ref.watch(
                                    courseSelectionStatesProvider)[courseIndex],
                                onNormalModeTap: () {
                                  // set the controller values to the course values
                                  CourseResult initialCourseResult =
                                      semesterResult.courses[courseIndex];
                                  formVariables.manuallyAssign(
                                    courseTitle:
                                        initialCourseResult.courseTitle,
                                    courseName: initialCourseResult.courseName,
                                    score: '${initialCourseResult.score}',
                                    noOfUnits:
                                        '${initialCourseResult.noOfUnits}',
                                  );
                                  bringUpBottomSheet(
                                    addNotEdit: false,
                                    onFormSubmitted: () {
                                      editCourse(
                                          courseResultIndex: courseIndex);
                                    },
                                  );
                                },
                                onSelectionModeTap: () {
                                  ref
                                      .read(courseSelectionStatesProvider
                                          .notifier)
                                      .toggleStateOfCourse(index: courseIndex);
                                },
                                onLongPress: (int activatingCourseIndex) {
                                  if (inSelectionMode == false) {
                                    activateInSelectionMode(
                                        activatingCourseIndex);
                                  }
                                }),
                          );
                        },
                      ),
                    ),

                    const Divider(
                      height: 1.2,
                      thickness: 1.2,
                      color: Color.fromARGB(95, 136, 136, 136),
                    ),
                    inSelectionMode
                        ? Container(
                            height: 60,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Center(
                              child: IconButton(
                                padding: const EdgeInsets.all(3),
                                onPressed: () {
                                  massDelete();
                                },
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                                iconSize: 25,
                                icon: Column(
                                  children: [
                                    const Icon(Icons.delete_outline),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: inSelectionMode == false
            ? FloatingActionButton(
                onPressed: () {
                  bringUpBottomSheet(
                    addNotEdit: true,
                    onFormSubmitted: () {
                      addNewCourse();
                    },
                  );
                },
                tooltip: 'Add Course',
                child: const Icon(Icons.add, size: 30),
              )
            : const SizedBox(),
      ),
    );
  }
}
