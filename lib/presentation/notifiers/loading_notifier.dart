import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/network_state/network_state.dart';

class LoadingStateNotifier extends Notifier<NetworkState> {
  @override
  NetworkState build() {
    return const NetworkState(isLoading: false, isConnected: true);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

 void setError(String? errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }



}
