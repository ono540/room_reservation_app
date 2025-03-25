import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/time_schedule_provider.dart';

class ReservationVisibilitySelector extends ConsumerWidget {
  const ReservationVisibilitySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool? selectedValue = ref.watch(timeScheduleNotifierProvider
        .select((s) => s.scheduleState.isVisibleForFilteredScreen));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => updateIsVisibleForFilteredScreen(
              isVisibleForFilteredScreen: false, ref: ref),
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: <Widget>[
              Radio<bool>(
                value: false,
                groupValue: selectedValue,
                onChanged: (bool? value) {
                  updateIsVisibleForFilteredScreen(
                      isVisibleForFilteredScreen: value, ref: ref);
                },
                activeColor: Colors.grey,
              ),
              const Text(
                '全体に共有しない',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => updateIsVisibleForFilteredScreen(
              isVisibleForFilteredScreen: true, ref: ref),
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: <Widget>[
              Radio<bool>(
                value: true,
                groupValue: selectedValue,
                onChanged: (bool? value) {
                  updateIsVisibleForFilteredScreen(
                      isVisibleForFilteredScreen: value, ref: ref);
                },
                activeColor: Colors.grey,
              ),
              const Text(
                '全体に共有する',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void updateIsVisibleForFilteredScreen({
    bool? isVisibleForFilteredScreen,
    required WidgetRef ref,
  }) {
    ref.read(timeScheduleNotifierProvider.notifier).updateSchedule(
          isVisibleForFilteredScreen: isVisibleForFilteredScreen ?? false,
        );
  }
}
