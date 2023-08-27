import 'package:intl/intl.dart';

String? dateToString(DateTime? date) {
  if (date == null) return null;
  return DateFormat('dd/MM/yyyy').format(date);
}

String getFormattedPostDate(String dateString) {
  final date = DateTime.parse(dateString);
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

String mapWeekday(int weekday) {
  switch (weekday) {
    case 1:
      return 'Lunes';
    case 2:
      return 'Martes';
    case 3:
      return 'Miércoles';
    case 4:
      return 'Jueves';
    case 5:
      return 'Viernes';
    case 6:
      return 'Sábado';
    case 7:
      return 'Domingo';
    default:
      return 'Lunes';
  }
}

String getFormattedPostTimeOfDay(String dateString) {
  final date = DateTime.parse(dateString);
  final String extra = () {
    if (date.minute.toString().length == 1) {
      return '0';
    }
    return '';
  }();

  return '${date.hour}:$extra${date.minute}';
}
