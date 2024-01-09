import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/backend/authenticator.dart';
import '../auth/models/auth_result.dart';
import '../auth/notifiers/auth_state_provider.dart';
import 'models/login_form_state/providers/log_in_form_state_provider.dart';

class SignUpSheet extends ConsumerWidget {
  SignUpSheet({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final buttonHeight = 50.0; // Set the height for buttons

  Widget _buildSignUpScreen(BuildContext context, WidgetRef ref) {
    final authstate = ref.watch(authStateProvider);
    final formState = ref.watch(loginFormStateNotiferProvider);
    final formStateNotifier = ref.watch(loginFormStateNotiferProvider.notifier);

    // TODO: Look for a better way to do this
    OutlineInputBorder? myCustomBorder(fieldError) {
      if (fieldError == 'email') {
        return OutlineInputBorder(
          borderSide: BorderSide(
            color: formState.emailError ? Colors.red : Colors.black,
            width: 2.0, // Adjust border width here
          ),
          borderRadius: BorderRadius.circular(20.0),
        );
      } else if (fieldError == 'password') {
        return OutlineInputBorder(
          borderSide: BorderSide(
            color: formState.passwordError ? Colors.red : Colors.black,
            width: 2.0, // Adjust border width here
          ),
          borderRadius: BorderRadius.circular(20.0),
        );
      } else {
        return null;
      }
    }

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
              height: formState.emailError ? 70 : buttonHeight,
              child: TextFormField(
                controller: emailController,
                onChanged: (value) {
                  if (formState.emailError) {
                    formStateNotifier.clearEmailError();
                  }
                  formStateNotifier.setEmail(value.trim());
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText:
                      formState.emailError ? formState.emailErrorText : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  errorBorder: myCustomBorder('email'),
                  focusedBorder: myCustomBorder('email'),
                  enabledBorder: myCustomBorder('email'),
                ),
                // Handle username input
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: formState.passwordError ? 70 : buttonHeight,
              child: TextFormField(
                controller: passwordController,
                onChanged: (value) {
                  if (formState.passwordError) {
                    formStateNotifier.clearPasswordError();
                  }
                  formStateNotifier.setPassword(value.trim());
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: formState.passwordError
                      ? formState.passwordErrorText
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  errorBorder: myCustomBorder('password'),
                  focusedBorder: myCustomBorder('password'),
                  enabledBorder: myCustomBorder('password'),
                ),
                // Handle username input
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: authstate.isLoading
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
                      },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor:
                      const Color(0xFF43137B), // Set transparent background
                ),
                child: authstate.isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
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
              child: ElevatedButton(
                onPressed: () async {
                  await const Authenticator().loginWithGoogle();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // Set the background color
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.mail,
                      size: 24,
                      color: Colors.black,
                    ), // Replace with Google icon
                    SizedBox(width: 30), // Adjust spacing as needed
                    Text(
                      "Continue with Google",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // Set the background color
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.apple,
                        size: 24,
                        color: Colors.black), // Replace with Apple icon
                    SizedBox(width: 30), // Adjust spacing as needed
                    Text(
                      "Continue with Apple",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () async {
                  final result =
                      await const Authenticator().loginWithFacebook();
                  result.log();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // Set the background color
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.facebook,
                      size: 24,
                      color: Colors.black,
                    ), // Replace with Facebook icon
                    SizedBox(width: 30), // Adjust spacing as needed
                    Text(
                      "Continue with Facebook",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
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
