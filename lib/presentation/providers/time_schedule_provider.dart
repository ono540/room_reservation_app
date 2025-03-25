import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_reservation_app/presentation/state/schedule_state/schedule_state.dart';

import '../notifiers/time_schedule_notifier.dart';

final timeScheduleNotifierProvider =
    NotifierProvider<TimeScheduleNotifier, ScheduleState>(
  TimeScheduleNotifier.new,
);
