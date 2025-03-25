import '../../domain/entities/schedule_entity.dart';
import '../models/schedule/local_schedule_model.dart';

class ScheduleEntityMapper {
  static LocalScheduleModel toLocalScheduleModel(ScheduleEntity entity) {
    return LocalScheduleModel(
      id: entity.id,
      item: entity.item,
      timeType: entity.timeType,
      content: entity.content,
      date: entity.date,
      startTime: entity.startTime,
      endTime: entity.endTime,
      scheduleTime: entity.scheduleTime,
      meetingRoomId: entity.meetingRoomId,
    );
  }

  static ScheduleEntity toScheduleEntity(LocalScheduleModel model) {
    return ScheduleEntity(
      id: model.id,
      item: model.item,
      timeType: model.timeType,
      content: model.content,
      date: model.date,
      startTime: model.startTime,
      endTime: model.endTime,
      scheduleTime: model.scheduleTime,
      meetingRoomId: model.meetingRoomId,
    );
  }

  static List<ScheduleEntity> toScheduleEntities(
      List<LocalScheduleModel> models) {
    return models.map((model) => toScheduleEntity(model)).toList();
  }

  static List<LocalScheduleModel> toLocalScheduleModels(
      List<ScheduleEntity> entities) {
    return entities.map((entity) => toLocalScheduleModel(entity)).toList();
  }

  static ScheduleEntity fromLocalScheduleModel(LocalScheduleModel model) {
    return ScheduleEntity(
      id: model.id,
      item: model.item,
      timeType: model.timeType,
      content: model.content,
      date: model.date,
      startTime: model.startTime,
      endTime: model.endTime,
      scheduleTime: model.scheduleTime,
      meetingRoomId: model.meetingRoomId,
    );
  }
}
