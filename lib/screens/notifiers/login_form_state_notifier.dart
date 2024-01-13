import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylas_ai/screens/models/login_form_state/log_in_form_state.dart';

class LoginFormStateNotifier extends Notifier<LoginFormState> {
  @override
  LoginFormState build() {
    return LoginFormState();
  }

  void setEmail(String newEmail) {
    state = state.copyWith(email: newEmail);
  }

  void setPassword(newPassword) {
    state = state.copyWith(password: newPassword);
  }

  void clearEmailError() {
    state = state.copyWith(emailError: false, emailErrorText: '');
  }

  void clearPasswordError() {
    state = state.copyWith(passwordError: false, passwordErrorText: '');
  }

  void clearErrors() {
    state = state.copyWith(
        emailError: false,
        emailErrorText: '',
        passwordError: false,
        passwordErrorText: '');
  }

  void validateEmail() {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (state.email == '') {
      state = state.copyWith(
          emailError: true, emailErrorText: "Email field can't be empty");
      return;
    }

    final valid = emailRegex.hasMatch(state.email);

    if (!valid) {
      state = state.copyWith(
          emailError: true,
          emailErrorText: 'The email provided is not a valid email');
    }
  }

  void validatePassword() {
    if (state.password == '') {
      state = state.copyWith(
          passwordError: true,
          passwordErrorText: "Password field can't be empty");
    }
  }

  void validate(error, String errorText) {
    state = state.copyWith(passwordError: error, passwordErrorText: errorText);
  }

  void resetState() {
    state = LoginFormState();
  }
}
