import 'package:room_reservation_app/data/models/schedule/local_schedule_model.dart';

import '../../domain/repositories/schedule_repository.dart';
import '../database/database_service.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl(this._dbService);
  final DatabaseService _dbService;

  @override
  Future<int> insert(LocalScheduleModel schedule) async {
    try {
      final stmt = _dbService.db.prepare(
        'INSERT INTO schedule (item, time_type, content, date, start_time, end_time, schedule_time, meeting_room_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      );
      stmt.execute([
        schedule.item,
        schedule.timeType,
        schedule.content,
        schedule.date,
        schedule.startTime,
        schedule.endTime,
        schedule.scheduleTime?.toIso8601String(),
        schedule.meetingRoomId,
      ]);
      final id = _dbService.db.lastInsertRowId;
      stmt.dispose();
      return id;
    } catch (e) {
      print('スケジュール挿入エラー: $e');
      rethrow;
    }
  }

  @override
  Future<bool> update(LocalScheduleModel schedule) async {
    final stmt = _dbService.db.prepare(
      'UPDATE schedule SET item = ?, time_type = ?, content = ?, date = ?, start_time = ?, end_time = ?, schedule_time = ?, meeting_room_id = ? WHERE id = ?',
    );
    stmt.execute([
      schedule.item,
      schedule.timeType,
      schedule.content,
      schedule.date,
      schedule.startTime,
      schedule.endTime,
      schedule.scheduleTime?.toIso8601String(),
      schedule.meetingRoomId,
      schedule.id,
    ]);
    final changes = _dbService.db.updatedRows;
    stmt.dispose();
    return changes > 0;
  }

  @override
  Future<bool> delete(int id) async {
    final stmt = _dbService.db.prepare('DELETE FROM schedule WHERE id = ?');
    stmt.execute([id]);
    final changes = _dbService.db.updatedRows;
    stmt.dispose();
    return changes > 0;
  }

  @override
  Future<List<LocalScheduleModel>> fetchByDate(String date) async {
    final stmt = _dbService.db.prepare('SELECT * FROM schedule WHERE date = ?');
    final resultSet = stmt.select([date]);
    stmt.dispose();
    final result =
        resultSet.map((row) => LocalScheduleModel.fromJson(row)).toList();
    return result;
  }
}
