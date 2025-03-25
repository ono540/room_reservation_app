import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_reservation_app/core/constants/schedule_constants.dart';
import 'package:room_reservation_app/presentation/providers/time_schedule_provider.dart';

import '../../../../core/utils/time_utils.dart';

class RoomStartTimeDropdown extends ConsumerStatefulWidget {
  const RoomStartTimeDropdown({
    super.key,

    required this.registrationDate,
  });

  final String registrationDate;
  @override
  RoomStartTimeDropdownState createState() => RoomStartTimeDropdownState();
}

class RoomStartTimeDropdownState extends ConsumerState<RoomStartTimeDropdown> {
  List<TimeOfDay> startTimeSlots = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //    _updateSchedule(item: widget.schedule.en, date: widget.registrationDate);
    });
    _generateTimeSlots();
    super.initState();
  }

  void _generateTimeSlots() {
    startTimeSlots.clear();
    int startHour = 8;
    for (int hour = startHour; hour < 21; hour++) {
      for (int minute = 0; minute < 60; minute += 15) {
        startTimeSlots.add(TimeOfDay(hour: hour, minute: minute));
      }
    }
  }

  void _updateSchedule({
    String? date,
    TimeOfDay? startTime,
    DateTime? scheduleTime,
// endTimeの型をTimeOfDay?に変更
  }) {
    final timeKey = startTime != null ? getTimeScheduleKey(startTime) : null;
    ref.read(timeScheduleNotifierProvider.notifier).updateSchedule(
          item: timeKey, // `timeKey` をセット
          date: toYyyyMmDdString(scheduleTime!),
          startTime: startTime,
          scheduleTime: scheduleTime,
        );
  }

  void _endTimeReset() {
    ref.read(timeScheduleNotifierProvider.notifier).endTimeReset();
  }

  @override
  Widget build(BuildContext context) {
    final startTimeString = ref.watch(
        timeScheduleNotifierProvider.select((s) => s.scheduleState?.startTime));

    final startTime = stringToTimeOfDay(startTimeString);

    return DropdownButton<TimeOfDay>(
      hint: const Text(
        '開始時間を選択',
        style: TextStyle(fontSize: 12),
      ),
      value: startTime,
      onChanged: (newValue) {
        final dateTime = combineDateAndTime(widget.registrationDate, newValue);
        _updateSchedule(
          startTime: newValue,
          scheduleTime: dateTime,
        );
        _endTimeReset();
      },
      items: startTimeSlots.map((time) {
        return DropdownMenuItem(
          value: time,
          child: Text(formatTimeOfDay(time)),
        );
      }).toList(),
    );
  }
}
