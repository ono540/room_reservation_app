import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/constants/time_type_constants.dart';
import '../../core/utils/schedule_entity_serializer.dart';
import '../../core/utils/string_utils.dart';
import '../../core/utils/time_utils.dart';
import '../../domain/entities/schedule_entity.dart';

class ScheduleAppointmentMapper {
  static Appointment toAppointment(ScheduleEntity entity) {
    if (entity.id == null) {
      throw Exception("ScheduleEntity に ID がありません");
    }

    final matchingScheduleText = formatRoomScheduleText(
      startTime: entity.startTime ?? '',
      endTime: entity.endTime,
      content: entity.content ?? '',
      matchingType: getTimeTypeByKey(entity.timeType).ja,
    );

    return Appointment(
      id: entity.id, // IDを必須にする
      resourceIds: entity.meetingRoomId != null ? [entity.meetingRoomId!] : [],
      startTime: stringToDateTime(entity.date, entity.startTime!),
      endTime: stringToDateTime(entity.date, entity.endTime!),
      subject: matchingScheduleText.isNotEmpty ? matchingScheduleText : '',
      color: getColorForTimeType(entity.timeType),
      // notes: jsonEncode(entity.toJson()), // ScheduleEntityをJSONとして格納
      notes: toSerializedString(entity),
    );
  }

  static ScheduleEntity fromAppointment(Appointment appointment) {
    if (appointment.notes == null) {
      throw Exception("Appointment に ScheduleEntity のデータがありません");
    }
    return fromSerializedString(appointment.notes!);
  }
}
