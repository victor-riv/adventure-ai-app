import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylas_ai/neubrutalism/my_neu_button.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Visibility(
          //   visible: false,
          //   child: MyNeuIconButton(
          //     buttonColor: Colors.white,
          //     icon: const Icon(Icons.arrow_back_ios),
          //     buttonHeight: 40,
          //     buttonWidth: 40, // Replace with your actual icon
          //     // Add other necessary parameters
          //     onPressed: () {
          //       // Your button 1 action
          //     },
          //   ),
          // ),
          NeuAvatarButton(
            imagePath: 'assets/png/spongebob.png',
            buttonHeight: 40,
            buttonWidth: 40,
          ),
          SizedBox(
            width: 15,
          ),
          Text('Hi Victor', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
