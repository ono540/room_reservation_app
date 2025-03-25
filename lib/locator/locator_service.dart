import 'package:get_it/get_it.dart';

import '../data/database/database_service.dart';

final getIt = GetIt.instance;

Future<void> setupServices() async {
  // DatabaseServiceをシングルトンとして登録
  getIt.registerSingleton<DatabaseService>(DatabaseService());
}
