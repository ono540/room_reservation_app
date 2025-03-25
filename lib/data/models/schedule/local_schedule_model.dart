import 'package:json_annotation/json_annotation.dart';

part 'local_schedule_model.g.dart';

@JsonSerializable()
@JsonSerializable()
class LocalScheduleModel {
  final int? id;
  final String item;
  @JsonKey(name: 'time_type')
  final String? timeType;
  final String content;
  final String date;
  @JsonKey(name: 'start_time')
  final String? startTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'schedule_time')
  final DateTime? scheduleTime;
  @JsonKey(name: 'meeting_room_id')
  final int? meetingRoomId;

  LocalScheduleModel({
    this.id,
    this.item = '',
    this.timeType,
    this.content = '',
    this.date = '',
    this.startTime,
    this.endTime,
    this.scheduleTime,
    this.meetingRoomId,
  });

  factory LocalScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$LocalScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalScheduleModelToJson(this);
}
