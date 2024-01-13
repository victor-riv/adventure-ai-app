import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylas_ai/auth/models/auth_state.dart';

import '../../notifiers/auth_state_notifier.dart';

final authStateProvider = NotifierProvider<AuthStateNotifier, AuthState>(() {
  return AuthStateNotifier();
});
