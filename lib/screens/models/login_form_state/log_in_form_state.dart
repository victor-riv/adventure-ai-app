import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormState {
  String email;
  String password;
  bool isLoading;
  bool emailError;
  String emailErrorText;
  bool passwordError;
  String passwordErrorText;

  LoginFormState(
      {this.email = '',
      this.password = '',
      this.isLoading = false,
      this.emailError = false,
      this.emailErrorText = '',
      this.passwordError = false,
      this.passwordErrorText = ''});

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? emailError,
    String? emailErrorText,
    bool? passwordError,
    String? passwordErrorText,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      emailError: emailError ?? this.emailError,
      emailErrorText: emailErrorText ?? this.emailErrorText,
      passwordError: passwordError ?? this.passwordError,
      passwordErrorText: passwordErrorText ?? this.passwordErrorText,
    );
  }
}

class LoginStateNotifier extends Notifier<LoginFormState> {
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

    return;
  }

  void validate(error, String errorText) {
    state = state.copyWith(passwordError: error, passwordErrorText: errorText);
  }

  void resetState() {
    state = LoginFormState();
  }
}

final loginFormStateProvider =
    NotifierProvider<LoginStateNotifier, LoginFormState>(() {
  return LoginStateNotifier();
});
