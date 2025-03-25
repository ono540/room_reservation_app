// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalScheduleModel _$LocalScheduleModelFromJson(Map<String, dynamic> json) =>
    LocalScheduleModel(
      id: (json['id'] as num?)?.toInt(),
      item: json['item'] as String? ?? '',
      timeType: json['time_type'] as String?,
      content: json['content'] as String? ?? '',
      date: json['date'] as String? ?? '',
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      scheduleTime: json['schedule_time'] == null
          ? null
          : DateTime.parse(json['schedule_time'] as String),
      meetingRoomId: (json['meeting_room_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LocalScheduleModelToJson(LocalScheduleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item': instance.item,
      'time_type': instance.timeType,
      'content': instance.content,
      'date': instance.date,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'schedule_time': instance.scheduleTime?.toIso8601String(),
      'meeting_room_id': instance.meetingRoomId,
    };
