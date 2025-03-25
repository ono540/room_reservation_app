import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_reservation_app/presentation/providers/time_schedule_provider.dart';

import '../../../../core/constants/meeting_room_constants.dart';

class RoomsDropdown extends ConsumerWidget {
  const RoomsDropdown({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final meetingRoomId = ref.watch(timeScheduleNotifierProvider
        .select((s) => s.scheduleState.meetingRoomId));

    void updateSchedule({
      int? meetingRoomId,
      String? roomName,
    }) {
      ref
          .read(timeScheduleNotifierProvider.notifier)
          .updateSchedule(meetingRoomId: meetingRoomId, roomName: roomName);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              DropdownButton<int>(
                value: meetingRoomId,
                hint: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: const Text(
                    '会議室選択',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                onChanged: (int? newValue) {
                  updateSchedule(
                      meetingRoomId: newValue,
                      roomName: MeetingRoomData.getRoomName(newValue));
                },
                items: MeetingRoomData.allRooms
                    .map<DropdownMenuItem<int>>((room) {
                  return DropdownMenuItem<int>(
                    value: room['id'], // 修正: entry.key → room['id']
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        room['name'], // 修正: entry.value → room['name']
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Text(
            '※会議室を予約する際は終了時間を必ず登録して下さい。',
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
