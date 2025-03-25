
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_reservation_app/domain/entities/schedule_entity.dart';
import 'package:room_reservation_app/presentation/state/schedule_state/schedule_state.dart';

import '../../core/utils/time_utils.dart';

class TimeScheduleNotifier extends Notifier<ScheduleState> {
  @override
  ScheduleState build() {
    return const ScheduleState();
  }

  void updateScheduleEntity(ScheduleEntity schedule) {
    state = state.copyWith(scheduleState: schedule);
  }

  void updateSchedule({
    int? id,
    String? item,
    String? timeType,
    String? content,
    String? date,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    DateTime? scheduleTime,
    int? meetingRoomId,
    String? roomName,
    bool? isVisibleForFilteredScreen,
  }) {
    state = state.copyWith(
        scheduleState: state.scheduleState.copyWith(
            id: id ?? state.scheduleState.id,
            item: item ?? state.scheduleState.item,
            timeType: timeType ?? state.scheduleState.timeType,
            content: content ?? state.scheduleState.content,
            date: date ?? state.scheduleState.date,
            startTime: startTime != null
                ? formatTimeOfDay(startTime)
                : state.scheduleState.startTime,
            endTime: endTime != null
                ? formatTimeOfDay(endTime)
                : state.scheduleState.endTime,
            scheduleTime: scheduleTime ?? state.scheduleState.scheduleTime,
            meetingRoomId: meetingRoomId ?? state.scheduleState.meetingRoomId,
            roomName: roomName ?? state.scheduleState.roomName,
            isVisibleForFilteredScreen: isVisibleForFilteredScreen ??
                state.scheduleState.isVisibleForFilteredScreen));
  }

  void endTimeReset() {
    state = state.copyWith(
        scheduleState: state.scheduleState.copyWith(endTime: null));
  }

  void roomReset() {
    state = state.copyWith(
        scheduleState: state.scheduleState.copyWith(
            meetingRoomId: null,
            roomName: null,
            isVisibleForFilteredScreen: null));
  }

  void reset() {
    state = const ScheduleState(); // 初期状態にリセット
  }
}
