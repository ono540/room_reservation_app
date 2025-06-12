import 'package:get_it/get_it.dart';
import 'package:room_reservation_app/data/database/database_service.dart';

import '../data/repositories/schedule_repository_impl.dart';
import '../domain/repositories/schedule_repository.dart';


void setupRepositories(GetIt getIt) {
  getIt.registerSingleton<ScheduleRepository>(
    ScheduleRepositoryImpl(getIt<DatabaseService>()),
  );
}
