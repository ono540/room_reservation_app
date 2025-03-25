import 'package:flutter_test/flutter_test.dart';
import 'package:room_reservation_app/data/mappers/schedule_entity_mapper.dart';
import 'package:room_reservation_app/data/models/schedule/local_schedule_model.dart';
import 'package:room_reservation_app/domain/entities/schedule_entity.dart';

void main() {
  group('ScheduleEntityMapper', () {
    test(
        'toLocalScheduleModel should correctly map ScheduleEntity to LocalScheduleModel',
        () {
      final entity = ScheduleEntity(
        id: 1,
        item: 'テスト予定',
        timeType: '会議',
        content: 'テスト内容',
        date: '2024-03-20',
        startTime: '10:00',
        endTime: '11:00',
        scheduleTime: DateTime(2024, 3, 20, 10, 0),
        meetingRoomId: 1,
      );

      final model = ScheduleEntityMapper.toLocalScheduleModel(entity);

      expect(model.id, equals(entity.id));
      expect(model.item, equals(entity.item));
      expect(model.timeType, equals(entity.timeType));
      expect(model.content, equals(entity.content));
      expect(model.date, equals(entity.date));
      expect(model.startTime, equals(entity.startTime));
      expect(model.endTime, equals(entity.endTime));
      expect(model.scheduleTime, equals(entity.scheduleTime));
      expect(model.meetingRoomId, equals(entity.meetingRoomId));
    });

    test(
        'toScheduleEntity should correctly map LocalScheduleModel to ScheduleEntity',
        () {
      final model = LocalScheduleModel(
        id: 1,
        item: 'テスト予定',
        timeType: '会議',
        content: 'テスト内容',
        date: '2024-03-20',
        startTime: '10:00',
        endTime: '11:00',
        scheduleTime: DateTime(2024, 3, 20, 10, 0),
        meetingRoomId: 1,
      );

      final entity = ScheduleEntityMapper.toScheduleEntity(model);

      expect(entity.id, equals(model.id));
      expect(entity.item, equals(model.item));
      expect(entity.timeType, equals(model.timeType));
      expect(entity.content, equals(model.content));
      expect(entity.date, equals(model.date));
      expect(entity.startTime, equals(model.startTime));
      expect(entity.endTime, equals(model.endTime));
      expect(entity.scheduleTime, equals(model.scheduleTime));
      expect(entity.meetingRoomId, equals(model.meetingRoomId));
    });

    test(
        'toScheduleEntities should correctly map list of LocalScheduleModel to list of ScheduleEntity',
        () {
      final models = [
        LocalScheduleModel(
          id: 1,
          item: '予定1',
          timeType: '会議',
          content: '内容1',
          date: '2024-03-20',
          startTime: '10:00',
          endTime: '11:00',
          scheduleTime: DateTime(2024, 3, 20, 10, 0),
          meetingRoomId: 1,
        ),
        LocalScheduleModel(
          id: 2,
          item: '予定2',
          timeType: 'ミーティング',
          content: '内容2',
          date: '2024-03-21',
          startTime: '14:00',
          endTime: '15:00',
          scheduleTime: DateTime(2024, 3, 21, 14, 0),
          meetingRoomId: 2,
        ),
      ];

      final entities = ScheduleEntityMapper.toScheduleEntities(models);

      expect(entities.length, equals(2));
      expect(entities[0].id, equals(models[0].id));
      expect(entities[1].id, equals(models[1].id));
    });

    test(
        'toLocalScheduleModels should correctly map list of ScheduleEntity to list of LocalScheduleModel',
        () {
      final entities = [
        ScheduleEntity(
          id: 1,
          item: '予定1',
          timeType: '会議',
          content: '内容1',
          date: '2024-03-20',
          startTime: '10:00',
          endTime: '11:00',
          scheduleTime: DateTime(2024, 3, 20, 10, 0),
          meetingRoomId: 2,
        ),
        ScheduleEntity(
          id: 2,
          item: '予定2',
          timeType: 'ミーティング',
          content: '内容2',
          date: '2024-03-21',
          startTime: '14:00',
          endTime: '15:00',
          scheduleTime: DateTime(2024, 3, 21, 14, 0),
          meetingRoomId: 2,
        ),
      ];

      final models = ScheduleEntityMapper.toLocalScheduleModels(entities);

      expect(models.length, equals(2));
      expect(models[0].id, equals(entities[0].id));
      expect(models[1].id, equals(entities[1].id));
    });
  });
}
