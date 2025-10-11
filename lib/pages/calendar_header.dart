import 'package:flutter/material.dart';
import 'package:news_api_app/services/calendar_utils.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    required this.yearMonth,
    this.onPreviousMonth,
    this.onNextMonth,
  });

  final DateTime yearMonth;
  final void Function(DateTime)? onPreviousMonth;
  final void Function(DateTime)? onNextMonth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            final previousMonth = DateTime(yearMonth.year, yearMonth.month - 1);
            if (onPreviousMonth != null) {
              onPreviousMonth!(previousMonth);
            }
          },
        ),
        Text(
          yearMonth.monthAndYear,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            final nextMonth = DateTime(yearMonth.year, yearMonth.month + 1);
            if (onNextMonth != null) {
              onNextMonth!(nextMonth);
            }
          },
        ),
      ],
    );
  }
}