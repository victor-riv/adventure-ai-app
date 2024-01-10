import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/backend/authenticator.dart';
import '../auth/models/auth_result.dart';
import 'models/login_form_state/providers/log_in_form_state_provider.dart';
import '../auth/notifiers/auth_state_provider.dart';
import '../neubrutalism/my_neu_container.dart';
import '../neubrutalism/my_neu_button.dart';
import '../neubrutalism/my_neu_search_bar.dart';

class SignUpSheet extends ConsumerWidget {
  SignUpSheet({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final buttonHeight = 50.0; // Set the height for buttons

  Widget _buildSignUpScreen(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(loginFormStateNotiferProvider);
    final formStateNotifier = ref.watch(loginFormStateNotiferProvider.notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(120),
          topRight: Radius.circular(120),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const Center(
                child: Text(
              "Let's create an account",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 30),
            SizedBox(
              height: buttonHeight,
              child: MyNeuSearchBar(
                onChanged: (newEmail) {
                  if (ref.watch(loginFormStateNotiferProvider).emailError) {
                    ref
                        .watch(loginFormStateNotiferProvider.notifier)
                        .clearEmailError();
                  }
                  ref
                      .watch(loginFormStateNotiferProvider.notifier)
                      .setEmail(newEmail);
                },
                borderRadius: BorderRadius.circular(12),
                borderColor: ref.watch(loginFormStateNotiferProvider).emailError
                    ? Colors.red
                    : Colors.black,
                shadowColor: ref.watch(loginFormStateNotiferProvider).emailError
                    ? Colors.red
                    : Colors.black,
                leadingIcon: const Icon(Icons.email),
                searchBarColor: Colors.white,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: buttonHeight,
              child: MyNeuSearchBar(
                borderRadius: BorderRadius.circular(12),
                leadingIcon: const Icon(Icons.lock),
                searchBarColor: Colors.white,
                hintText: 'Password',
                borderColor:
                    ref.watch(loginFormStateNotiferProvider).passwordError
                        ? Colors.red
                        : Colors.black,
                shadowColor:
                    ref.watch(loginFormStateNotiferProvider).passwordError
                        ? Colors.red
                        : Colors.black,
                onChanged: (newPassword) {
                  if (ref.watch(loginFormStateNotiferProvider).passwordError) {
                    ref
                        .watch(loginFormStateNotiferProvider.notifier)
                        .clearPasswordError();
                  }
                  ref
                      .watch(loginFormStateNotiferProvider.notifier)
                      .setPassword(newPassword);
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
                height: buttonHeight,
                child: MyNeuTextButton(
                    enableAnimation: true,
                    text: const Text('Create Account',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700)),
                    borderRadius: BorderRadius.circular(12),
                    buttonColor: const Color(0xFFF06543),
                    onPressed: ref.watch(authStateProvider).isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();

                            // TODO: Before we begin anything, validate that the fields are not empty

                            formStateNotifier.validateEmail();
                            formStateNotifier.validatePassword();

                            if (ref
                                    .watch(loginFormStateNotiferProvider)
                                    .emailError ||
                                ref
                                    .watch(loginFormStateNotiferProvider)
                                    .passwordError) {
                              return;
                            }

                            ref
                                .watch(authStateProvider.notifier)
                                .updateIsLoading(true);

                            final response = await const Authenticator()
                                .loginWithEmailandPassword(
                                    formState.email, formState.password);

                            if (response.result == AuthResult.failure) {
                              formStateNotifier.validate(
                                  true, response.errorMessage!);
                              ref
                                  .watch(authStateProvider.notifier)
                                  .updateIsLoading(false);
                              return;
                            }

                            // Clear text fields after account creation
                            emailController.clear();
                            passwordController.clear();

                            // Reset the state
                            formStateNotifier.resetState();

                            ref
                                .watch(authStateProvider.notifier)
                                .updateIsLoading(false);

                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          })),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(color: Theme.of(context).dividerColor),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Theme.of(context).dividerColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: buttonHeight,
              child: const MyNeuContainer(
                offset: Offset(0, 0),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 50),
                    Icon(
                      Icons.apple,
                      size: 24,
                      color: Colors.black,
                    ), // Replace with Facebook icon
                    SizedBox(width: 20), // Adjust spacing as needed
                    Text(
                      "Continue with Apple",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: buttonHeight,
                child: GestureDetector(
                  onTap: () async {
                    final result =
                        await const Authenticator().loginWithGoogle();
                    result.log();
                  },
                  child: const MyNeuContainer(
                    offset: Offset(0, 0),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 50),
                        Icon(Icons.email,
                            color: Colors.black), // Replace with your icon
                        SizedBox(width: 20), // Adjust spacing as needed
                        Text(
                          "Continue with Google",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            SizedBox(
              height: buttonHeight,
              child: GestureDetector(
                onTap: () async {
                  final result =
                      await const Authenticator().loginWithFacebook();
                  result.log();
                },
                child: const MyNeuContainer(
                  offset: Offset(0, 0),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 50),
                      Icon(
                        Icons.facebook,
                        size: 24,
                        color: Colors.black,
                      ), // Replace with Facebook icon
                      SizedBox(width: 20), // Adjust spacing as needed
                      Text(
                        "Continue with Facebook",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildSignUpScreen(context, ref);
  }
}
