import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sylas_ai/auth/models/auth_result.dart';
import 'package:sylas_ai/auth/backend/providers/auth_state_provider.dart';
import 'package:sylas_ai/providers/unsplash.dart';
import 'package:sylas_ai/screens/custom_app_bar.dart';
import 'package:sylas_ai/screens/itinerary_card.dart';
import 'package:sylas_ai/screens/signup_screen.dart';
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
        themeMode: ThemeMode.dark,
        theme: ThemeData.from(
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          colorScheme: const ColorScheme.light()
              .copyWith(background: const Color(0xFFFFFFFF)),
        ),
        darkTheme: ThemeData.from(
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          colorScheme:
              const ColorScheme.dark().copyWith(background: Colors.black),
        ),
        home: isLoggedIn ? const LoggedInView() : const LogInView(),
        routes: {
          '/signup': (context) => SignUpSheet(),
        });
  }
}

class LoggedInView extends ConsumerWidget {
  const LoggedInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomAppBar(),
          const Text(
            "Let's Make",
            style: TextStyle(
                color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Some Plans",
            style: TextStyle(
                color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Create or edit an itinerary below",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w100),
          ),
          Expanded(
            child: ListView(
              children: const [
                ItineraryCard(
                  cityName: 'Madrid, Spain',
                  imageUrl: 'assets/jpg/madrid.jpg',
                  buttonLabel: 'Plan Now',
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFE0E348),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0)),
                    onPressed: () {
                      ref.read(authStateProvider.notifier).logOut();
                    },
                    child: const Text("Log Out")),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class LogInView extends ConsumerWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unsplashResponse = ref.watch(unsplashProvider);

    return Scaffold(
        body: unsplashResponse.when(
            data: (UnsplashResponse? data) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  const LandingPageScreen(), // Displayed at the bottom
                  Positioned(
                    bottom: MediaQuery.of(context).size.height *
                        0.52, // Adjust this value to position the SVG
                    left: 0,
                    right: 0,
                    child: Stack(
                      children: [
                        if (data != null) ...[
                          Image.network(
                            unsplashResponse.value!.urls.regular,
                            fit: BoxFit.contain,
                          ),
                        ] else ...[
                          Image.asset(
                            'assets/jpg/madrid.jpg',
                            fit: BoxFit.contain,
                          )
                        ],
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: const Alignment(0, 0.5),
                                colors: [
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(
                                          0.9), // Color of your background
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (error, stack) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  const LandingPageScreen(), // Displayed at the bottom
                  Positioned(
                    bottom: MediaQuery.of(context).size.height *
                        0.52, // Adjust this value to position the SVG
                    left: 0,
                    right: 0,
                    child: Stack(
                      children: [
                        Image.asset(
                          'asset/jpg/madrid.jpg',
                          fit: BoxFit.contain,
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: const Alignment(0, 0.5),
                                colors: [
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(
                                          0.9), // Color of your background
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
