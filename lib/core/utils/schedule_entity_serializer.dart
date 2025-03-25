import '../../domain/entities/schedule_entity.dart';

String toSerializedString(ScheduleEntity entity) {
  return "${entity.id},${entity.item},${entity.timeType ?? ''},${entity.content},${entity.date},"
      "${entity.startTime ?? ''},${entity.endTime ?? ''},${entity.meetingRoomId ?? ''},${entity.roomName ?? ''},"
      "${entity.isVisibleForFilteredScreen ?? false}";
}

ScheduleEntity fromSerializedString(String serialized) {
  final parts = serialized.split(',');
  if (parts.length < 10) {
    throw Exception("データ形式が不正です: $serialized");
  }

  return ScheduleEntity(
    id: parts[0].isNotEmpty ? int.parse(parts[0]) : null,
    item: parts[1],
    timeType: parts[2].isNotEmpty ? parts[2] : null,
    content: parts[3],
    date: parts[4],
    startTime: parts[5].isNotEmpty ? parts[5] : null,
    endTime: parts[6].isNotEmpty ? parts[6] : null,
    meetingRoomId: parts[7].isNotEmpty ? int.parse(parts[7]) : null,
    roomName: parts[8].isNotEmpty ? parts[8] : null,
    isVisibleForFilteredScreen: parts[9] == 'true',
  );
}
