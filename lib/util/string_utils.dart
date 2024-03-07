String? shortenName(String? name) {
  return name?.split(" ").reduce((value, element) => '$value ${element[0]}.');
}

String? nameInitials(String? name) {
  return name
      ?.split(" ")
      .reduce((value, element) => '${value[0]}${element[0]}');
}

String toOrdinal(int number) {
  if (number < 0) throw Exception('Invalid Number');

  switch (number % 10) {
    case 1:
      return '${number}st';
    case 2:
      return '${number}nd';
    case 3:
      return '${number}rd';
    default:
      return '${number}th';
  }
}
