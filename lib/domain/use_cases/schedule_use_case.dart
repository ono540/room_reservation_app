import '../entities/schedule_entity.dart';
import '../repositories/schedule_repository.dart';
import '../../data/mappers/schedule_entity_mapper.dart';

class ScheduleUseCase {
  final ScheduleRepository _repository;

  ScheduleUseCase(this._repository);

  Future<List<ScheduleEntity>> loadSchedules(String date) async {
    final schedules = await _repository.fetchByDate(date);
    return schedules
        .map(
            (schedule) => ScheduleEntityMapper.fromLocalScheduleModel(schedule))
        .toList();
  }

  Future<void> insert(ScheduleEntity schedule) async {
    final model = ScheduleEntityMapper.toLocalScheduleModel(schedule);
    await _repository.insert(model);
  }

  Future<void> update(ScheduleEntity schedule) async {
    final model = ScheduleEntityMapper.toLocalScheduleModel(schedule);
    await _repository.update(model);
  }

  Future<void> delete(int id) async {
    await _repository.delete(id);
  }
}
