import 'package:get_it/get_it.dart';
import '../domain/repositories/schedule_repository.dart';
import '../domain/use_cases/schedule_use_case.dart';

final getIt = GetIt.instance;

void setupUseCases() {
  getIt.registerSingleton<ScheduleUseCase>(
    ScheduleUseCase(getIt<ScheduleRepository>()),
  );
}
