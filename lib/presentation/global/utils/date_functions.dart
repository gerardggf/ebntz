import 'package:ebntz/generated/translations.g.dart';
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
        return texts.global.january;
      case 2:
        return texts.global.february;
      case 3:
        return texts.global.march;
      case 4:
        return texts.global.april;
      case 5:
        return texts.global.may;
      case 6:
        return texts.global.june;
      case 7:
        return texts.global.july;
      case 8:
        return texts.global.august;
      case 9:
        return texts.global.september;
      case 10:
        return texts.global.october;
      case 11:
        return texts.global.november;
      case 12:
        return texts.global.december;
      default:
        return '';
    }
  }();
  if (LocaleSettings.currentLocale == AppLocale.en) {
    return '${date.day} $month ${date.year}';
  }
  return '${date.day} de $month ${date.year}';
}

String mapWeekday(int weekday) {
  switch (weekday) {
    case 1:
      return texts.global.monday;
    case 2:
      return texts.global.tuesday;
    case 3:
      return texts.global.wednesday;
    case 4:
      return texts.global.thursday;
    case 5:
      return texts.global.friday;
    case 6:
      return texts.global.saturday;
    case 7:
      return texts.global.sunday;
    default:
      return '';
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
