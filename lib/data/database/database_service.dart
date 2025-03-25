import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../models/schedule/local_schedule_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  late final Database db;

  Future<void> initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = join(directory.path, 'room_reservation_schedule.db');
    db = sqlite3.open(dbPath);

    db.execute('''
      CREATE TABLE IF NOT EXISTS schedule (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item TEXT,
        time_type TEXT,
        content TEXT,
        date TEXT,
        start_time TEXT,
        end_time TEXT,
        schedule_time TEXT,
        meeting_room_id INTEGER
      )
    ''');
  }

  Future<int> insert(LocalScheduleModel schedule) async {
    try {
      final stmt = db.prepare(
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
      final id = db.lastInsertRowId;
      stmt.dispose();
      return id;
    } catch (e) {
      print('スケジュール挿入エラー: $e');
      rethrow;
    }
  }

  Future<bool> update(LocalScheduleModel schedule) async {
    final stmt = db.prepare(
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
    final changes = db.updatedRows;
    stmt.dispose();
    return changes > 0;
  }

  Future<bool> delete(int id) async {
    final stmt = db.prepare('DELETE FROM schedule WHERE id = ?');
    stmt.execute([id]);
    final changes = db.updatedRows;
    stmt.dispose();
    return changes > 0;
  }

  Future<List<LocalScheduleModel>> queryAllRows(List<String> weekdays) async {
    if (weekdays.isEmpty) return [];

    final placeholders = List.filled(weekdays.length, '?').join(',');
    final stmt =
        db.prepare('SELECT * FROM schedule WHERE date IN ($placeholders)');
    final resultSet = stmt.select(weekdays);
    stmt.dispose();

    return resultSet.map((row) => LocalScheduleModel.fromJson(row)).toList();
  }
}
