import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylas_ai/screens/models/login_form_state/log_in_form_state.dart';
import 'package:sylas_ai/screens/notifiers/login_form_state_notifier.dart';

final loginFormStateNotiferProvider =
    NotifierProvider<LoginFormStateNotifier, LoginFormState>(() {
  return LoginFormStateNotifier();
});
