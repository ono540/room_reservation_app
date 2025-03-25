class ScheduleEntity {
  final int? id;
  final String item;
  final String? timeType;
  final String content;
  final String date;
  final String? startTime;
  final String? endTime;
  final DateTime? scheduleTime;
  final int? meetingRoomId;
  final String? roomName;
  final bool? isVisibleForFilteredScreen;

  const ScheduleEntity({
    this.id,
    required this.item,
    this.timeType,
    required this.content,
    required this.date,
    this.startTime,
    this.endTime,
    this.scheduleTime,
    this.meetingRoomId,
    this.roomName,
    this.isVisibleForFilteredScreen,
  });

  // copyWith で新しいインスタンスを作成
  ScheduleEntity copyWith({
    int? id,
    String? item,
    String? timeType,
    String? content,
    String? date,
    String? startTime,
    String? endTime,
    DateTime? scheduleTime,
    int? meetingRoomId,
    String? roomName,
    bool? isVisibleForFilteredScreen,
  }) {
    return ScheduleEntity(
      id: id ?? this.id,
      item: item ?? this.item,
      timeType: timeType ?? this.timeType,
      content: content ?? this.content,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime,
      scheduleTime: scheduleTime ?? this.scheduleTime,
      meetingRoomId: meetingRoomId ?? this.meetingRoomId,
      roomName: roomName ?? this.roomName,
      isVisibleForFilteredScreen:
          isVisibleForFilteredScreen ?? this.isVisibleForFilteredScreen,
    );
  }
}
