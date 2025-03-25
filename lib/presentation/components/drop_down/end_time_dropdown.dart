import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_reservation_app/presentation/providers/time_schedule_provider.dart';
import '../../../../core/utils/time_utils.dart';


class EndTimeDropdown extends ConsumerWidget {
  const EndTimeDropdown({
    super.key,
    required this.timeSlots,
  });

  final List<TimeOfDay> timeSlots;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    TimeOfDay? startTime;
    TimeOfDay? endTime;

      final startTimeString = ref.watch(timeScheduleNotifierProvider
          .select((s) => s.scheduleState.startTime));
      startTime = stringToTimeOfDay(startTimeString);

      final endTimeString = ref.watch(
          timeScheduleNotifierProvider.select((s) => s.scheduleState.endTime));
      endTime = stringToTimeOfDay(endTimeString);


    List<TimeOfDay> getEndTimeSlots(TimeOfDay? startTime) {
      if (startTime == null) {
        return timeSlots;
      }
      final endTimeSlots = timeSlots
          .where((time) =>
              time.hour > startTime.hour ||
              (time.hour == startTime.hour && time.minute > startTime.minute))
          .toList();
      return endTimeSlots;
    }

    return DropdownButton<TimeOfDay?>(
      hint: const Text(
        '終了時間を選択',
        style: TextStyle(fontSize: 12),
      ),
      value: endTime,
      onChanged: startTime == null
          ? null
          : (newValue) {
              ref
                  .read(timeScheduleNotifierProvider.notifier)
                  .updateSchedule(endTime: newValue);
            },
      items: [
        const DropdownMenuItem<TimeOfDay?>(
          value: null,
          child: Text('--:--'),
        ),
        ...getEndTimeSlots(startTime).map((time) {
          return DropdownMenuItem<TimeOfDay>(
            value: time,
            child: Text(formatTimeOfDay(time)),
          );
        }),
      ],
    );
  }
}
