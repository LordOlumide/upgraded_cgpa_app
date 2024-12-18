/// Storage reference format
///   = "Y-$YearResultIndex - S-${isFirstSemester ? 1 : 2} - C-${courseResult.uniqueId}"
/// Example: "Y-0 S-2 C-XXXXXXXXXXXXXXXXX" refers to a course in 1st year, 2nd semester
String getReference(
    {required int yearResultIndex,
    required bool isFirstSemester,
    required String courseUniqueID}) {
  return 'Y-$yearResultIndex S-${isFirstSemester ? 1 : 2} C-$courseUniqueID';
}
