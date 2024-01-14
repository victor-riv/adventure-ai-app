import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylas_ai/auth/backend/providers/auth_state_provider.dart';
import 'package:sylas_ai/neubrutalism/my_neu_button.dart';
// import 'package:sylas_ai/screens/models/login_form_state/providers/log_in_form_state_provider.dart';
// import 'package:sylas_ai/screens/new_sign_up_screen.dart';
// import 'package:sylas_ai/screens/signup_screen.dart';

class LandingPageScreen extends ConsumerWidget {
  const LandingPageScreen({super.key});

  Widget _buildSignUpContent(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              top: 0.50 * MediaQuery.of(context).size.height,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Welcome to Adventure Ai',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    width: double.infinity,
                    height: 60, // Adjust the height of the button
                    child: MyNeuTextButton(
                      buttonColor: const Color(0xFFF06543),
                      buttonHeight: 60,
                      text: const Text(
                        "Let's Get Started",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const SizedBox(
                    width: double.infinity,
                    height: 60, // Adjust the height of the button
                    child: MyNeuTextButton(
                      buttonColor: Colors.white,
                      buttonHeight: 60,
                      text: Text(
                        "Already have an account",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authstate = ref.watch(authStateProvider);

    if (authstate.userId == null) {
      return _buildSignUpContent(context, ref);
    } else if (authstate.isLoading) {
      return const Center(
        child: SizedBox(
          width: 50, // Adjust the width of the CircularProgressIndicator
          height: 50, // Adjust the height of the CircularProgressIndicator
          child: CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white), // Adjust the thickness of the progress indicator
          ),
        ),
      );
    } else {
      return const Center(
        child: SizedBox(
          // Adjust the height of the CircularProgressIndicator
          child: Text(
            "Should show logged in page",
            style: TextStyle(
                fontSize: 20), // Adjust the thickness of the progress indicator
          ),
        ),
      );
    }
    // return authstate.isLoading
    //     ? const Center(
    //         child: SizedBox(
    //           width: 50, // Adjust the width of the CircularProgressIndicator
    //           height: 50, // Adjust the height of the CircularProgressIndicator
    //           child: CircularProgressIndicator(
    //             strokeWidth: 4,
    //             valueColor: AlwaysStoppedAnimation<Color>(Colors
    //                 .white), // Adjust the thickness of the progress indicator
    //           ),
    //         ),
    //       )
    //     : _buildSignUpContent(context);
  }
}
