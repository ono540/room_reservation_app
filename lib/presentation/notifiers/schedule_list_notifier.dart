import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_reservation_app/presentation/extensions/ref_extension.dart';

import '../../domain/entities/schedule_entity.dart';
import '../../domain/use_cases/schedule_use_case.dart';
import '../state/schedule_state/schedule_state.dart';

class ScheduleListNotifier extends Notifier<ScheduleListState> {
  final ScheduleUseCase scheduleUseCase;

  ScheduleListNotifier(
    this.scheduleUseCase,
  );

  @override
  ScheduleListState build() {
    return const ScheduleListState();
  }

  Future<void> loadSchedules(String date) async {
    ref.startLoading();
    //ローカルだとloadingが発生しない：読み込み速度が速いため ↓
    //  await Future.delayed(const Duration(seconds: 3));
    try {
      final schedules = await scheduleUseCase.loadSchedules(date);
      state = state.copyWith(scheduleListState: schedules);
    } catch (e) {
      ref.setError("Error loading schedules: $e");
    } finally {
      ref.stopLoading();
    }
  }

  Future<void> insert(ScheduleEntity schedule) async {
    ref.startLoading();
    try {
      await scheduleUseCase.insert(schedule);
      await loadSchedules(schedule.date);
    } catch (e) {
      ref.setError("Error inserting schedule: $e");
    } finally {
      ref.stopLoading();
    }
  }

  Future<void> update(ScheduleEntity schedule) async {
    ref.startLoading();
    try {
      await scheduleUseCase.update(schedule);
      await loadSchedules(schedule.date);
    } catch (e) {
      ref.setError("Error updating schedule: $e");
    } finally {
      ref.stopLoading();
    }
  }

  Future<void> delete(ScheduleEntity schedule) async {
    if (schedule.id == null) return;
    ref.startLoading();
    try {
      await scheduleUseCase.delete(schedule.id!);
      await loadSchedules(schedule.date);
    } catch (e) {
      ref.setError("Error deleting schedule: $e");
    } finally {
      ref.stopLoading();
    }
  }
}
