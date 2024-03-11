import 'dart:math';

String? shortenName(String? name) {
  return name?.split(" ").length == 1
      ? name?.substring(0, min(name.length, 2))
      : name?.split(" ").reduce((value, element) => '$value ${element[0]}.');
}

String? nameInitials(String? name) {
  return name?.split(" ").length == 1
      ? name?.substring(0, min(name.length, 2)).toUpperCase()
      : name
          ?.split(" ")
          .reduce((value, element) => '${value[0]}${element[0]}')
          .toUpperCase();
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
