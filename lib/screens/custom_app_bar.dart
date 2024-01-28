import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/jpg/madrid.jpg'),
              // child: Text('V'),
            ),
            const SizedBox(
              width: 20,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Victor Rivera',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              child: const HamburgerIcon(),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

class HamburgerIcon extends StatelessWidget {
  const HamburgerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20, // Width of the icon
      height: 20, // Height of the icon
      child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // Space between lines
          children: [
            buildLine(0.3),
            buildLine(1),
            buildLine(0.3, startHalf: true),
          ]),
    );
  }

  Widget buildLine(double length, {bool startHalf = false}) {
    return Align(
      alignment: startHalf ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 30 * length,
        height: 3,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(2)),
      ),
    );
  }
}
