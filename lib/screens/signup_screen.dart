import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/models/auth_result.dart';
import 'models/login_form_state/providers/log_in_form_state_provider.dart';
import '../auth/backend/providers/auth_state_provider.dart';
import '../neubrutalism/my_neu_button.dart';
import '../neubrutalism/my_neu_search_bar.dart';

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
        title: const Text("Login"),
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
                  MyNeuIconButton(
                    buttonColor: Colors.white,
                    icon: const Icon(Icons.apple),
                    buttonHeight: 50,
                    buttonWidth: 50, // Replace with your actual icon
                    // Add other necessary parameters
                    onPressed: () {
                      // Your button 1 action
                    },
                  ),
                  MyNeuIconButton(
                      buttonColor: Colors.white,
                      icon: const Icon(Icons.email),
                      buttonHeight: 50,
                      buttonWidth: 50, // Replace with your actual icon
                      // Add other necessary parameters
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
                  MyNeuIconButton(
                      buttonColor: Colors.white,
                      icon: const Icon(
                          Icons.facebook), // Replace with your actual icon
                      buttonHeight: 50,
                      buttonWidth: 50,
                      // Add other necessary parameters
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
                child: NeuTextField(
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
                  borderColor:
                      ref.watch(loginFormStateNotiferProvider).emailError
                          ? Colors.red
                          : Colors.black,
                  shadowColor:
                      ref.watch(loginFormStateNotiferProvider).emailError
                          ? Colors.red
                          : Colors.black,
                  leadingIcon: const Icon(Icons.email),
                  searchBarColor: Colors.white,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
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
                child: NeuTextField(
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
                  child: MyNeuTextButton(
                      text: const Text('Create Account',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
                      buttonColor: const Color(0xFFF06543),
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
                            })),
              // const SizedBox(height: 40),
              // SizedBox(
              //   width: double.infinity,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: Divider(color: Theme.of(context).dividerColor),
              //       ),
              //       const Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 8.0),
              //         child: Text(
              //           'Already have an account?',
              //           style: TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: Divider(color: Theme.of(context).dividerColor),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 40),
              // SizedBox(
              //   height: buttonHeight,
              //   child: const MyNeuContainer(
              //     offset: Offset(0, 0),
              //     color: Colors.white,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         SizedBox(width: 50),
              //         Icon(
              //           Icons.apple,
              //           size: 24,
              //           color: Colors.black,
              //         ), // Replace with Facebook icon
              //         SizedBox(width: 20), // Adjust spacing as needed
              //         Text(
              //           "Continue with Apple",
              //           style: TextStyle(
              //               color: Colors.black, fontWeight: FontWeight.w700),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
              // SizedBox(
              //     height: buttonHeight,
              //     child: GestureDetector(
              //       onTap: () async {
              //         // TODO: Should probably close the bottomSheet before the log in?

              //         await ref
              //             .read(authStateProvider.notifier)
              //             .loginWithGoogle();

              //         if (ref.watch(authStateProvider).result ==
              //             AuthResult.success) {
              //           if (context.mounted) {
              //             Navigator.of(context).pop();
              //           }
              //         }
              //       },
              //       child: const MyNeuContainer(
              //         offset: Offset(0, 0),
              //         color: Colors.white,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             SizedBox(width: 50),
              //             Icon(Icons.email,
              //                 color: Colors.black), // Replace with your icon
              //             SizedBox(width: 20), // Adjust spacing as needed
              //             Text(
              //               "Continue with Google",
              //               style: TextStyle(
              //                   color: Colors.black, fontWeight: FontWeight.w700),
              //             ),
              //           ],
              //         ),
              //       ),
              //     )),
              // const SizedBox(height: 20),
              // SizedBox(
              //   height: buttonHeight,
              //   child: GestureDetector(
              //     onTap: () async {
              //       await ref
              //           .read(authStateProvider.notifier)
              //           .loginWithFacebook();
              //       if (ref.watch(authStateProvider).result ==
              //           AuthResult.success) {
              //         if (context.mounted) {
              //           Navigator.of(context).pop();
              //         }
              //       }
              //     },
              //     child: const MyNeuContainer(
              //       offset: Offset(0, 0),
              //       color: Colors.white,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           SizedBox(width: 50),
              //           Icon(
              //             Icons.facebook,
              //             size: 24,
              //             color: Colors.black,
              //           ), // Replace with Facebook icon
              //           SizedBox(width: 20), // Adjust spacing as needed
              //           Text(
              //             "Continue with Facebook",
              //             style: TextStyle(
              //                 color: Colors.black, fontWeight: FontWeight.w700),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
