import 'package:flutter/material.dart';

class ItineraryCard extends StatelessWidget {
  final String cityName;
  final String imageUrl;
  final String buttonLabel;

  const ItineraryCard({
    super.key,
    required this.cityName,
    required this.imageUrl,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: CurvedDiagonalClipper(),
          child: Container(
            height: 200,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // City name label
        Positioned(
          top: -15, // Adjust this value to move the label up or down
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: MediaQuery.sizeOf(context).width - 150,
            decoration: BoxDecoration(
              color: const Color(0xFFB6BCBF),
              borderRadius: BorderRadius.circular(12),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.9),
              //     blurRadius: 4,
              //     offset: const Offset(2, 2), // Shadow position
              //   ),
              // ],
            ),
            child: Center(
              child: Text(
                cityName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        // Plan Now button
        Positioned(
          right: 5,
          bottom: 5, // Half of the button's height
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Implement the plan now action
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF999999),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(width: 3, color: Colors.black),
            ),
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            label: Text(buttonLabel),
          ),
        ),
      ],
    );
  }
}

class CurvedDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Size of the button and the cutout
    const double buttonWidth = 125;
    const double buttonHeight = 85;
    const double curveDepth = 20; // Adjust the depth of the curve

    Path path = Path()
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - buttonHeight + curveDepth)
      // Curve inward before the button
      ..cubicTo(
        size.width,
        size.height - buttonHeight,
        size.width - curveDepth * -10,
        size.height - buttonHeight + curveDepth,
        size.width - 160 + 50,
        size.height - buttonHeight + curveDepth,
      )
      // Curve outward after the button
      ..cubicTo(
        size.width - buttonWidth - curveDepth,
        size.height - buttonHeight + curveDepth,
        size.width - buttonWidth,
        size.height,
        size.width - 135,
        size.height + 100,
      )
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
