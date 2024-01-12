import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'screens/landing_page_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'AI Travel Companion',
        theme: ThemeData.from(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            colorScheme: const ColorScheme.light()
                .copyWith(background: const Color(0xFFFFFFFF))),
        home: const AdventureAiApp());
  }
}

class AdventureAiApp extends ConsumerWidget {
  const AdventureAiApp({super.key});

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
