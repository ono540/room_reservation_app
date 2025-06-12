import 'package:get_it/get_it.dart';

import '../data/database/database_service.dart';


Future<void> setupServices(GetIt getIt) async {
  // DatabaseServiceをシングルトンとして登録
  getIt.registerSingleton<DatabaseService>(DatabaseService());
}
