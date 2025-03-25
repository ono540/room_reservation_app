import 'package:get_it/get_it.dart';

import 'locator_repository.dart';
import 'locator_service.dart';
import 'locator_usecase.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  await setupServices(); // **サービスの登録**
  setupRepositories(); // **リポジトリの登録**
  setupUseCases(); // **ユースケースの登録**
}
