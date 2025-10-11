import 'package:flutter/material.dart';
import 'package:news_api_app/pages/calendar_content.dart';
import 'package:news_api_app/pages/calendar_header.dart';
import 'package:news_api_app/services/calendar_data.dart';
import 'package:news_api_app/services/calendar_utils.dart';


class CalendarWidget extends StatefulWidget {
  const CalendarWidget._({
    super.key,
    this.singleSelectionMode = false,
    this.initialYearMonth,
    this.selectedStartDate,
    this.selectedEndDate,
    this.onStartDateSelected,
    this.onEndDateSelected,
    this.calendarData,
    this.disableSelection,
  });

  final bool singleSelectionMode;
  final DateTime? initialYearMonth;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final void Function(DateTime)? onStartDateSelected;
  final void Function(DateTime?)? onEndDateSelected;
  final List<CalendarData>? calendarData;
  final bool Function(DateTime)? disableSelection;

  factory CalendarWidget.single({
    Key? key,
    DateTime? initialYearMonth,
    DateTime? selectedDate,
    void Function(DateTime)? onDateSelected,
    List<CalendarData>? calendarData,
    bool Function(DateTime)? disableSelection,
  }) {
    return CalendarWidget._(
      key: key,
      singleSelectionMode: true,
      initialYearMonth: initialYearMonth,
      selectedStartDate: selectedDate,
      onStartDateSelected: onDateSelected,
      calendarData: calendarData,
      disableSelection: disableSelection,
    );
  }

  factory CalendarWidget.range({
    Key? key,
    DateTime? initialYearMonth,
    DateTime? selectedStartDate,
    DateTime? selectedEndDate,
    void Function(DateTime)? onStartDateSelected,
    void Function(DateTime?)? onEndDateSelected,
    List<CalendarData>? calendarData,
    bool Function(DateTime)? disableSelection,
  }) {
    return CalendarWidget._(
      key: key,
      singleSelectionMode: false,
      initialYearMonth: initialYearMonth,
      selectedStartDate: selectedStartDate,
      selectedEndDate: selectedEndDate,
      onStartDateSelected: onStartDateSelected,
      onEndDateSelected: onEndDateSelected,
      calendarData: calendarData,
      disableSelection: disableSelection,
    );
  }
  
  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();



  
}

// Define the missing state class
class _CalendarWidgetState extends State<CalendarWidget> {
  final yearMonthNotifier = ValueNotifier(DateTime.now());

  @override
  void initState() {
    if (widget.initialYearMonth != null) {
      yearMonthNotifier.value = widget.initialYearMonth ?? DateTime.now();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder(
        valueListenable: yearMonthNotifier,
        builder: (context, yearMonth, child) {
          return Column(
            spacing: 16,
            children: [
              CalendarHeader(
                yearMonth: yearMonth,
                onPreviousMonth: (date) {
                  yearMonthNotifier.value = date;
                },
                onNextMonth: (date) {
                  yearMonthNotifier.value = date;
                },
              ),
              CalendarContent(
                yearMonth: yearMonth,
                selectedStartDate: widget.selectedStartDate,
                selectedEndDate: widget.selectedEndDate,
                onStartDateSelected: widget.onStartDateSelected,
                onEndDateSelected: widget.onEndDateSelected,
                singleSelectionMode: widget.singleSelectionMode,
                calendarData: widget.calendarData,
                disableSelection: widget.disableSelection,
              ),
            ],
          );
        },
      ),
    );
  }

}




class CalendarDayOfWeek extends StatefulWidget {
  const CalendarDayOfWeek({super.key});

  @override
  State<CalendarDayOfWeek> createState() => _CalendarDayOfWeekState();
}

class _CalendarDayOfWeekState extends State<CalendarDayOfWeek> {
  final daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: daysOfWeek.map((day) {
        return Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: Text(
              day,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CalendarDateItem extends StatefulWidget {
  const CalendarDateItem({
    super.key,
    required this.date,
    required this.yearMonth,
    this.selectedStartDate,
    this.selectedEndDate,
    this.onStartDateSelected,
    this.onEndDateSelected,
    this.singleSelectionMode = false,
    this.calendarData,
    this.disableSelection,
  });

  final DateTime date;
  final DateTime yearMonth;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final void Function(DateTime)? onStartDateSelected;
  final void Function(DateTime?)? onEndDateSelected;
  final bool singleSelectionMode;
  final List<CalendarData>? calendarData;
  final bool Function(DateTime)? disableSelection;

  @override
  State<CalendarDateItem> createState() => _CalendarDateItemState();
}


class _CalendarDateItemState extends State<CalendarDateItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (widget.disableSelection?.call(widget.date) == true) return;
          if (widget.singleSelectionMode) {
            widget.onStartDateSelected?.call(widget.date);
          } else {
            if (widget.selectedStartDate == null ||
                (widget.selectedEndDate != null &&
                    (widget.date.isBefore(widget.selectedStartDate!) ||
                        widget.date.isAfter(widget.selectedEndDate!)))) {
              widget.onStartDateSelected?.call(widget.date);
              widget.onEndDateSelected?.call(null);
            } else if (widget.selectedStartDate != null &&
                (widget.selectedEndDate == null ||
                    widget.date.isAfter(widget.selectedStartDate!))) {
              widget.onEndDateSelected?.call(widget.date);
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          height: 40,
          child: Text(
            '${widget.date.day}',
            style: TextStyle(
              color: _getTextColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (widget.selectedStartDate != null &&
        widget.selectedEndDate != null &&
        !widget.singleSelectionMode &&
        widget.date.isAfter(widget.selectedStartDate!) &&
        widget.date.isBefore(widget.selectedEndDate!)) {
      return Colors.blue.withOpacity(0.2);
    }
    if (widget.selectedStartDate != null &&
        widget.date.isAtSameMomentAs(widget.selectedStartDate!)) {
      return Colors.blue;
    }
    if (widget.selectedEndDate != null &&
        widget.date.isAtSameMomentAs(widget.selectedEndDate!)) {
      return Colors.blue;
    }
    if (widget.disableSelection?.call(widget.date) == true) {
      return Colors.grey.shade200;
    }
    return Colors.transparent;
  }

  Color _getTextColor() {
    if (widget.selectedStartDate != null &&
        widget.date.isAtSameMomentAs(widget.selectedStartDate!)) {
      return Colors.white;
    }
    if (widget.selectedEndDate != null &&
        widget.date.isAtSameMomentAs(widget.selectedEndDate!)) {
      return Colors.white;
    }
    if (widget.disableSelection?.call(widget.date) == true) {
      return Colors.grey;
    }
    if (widget.date.month != widget.yearMonth.month) {
      return Colors.grey.shade400;
    }
    return Colors.black;
  }
}




