import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/models/auth_result.dart';
import 'models/login_form_state/providers/log_in_form_state_provider.dart';
import '../auth/backend/providers/auth_state_provider.dart';

class SignUpSheet extends ConsumerWidget {
  SignUpSheet({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final buttonHeight = 50.0; // Set the height for buttons

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(loginFormStateNotiferProvider);
    final formStateNotifier = ref.watch(loginFormStateNotiferProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF999999),
          ),
          onPressed: () {
            ref.watch(loginFormStateNotiferProvider.notifier).clearErrors();
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Login",
          style: TextStyle(color: Color(0xFF999999)),
        ),
      ),
      body: Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // This will space out the children evenly across the row's main axis.
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF999999),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      color: Colors.black,
                      icon: const Icon(Icons.apple),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF999999),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                        color: Colors.black,
                        icon: const Icon(Icons.email),
                        onPressed: () async {
                          await ref
                              .read(authStateProvider.notifier)
                              .loginWithGoogle();
                          if (ref.watch(authStateProvider).result ==
                              AuthResult.success) {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        }),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF999999),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                        color: Colors.black,
                        icon: const Icon(Icons.facebook),
                        onPressed: () async {
                          await ref
                              .read(authStateProvider.notifier)
                              .loginWithFacebook();
                          if (ref.watch(authStateProvider).result ==
                              AuthResult.success) {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
                        'Or create account with your email',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF999999)),
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
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Color(0xFF999999)),
                  cursorColor: const Color(0xFF46b1c9),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: const TextStyle(color: Color(0xFF999999)),
                    filled: true,
                    fillColor: const Color(0xFF1F1F1F),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Optional: if you want rounded corners
                      borderSide: BorderSide
                          .none, // Optional: if you don't want the default border
                    ),
                  ),
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
                ),
              ),
              if (ref.watch(loginFormStateNotiferProvider).emailError) ...[
                const SizedBox(height: 10),
                Text(
                  ref.watch(loginFormStateNotiferProvider).emailErrorText,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                )
              ] else ...[
                const SizedBox(
                  height: 20,
                )
              ],
              SizedBox(
                height: buttonHeight,
                child: TextField(
                  style: const TextStyle(color: Color(0xFF999999)),
                  cursorColor: const Color(0xFF46b1c9),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Color(0xFF999999)),
                    filled: true,
                    fillColor: const Color(0xFF1F1F1F),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Optional: if you want rounded corners
                      borderSide: BorderSide
                          .none, // Optional: if you don't want the default border
                    ),
                  ),
                  obscureText: true,
                  onChanged: (newPassword) {
                    if (ref
                        .watch(loginFormStateNotiferProvider)
                        .passwordError) {
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
              if (ref.watch(loginFormStateNotiferProvider).passwordError) ...[
                const SizedBox(height: 10),
                Text(
                  ref.watch(loginFormStateNotiferProvider).passwordErrorText,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                )
              ] else ...[
                const SizedBox(
                  height: 30,
                )
              ],
              SizedBox(
                  height: buttonHeight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFE0E348),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0)),
                    onPressed: ref.watch(authStateProvider).isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();

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

                            await ref
                                .watch(authStateProvider.notifier)
                                .loginWithEmailandPassword(
                                    formState.email, formState.password);

                            if (ref.watch(authStateProvider).result ==
                                AuthResult.failure) {
                              formStateNotifier.validate(
                                  true, "Error has ocurred");
                              return;
                            }

                            // Clear text fields after account creation
                            emailController.clear();
                            passwordController.clear();

                            // Reset the state
                            formStateNotifier.resetState();

                            // TODO: Write to store

                            ref
                                .watch(authStateProvider.notifier)
                                .updateIsLoading(false);

                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                    child: const Text('Create Account',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
