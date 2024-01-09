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
