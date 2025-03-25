import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/time_type_constants.dart';
import '../../providers/time_schedule_provider.dart';

class TimeTypeChoiceChip extends ConsumerWidget {
  const TimeTypeChoiceChip({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final selectedTimeType = ref.watch(
        timeScheduleNotifierProvider.select((s) => s.scheduleState.timeType));
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: timeType.map((timeType) {
        return ChoiceChip(
          label: Text(timeType.ja),
          selected: selectedTimeType == timeType.en,
          selectedColor: timeType.color,
          onSelected: (bool selected) {
            ref
                .read(timeScheduleNotifierProvider.notifier)
                .updateSchedule(timeType: selected ? timeType.en : null);
          },
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(
            color:
                selectedTimeType == timeType.en ? Colors.white : timeType.color,
            fontWeight: FontWeight.bold,
            fontSize: 12.0, // フォントサイズを小さくする
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: selectedTimeType == timeType.en
                  ? timeType.color!
                  : Colors.transparent,
            ),
          ),
        );
      }).toList(),
    );
  }
}
