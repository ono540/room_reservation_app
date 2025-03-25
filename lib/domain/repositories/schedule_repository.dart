import '../../data/models/schedule/local_schedule_model.dart';

abstract class ScheduleRepository {
  Future<int> insert(LocalScheduleModel schedule);
  Future<bool> update(LocalScheduleModel schedule);
  Future<bool> delete(int id);
  Future<List<LocalScheduleModel>> fetchByDate(String date);
}
