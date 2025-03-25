import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/loading_notifier.dart';
import '../state/network_state/network_state.dart';

final loadingStateProvider =
    NotifierProvider<LoadingStateNotifier, NetworkState>(
  LoadingStateNotifier.new,
);
