import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_cases/schedule_use_case.dart';
import '../../locator/locator_repository.dart';
import '../notifiers/schedule_list_notifier.dart';
import '../state/schedule_state/schedule_state.dart';

final scheduleListNotifierProvider =
    NotifierProvider<ScheduleListNotifier, ScheduleListState>(
  () => ScheduleListNotifier(
    getIt<ScheduleUseCase>(),
  ),
);
