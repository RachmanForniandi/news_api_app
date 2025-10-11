
import 'package:intl/intl.dart';
import 'package:news_api_app/services/calendar_data.dart';

extension DateTimeExt on DateTime {








  List<DateTime> get getDaysOfMonth {
    final firstDayOfMonth = DateTime(year, month, 1);
    DateTime firstMondayOfMonth = firstDayOfMonth;

    while (firstMondayOfMonth.weekday != DateTime.monday) {
      firstMondayOfMonth = firstMondayOfMonth.subtract(const Duration(days: 1));
    }

    DateTime firstDayNextMonth = DateTime(year, month + 1, 1);
    final lastDayOfMonth = firstDayNextMonth.subtract(const Duration(days: 1));
    DateTime lastSundayOfMonth = lastDayOfMonth;

    while (lastSundayOfMonth.weekday != DateTime.sunday) {
      lastSundayOfMonth = lastSundayOfMonth.add(const Duration(days: 1));
    }

    List<DateTime> days = [];
    DateTime date = firstMondayOfMonth;
    while (!date.isAfter(lastSundayOfMonth)) {
      days.add(date);
      date = date.add(Duration(days: 1));
    }

    return days;
  }


  String get monthAndYear {
    final formatter = DateFormat("MMMM yyyy");

    return formatter.format(this);
  }

  bool isBeforeDate(DateTime? other) {
    if (other == null) return false;
    final thisDateOnly = DateTime(year, month, day);
    final otherDateOnly = DateTime(other.year, other.month, other.day);

    return thisDateOnly.isBefore(otherDateOnly);
  }

  bool isAfterDate(DateTime? other) {
    if (other == null) return false;
    final thisDateOnly = DateTime(year, month, day);
    final otherDateOnly = DateTime(other.year, other.month, other.day);

    return thisDateOnly.isAfter(otherDateOnly);
  }

  bool isSameDate(DateTime? other) {
    if (other == null) return false;

    final sameYear = year == other.year;
    final sameMonth = month == other.month;
    final sameDay = day == other.day;

    return sameYear && sameMonth && sameDay;
  }

  bool isSameMonth(DateTime other) {
    final sameMonth = month == other.month;
    return sameMonth;
  }

  String format(String format) {
    final formatter = DateFormat(format);
    return formatter.format(this);
  }

  bool isBetween(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return false;
    return isAfter(startDate) && isBefore(endDate);
  }
}

extension ListDateTimeExt on List<DateTime> {
  List<List<DateTime>> chunkDates(int chunkSize) {
    List<List<DateTime>> chunks = [];
    for (var i = 0; i < length; i += chunkSize) {
      int end = (i + chunkSize < length) ? i + chunkSize : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }


}


extension ListCalendarDataExt on List<CalendarData> {
  CalendarData? getCalendarData(DateTime date) {
    CalendarData? data;

    try {
      data = firstWhere((e) {
        return e.date.isSameDate(date);
      });
      return data;
    } catch (e) {
      return data;
    }
  }
}