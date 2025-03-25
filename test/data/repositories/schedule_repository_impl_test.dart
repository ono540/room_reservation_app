import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:room_reservation_app/data/database/database_service.dart';
import 'package:room_reservation_app/data/models/schedule/local_schedule_model.dart';
import 'package:room_reservation_app/data/repositories/schedule_repository_impl.dart';

class MockDatabaseService extends Mock implements DatabaseService {
  @override
  late final Database db;
}

void main() {
  late ScheduleRepositoryImpl repository;
  late MockDatabaseService mockDatabaseService;

  setUp(() {
    mockDatabaseService = MockDatabaseService();
    repository = ScheduleRepositoryImpl(mockDatabaseService);
  });

  group('ScheduleRepositoryImpl', () {
    test('should insert schedule and return id', () async {
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

      when(() => mockDatabaseService.insert(schedule))
          .thenAnswer((_) async => 1);

      final id = await repository.insert(schedule);

      expect(id, equals(1));
      verify(() => mockDatabaseService.insert(schedule)).called(1);
    });

    test('should update schedule successfully', () async {
      final schedule = LocalScheduleModel(
        id: 1,
        item: '更新された予定',
        timeType: '会議',
        content: '更新された内容',
        date: '2024-03-20',
        startTime: '10:00',
        endTime: '11:00',
        scheduleTime: DateTime(2024, 3, 20, 10, 0),
        meetingRoomId: 2,
      );

      when(() => mockDatabaseService.update(schedule))
          .thenAnswer((_) async => true);

      final success = await repository.update(schedule);

      expect(success, isTrue);
      verify(() => mockDatabaseService.update(schedule)).called(1);
    });

    test('should delete schedule successfully', () async {
      when(() => mockDatabaseService.delete(1)).thenAnswer((_) async => true);

      final success = await repository.delete(1);

      expect(success, isTrue);
      verify(() => mockDatabaseService.delete(1)).called(1);
    });
  });
}
