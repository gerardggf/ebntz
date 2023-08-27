import 'package:intl/intl.dart';

String? dateToString(DateTime? date) {
  if (date == null) return null;
  return DateFormat('dd/MM/yyyy').format(date);
}

DateTime stringToDate(String stringDate) {
  return DateTime(
    int.parse(
      '${stringDate[6]}${stringDate[7]}${stringDate[8]}${stringDate[9]}',
    ),
    int.parse(
      '${stringDate[3]}${stringDate[4]}',
    ),
    int.parse(
      '${stringDate[0]}${stringDate[1]}',
    ),
    int.parse(
      '${stringDate[11]}${stringDate[12]}',
    ),
    int.parse(
      '${stringDate[14]}${stringDate[15]}',
    ),
  );
}

String getFormattedPostDate(String dateString) {
  final date = stringToDate(dateString);
  final month = () {
    switch (date.month) {
      case 1:
        return 'enero';
      case 2:
        return 'febrero';
      case 3:
        return 'marzo';
      case 4:
        return 'abril';
      case 5:
        return 'mayo';
      case 6:
        return 'junio';
      case 7:
        return 'julio';
      case 8:
        return 'agosto';
      case 9:
        return 'septiembre';
      case 10:
        return 'octubre';
      case 11:
        return 'noviembre';
      case 12:
        return 'diciembre';
    }
  }();
  return '${date.day} de $month ${date.year}';
}

String getFormattedPostTimeOfDay(String dateString) {
  final date = stringToDate(dateString);
  final String extra = () {
    if (date.minute.toString().length == 1) {
      return '0';
    }
    return '';
  }();

  return '${date.hour}:$extra${date.minute}';
}
