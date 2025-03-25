import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/utils/time_utils.dart';

class MonthlyCalendar extends StatefulWidget {
  const MonthlyCalendar({
    super.key,
    required this.onDateSelected,
    required this.selectedDate,
  });

  final Function(DateTime) onDateSelected;
  final DateTime selectedDate;

  @override
  State<MonthlyCalendar> createState() => _MonthlyCalendarState();
}

class _MonthlyCalendarState extends State<MonthlyCalendar> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  void didUpdateWidget(covariant MonthlyCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!isSameDay(oldWidget.selectedDate, widget.selectedDate)) {
      setState(() {
        _selectedDate = widget.selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SfCalendar(
        timeZone: 'Asia/Tokyo',
        view: CalendarView.month,
        firstDayOfWeek: 1,
        initialDisplayDate: _selectedDate,
        initialSelectedDate: _selectedDate, // 🔥 選択日を明示的に設定
        onTap: (CalendarTapDetails details) {
          if (details.date != null) {
            final newSelectedDate = DateTime(
              details.date!.year,
              details.date!.month,
              details.date!.day,
            );
            setState(() {
              _selectedDate = newSelectedDate;
            });
            widget.onDateSelected(newSelectedDate);
          }
        },
        selectionDecoration: BoxDecoration(
          color: Colors.blue.withAlpha(76), // 0.3 * 255 ≈ 76
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
