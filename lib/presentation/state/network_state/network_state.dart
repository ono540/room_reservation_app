import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_state.freezed.dart';

@freezed
class NetworkState with _$NetworkState {
  const factory NetworkState({
    @Default(false) bool isLoading, // デフォルト値を設定
    @Default(true) bool isConnected, // デフォルト値を設定
    String? errorMessage,
  }) = _NetworkState;
}
