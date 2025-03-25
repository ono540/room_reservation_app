import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/loading_provider.dart';

extension RefExtension on Ref {
  /// **ローディング状態を true にする**
  void startLoading() => read(loadingStateProvider.notifier).setLoading(true);

  /// **ローディング状態を false にする**
  void stopLoading() => read(loadingStateProvider.notifier).setLoading(false);

  /// **ローディング状態を取得**
  bool get isLoading => watch(loadingStateProvider).isLoading;

  /// **エラーメッセージをセット**
  void setError(String message) =>
      read(loadingStateProvider.notifier).setError(message);

  /// **エラーメッセージをクリア**
  void clearError() => read(loadingStateProvider.notifier).clearError();

  /// **現在のエラーメッセージを取得**
  String? get errorMessage => watch(loadingStateProvider).errorMessage;
}
