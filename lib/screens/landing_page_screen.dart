import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylas_ai/auth/notifiers/auth_state_provider.dart';
import 'package:sylas_ai/screens/models/login_form_state/providers/log_in_form_state_provider.dart';
import 'package:sylas_ai/screens/signup_screen.dart';

class LandingPageScreen extends ConsumerWidget {
  const LandingPageScreen({super.key});

  void _navigateToSignUpScreen(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).cardColor,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SignUpSheet();
        }).whenComplete(() {
      // Might not be a good idea?
      ref.watch(loginFormStateNotiferProvider.notifier).resetState();
    });
  }

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
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Welcome to Adventure Ai',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    width: double.infinity,
                    height: 60, // Adjust the height of the button
                    child: ElevatedButton(
                      onPressed: () {
                        _navigateToSignUpScreen(context, ref);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        "Let's Get Started",
                        style: TextStyle(fontSize: 18),
                      ),
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
                            color: Colors.white,
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
                  child: SizedBox(
                    width: double.infinity,
                    height: 60, // Adjust the height of the button
                    child: OutlinedButton(
                      onPressed: () {
                        // Add logic to continue as a guest
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        side: const BorderSide(
                            color: Colors.white), // White border
                      ),
                      child: const Text(
                        'I already have an account',
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
