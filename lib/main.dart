import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sylas_ai/auth/models/auth_result.dart';
import 'package:sylas_ai/auth/backend/providers/auth_state_provider.dart';
import 'package:sylas_ai/neubrutalism/my_neu_button.dart';
import 'package:sylas_ai/neubrutalism/my_neu_container.dart';
import 'package:sylas_ai/neubrutalism/my_neu_search_bar.dart';
import 'package:sylas_ai/screens/custom_app_bar.dart';
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
        theme: ThemeData.from(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          colorScheme: const ColorScheme.light()
              .copyWith(background: const Color(0xFFFFFFFF)),
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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(),
            const Text(
              "Let's Plan Your Next Vacation",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(children: [
              Expanded(
                child: NeuTextField(
                  hintText: "Where's your destination?",
                  searchBarColor: Colors.white,
                ),
              ),
            ]),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Top Destinations",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            SidewaysScrollableCards(),
            const SizedBox(
              height: 20,
            ),
            MyNeuTextButton(
              text: const Text(
                'Log Out',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              enableAnimation: true,
              buttonColor: const Color(0xFFF06543),
              onPressed: ref.read(authStateProvider.notifier).logOut,
            ),
          ],
        ),
      ),
    );
  }
}

class SidewaysScrollableCards extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => 'Item $index');

  SidewaysScrollableCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 200, // Set the height of the container
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CardWidget(item: items[index]);
        },
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String item;

  const CardWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Set the width of each card
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MyNeuContainer(
        offset: const Offset(4, 2),
        color: Colors.white,
        child: Column(
          children: [
            Image.asset(
              'assets/png/spongebob.png',
              height: 160 * 0.8,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'First Row Text',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Second Row Text'),
                ],
              ),
            ),
          ],
        ),
        // Add more styling and content to the card as needed
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

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.image,
    required this.text,
  });
  final Image image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyNeuContainer(
        height: 260,
        width: 230,
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        child: Column(
          children: [
            image,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  text,
                  style: GoogleFonts.robotoCondensed(
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Row(
                children: [
                  const Icon(Icons.access_time_outlined),
                  Text(
                    "30 hrs",
                    style: GoogleFonts.robotoCondensed(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Icon(Icons.star_border),
                  Text(
                    "4.5",
                    style: GoogleFonts.robotoCondensed(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: MyNeuIconButton(
                    buttonHeight: 30,
                    buttonWidth: 30,
                    buttonColor: const Color.fromARGB(255, 248, 250, 194),
                    icon: const Icon(Icons.arrow_forward),
                    enableAnimation: true,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
