import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylas_ai/auth/backend/authenticator.dart';
import 'package:sylas_ai/auth/models/auth_result.dart';
import 'package:sylas_ai/auth/models/auth_state.dart';

class AuthStateNotifier extends Notifier<AuthState> {
  final _authenticator = const Authenticator();
  @override
  AuthState build() {
    state = const AuthState.unknown();

    // if (_authenticator.isAlreadyLoggedIn) {
    //   state = AuthState(
    //       result: AuthResult.success,
    //       isLoading: false,
    //       userId: _authenticator.userId);
    // }
    return state;
  }

  void updateIsLoading(bool newLoadingStatus) {
    state = AuthState(
        result: state.result,
        isLoading: newLoadingStatus,
        userId: state.userId);
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
    state = state.copiedWithIsLoading(false);
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {}
  }
}

final authStateProvider = NotifierProvider<AuthStateNotifier, AuthState>(() {
  return AuthStateNotifier();
});
