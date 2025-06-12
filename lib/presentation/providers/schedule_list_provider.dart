import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_cases/schedule_use_case.dart';
import '../../locator/locator_repository.dart';
import '../notifiers/schedule_list_notifier.dart';
import '../state/schedule_state/schedule_state.dart';
import '../../locator/locator_setup.dart';
final scheduleListNotifierProvider =
    NotifierProvider<ScheduleListNotifier, ScheduleListState>(
  () => ScheduleListNotifier(
   LocatorSetup.getIt<ScheduleUseCase>(),
  ),
);
