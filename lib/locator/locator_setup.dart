import 'package:get_it/get_it.dart';

import 'locator_repository.dart';
import 'locator_service.dart';
import 'locator_usecase.dart';

class LocatorSetup {
  static final GetIt _getIt = GetIt.instance;
  static GetIt get getIt => _getIt;

  Future<void> initialize() async {
    await setupServices(_getIt); // **サービスの登録**
    setupRepositories(_getIt); // **リポジトリの登録**
    setupUseCases(_getIt); // **ユースケースの登録**
  }
}
