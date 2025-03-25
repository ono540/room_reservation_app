import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:room_reservation_app/data/database/database_service.dart';
import 'package:room_reservation_app/data/models/schedule/local_schedule_model.dart';

class MockPathProvider extends Mock {
  Future<String> getApplicationDocumentsPath() async => './test/tmp';
}

void main() {
  late DatabaseService databaseService;
  late Directory testDir;

  setUp(() {
    testDir = Directory('./test/tmp')..createSync(recursive: true);
    databaseService = DatabaseService();
  });

  tearDown(() {
    if (testDir.existsSync()) {
      testDir.deleteSync(recursive: true);
    }
    databaseService.db.dispose();
  });

  group('DatabaseService', () {
    test('should initialize database successfully', () async {
      await databaseService.initDatabase();
      expect(databaseService.db, isNotNull);
    });

    test('should insert schedule and return correct id', () async {
      await databaseService.initDatabase();

      final schedule = LocalScheduleModel(
        item: 'テスト予定',
        timeType: '会議',
        content: 'テスト内容',
        date: '2024-03-20',
        startTime: '10:00',
        endTime: '11:00',
        scheduleTime: DateTime(2024, 3, 20, 10, 0),
        meetingRoomId: 1,
      );

      final id = await databaseService.insert(schedule);
      expect(id, isNotNull);
      expect(id, isPositive);
    });

    test('should update schedule successfully', () async {
      await databaseService.initDatabase();

      final schedule = LocalScheduleModel(
        item: 'テスト予定',
        timeType: '会議',
        content: 'テスト内容',
        date: '2024-03-20',
        startTime: '10:00',
        endTime: '11:00',
        scheduleTime: DateTime(2024, 3, 20, 10, 0),
        meetingRoomId: 1,
      );

      final id = await databaseService.insert(schedule);
      final updatedSchedule = LocalScheduleModel(
        id: id,
        item: '更新された予定',
        timeType: '会議',
        content: '更新された内容',
        date: '2024-03-20',
        startTime: '10:00',
        endTime: '11:00',
        scheduleTime: DateTime(2024, 3, 20, 10, 0),
        meetingRoomId: 2,
      );

      final success = await databaseService.update(updatedSchedule);
      expect(success, isTrue);
    });

    test('should delete schedule successfully', () async {
      await databaseService.initDatabase();

      final schedule = LocalScheduleModel(
        item: 'テスト予定',
        timeType: '会議',
        content: 'テスト内容',
        date: '2024-03-20',
        startTime: '10:00',
        endTime: '11:00',
        scheduleTime: DateTime(2024, 3, 20, 10, 0),
      );

      final id = await databaseService.insert(schedule);
      final success = await databaseService.delete(id);
      expect(success, isTrue);
    });

    test('should query schedules by weekdays', () async {
      await databaseService.initDatabase();

      final schedules = [
        LocalScheduleModel(
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

      for (final schedule in schedules) {
        await databaseService.insert(schedule);
      }

      final weekdays = ['2024-03-20', '2024-03-21'];
      final results = await databaseService.queryAllRows(weekdays);

      expect(results.length, equals(2));
      expect(results[0].item, equals('予定1'));
      expect(results[1].item, equals('予定2'));
    });

    test('should return empty list when querying with empty weekdays',
        () async {
      await databaseService.initDatabase();
      final results = await databaseService.queryAllRows([]);
      expect(results, isEmpty);
    });
  });
}
