import 'package:flutter/material.dart';
import 'package:upgraded_cgpa_app/app/ui/widgets/input_field.dart';

class CourseInputSheet extends StatelessWidget {
  final bool addNotEdit;
  final TextEditingController courseTitleController;
  final TextEditingController courseNameController;
  final TextEditingController scoreController;
  final TextEditingController unitsController;

  const CourseInputSheet({
    Key? key,
    required this.addNotEdit,
    required this.courseTitleController,
    required this.courseNameController,
    required this.scoreController,
    required this.unitsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          // Header
          Text(
            addNotEdit ? 'Add New Course' : 'Edit Course',
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          const Divider(
            color: Colors.black38,
            thickness: 1.2,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Form(
              child: Column(
                children: [
                  // course title
                  InputField(
                    isFirstField: true,
                    controller: courseTitleController,
                    fieldTitle: 'Course Title',
                    hint: 'e.g. GNS 101',
                    textCapitalization: TextCapitalization.characters,
                    isMarksField: false,
                    isUnitsField: false,
                  ),

                  // courseDescription
                  InputField(
                    isFirstField: false,
                    controller: courseNameController,
                    fieldTitle: 'Course Name',
                    hint: 'e.g. History and Philosophy',
                    textCapitalization: TextCapitalization.words,
                    isMarksField: false,
                    isUnitsField: false,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // marks
                      Expanded(
                        child: InputField(
                          isFirstField: false,
                          controller: scoreController,
                          fieldTitle: 'Score (%)',
                          hint: 'e.g. 75',
                          textCapitalization: TextCapitalization.none,
                          isMarksField: true,
                          isUnitsField: false,
                        ),
                      ),
                      const SizedBox(width: 30),

                      // units
                      Expanded(
                        child: InputField(
                          isFirstField: false,
                          controller: unitsController,
                          fieldTitle: 'No. of Units',
                          hint: 'e.g. 2',
                          textCapitalization: TextCapitalization.none,
                          isMarksField: false,
                          isUnitsField: true,
                        ),
                      ),
                    ],
                  ),

                  // "Add course" button
                  Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        if (Form.of(context).validate()) {
                          Navigator.pop(context, true);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondary),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5)),
                      ),
                      child: Text(
                        addNotEdit ? 'Add Course' : 'Save Edit',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
