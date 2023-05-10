String intToPosition(int number) {
  if (number == 1) {
    return '1st';
  } else if (number == 2) {
    return '2nd';
  } else if (number == 3) {
    return '3rd';
  } else if (number >= 4) {
    return '${number}th';
  } else {
    throw Exception('Number is less than 1');
  }
}
