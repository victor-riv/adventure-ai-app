import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sylas_ai/auth/models/auth_result.dart';
import 'package:sylas_ai/auth/backend/providers/auth_state_provider.dart';
import 'package:sylas_ai/neubrutalism/my_neu_button.dart';
import 'firebase_options.dart';
import 'screens/landing_page_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: AdventureAi()));
}

class AdventureAi extends ConsumerWidget {
  const AdventureAi({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn =
        ref.watch(authStateProvider).result == AuthResult.success;
    return MaterialApp(
        title: 'AI Travel Companion',
        theme: ThemeData.from(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          colorScheme: const ColorScheme.light()
              .copyWith(background: const Color(0xFFFFFFFF)),
        ),
        home: isLoggedIn ? const LoggedInView() : const LogInView());
  }
}

class LoggedInView extends ConsumerWidget {
  const LoggedInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logged In')),
      body: Center(
        child: MyNeuTextButton(
          text: const Text(
            'Log Out',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          enableAnimation: true,
          buttonColor: const Color(0xFFF06543),
          onPressed: ref.read(authStateProvider.notifier).logOut,
        ),
      ),
    );
  }
}

class LogInView extends ConsumerWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const LandingPageScreen(), // Displayed at the bottom
          Positioned(
            bottom: MediaQuery.of(context).size.height *
                0.42, // Adjust this value to position the SVG
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/svg/neuBG.svg',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
