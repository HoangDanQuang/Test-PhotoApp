import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static String toLocalDatetime(String? val) {
    if (val == null || val.isEmpty) {
      return '';
    }
    return DateTime.tryParse(val)?.toLocal().toString() ?? '';
  }

  static DateTime? dmyToDateTime(String? val) {
    if (val == null || val.isEmpty) {
      return null;
    }
    List<String> s = val.split('-');
    DateTime dt = DateTime(int.parse(s[2]), int.parse(s[1]), int.parse(s[0]));
    print(dt.toString());
    return dt;
  }

  static bool isToday(String? val) {
    if (val == null || val.isEmpty) {
      return false;
    }
    final dateTime = dmyToDateTime(val);
    if (dateTime == null) return false;
    final today = DateTime.now();
    return today.day == dateTime.day &&
        today.month == dateTime.month &&
        today.year == dateTime.year;
  }

  static bool isYesterday(String? val) {
    if (val == null || val.isEmpty) {
      return false;
    }
    final dateTime = dmyToDateTime(val);
    if (dateTime == null) return false;
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == dateTime.day &&
        yesterday.month == dateTime.month &&
        yesterday.year == dateTime.year;
  }

  static String toLocalDate(String? val) {
    if (val == null || val.isEmpty) {
      return '';
    }
    final t = toLocalDatetime(val);
    return t.substring(0, 10).split('-').reversed.toList().join('-');
  }

  static String toLocalWeekdayDate(String? val) {
    if (val == null || val.isEmpty) {
      return '';
    }
    final dateTime = dmyToDateTime(val);
    if (dateTime == null) return '';
    String result = '';
    if (dateTime.weekday == 7) {
      result = 'CN, ${dateTime.day} Th${dateTime.month}';
    } else {
      result = 'T${dateTime.weekday + 1}, ${dateTime.day} Th${dateTime.month}';
    }
    if (dateTime.year != DateTime.now().year) {
      result = result + ', ${dateTime.year}';
    }
    return result;
  }

  static String toLocalTimeDate(String? val) {
    if (val == null || val.isEmpty) {
      return '';
    }
    final t = toLocalDatetime(val);
    return t.substring(11, 16) +
        ' ' +
        t.substring(0, 10).split('-').reversed.toList().join('-');
  }

  static String toLocalDateTimeString(String? val) {
    if (val == null || val.isEmpty) {
      return '';
    }
    final t = toLocalDatetime(val);
    return t.substring(0, 10).split('-').reversed.toList().join('-') 
        + ' ' + t.substring(11, 16);
  }

  static String toLocalHourDateMonth(String val) {
    if (val == null || val.isEmpty) {
      return '';
    }
    final t = toLocalDatetime(val);
    return t.substring(11, 16) +
        ' ' +
        t.substring(5, 10).split('-').reversed.toList().join('-');
  }

  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
