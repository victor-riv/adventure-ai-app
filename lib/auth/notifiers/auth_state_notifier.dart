import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylas_ai/auth/backend/authenticator.dart';
import 'package:sylas_ai/auth/models/auth_result.dart';
import 'package:sylas_ai/auth/models/auth_state.dart';
import 'package:sylas_ai/storage/user_info_storage.dart';

import '../typedefs/user_id.dart';

class AuthStateNotifier extends Notifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  @override
  AuthState build() {
    state = const AuthState.unknown();

    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: _authenticator.userId);
    }
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

    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }

    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }

    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> saveUserInfo({required UserId userId}) {
    return _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email);
  }
}
