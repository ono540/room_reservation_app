import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/schedule_entity.dart';

part 'schedule_state.freezed.dart';

@freezed
class ScheduleListState with _$ScheduleListState {
  const factory ScheduleListState({
    @Default([]) List<ScheduleEntity> scheduleListState,
  }) = _ScheduleListState;
}

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState({
    @Default(ScheduleEntity(
      item: '',
      content: '',
      date: '',
    ))
    ScheduleEntity scheduleState,
  }) = _ScheduleState;
}
