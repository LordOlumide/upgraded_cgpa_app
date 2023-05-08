import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgraded_cgpa_app/app/models/course_result.dart';
import 'package:upgraded_cgpa_app/app/data/riverpod_providers/database_state_notifier.dart';

class CourseCard extends ConsumerWidget {
  final int yearResultIndex;
  final bool isFirstSemester;
  final int courseResultIndex;

  const CourseCard({
    Key? key,
    required this.yearResultIndex,
    required this.isFirstSemester,
    required this.courseResultIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CourseResult courseResult = isFirstSemester == true
        ? ref
            .watch(databaseProvider)[yearResultIndex]
            .firstSem
            .courses[courseResultIndex]
        : ref
            .watch(databaseProvider)[yearResultIndex]
            .secondSem
            .courses[courseResultIndex];

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 4, 10, 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course title
                Text(
                  courseResult.courseTitle,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 1),

                // Course name
                Text(
                  courseResult.courseName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // noOfUnits
                    Text(
                      'noOfUnits: ${courseResult.noOfUnits}',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),

                    // Score
                    Text(
                      'Score: ${courseResult.score}',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),

                    // Grade
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        children: [
                          const TextSpan(text: 'Grade: '),
                          TextSpan(
                            text: courseResult.grade,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
