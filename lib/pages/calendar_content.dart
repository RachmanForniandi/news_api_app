import 'package:flutter/material.dart';
import 'package:news_api_app/pages/calendar_widget.dart';
import 'package:news_api_app/services/calendar_data.dart';
import 'package:news_api_app/services/calendar_utils.dart';

class CalendarContent extends StatelessWidget {
  const CalendarContent({
    super.key,
    required this.yearMonth,
    this.selectedStartDate,
    this.selectedEndDate,
    this.onStartDateSelected,
    this.onEndDateSelected,
    this.singleSelectionMode = false,
    this.calendarData,
    this.disableSelection,
  });

  final DateTime yearMonth;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final void Function(DateTime)? onStartDateSelected;
  final void Function(DateTime?)? onEndDateSelected;
  final bool singleSelectionMode;
  final List<CalendarData>? calendarData;
  final bool Function(DateTime)? disableSelection;

 @override
  Widget build(BuildContext context) {
    final dates = yearMonth.getDaysOfMonth;
    final weeks = dates.chunkDates(7);

    return Column(
      children: [
        CalendarDayOfWeek(),
        ...weeks.map((week) {
          return Row(
            children: week.map((date) {
              return CalendarDateItem(
                date: date,
                yearMonth: yearMonth,
                selectedStartDate: selectedStartDate,
                selectedEndDate: selectedEndDate,
                onStartDateSelected: onStartDateSelected,
                onEndDateSelected: onEndDateSelected,
                singleSelectionMode: singleSelectionMode,
                calendarData: calendarData,
                disableSelection: disableSelection,
              );
            }).toList(),
          );
        }),
      ],
    );
  }

}