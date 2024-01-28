import 'package:flutter/material.dart';

class CityContainer extends StatelessWidget {
  final String cityName;
  final String imageUrl;
  final String buttonLabel;

  const CityContainer({
    super.key,
    required this.cityName,
    required this.imageUrl,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
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
        size.width - 40,
        size.height - buttonHeight,
        size.width - curveDepth * -10,
        size.height - buttonHeight + curveDepth,
        size.width - buttonWidth + curveDepth,
        size.height - buttonHeight + curveDepth,
      )
      // Curve outward after the button
      ..cubicTo(
        size.width - buttonWidth - curveDepth,
        size.height - buttonHeight + curveDepth,
        size.width - buttonWidth,
        size.height,
        size.width - buttonWidth,
        size.height,
      )
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// class DiagonalClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // You'll adjust these sizes to fit the button you are using
//     const double cutWidth = 130; // The width of the cutout corner
//     const double cutHeight = 70; // The height of the cutout corner

//     Path path = Path()
//       ..lineTo(0, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height - cutHeight) // Start the cut here
//       // Create a diagonal path for the cutout
//       ..lineTo(size.width - cutWidth, size.height - cutHeight)
//       ..lineTo(size.width - cutWidth, size.height)
//       ..lineTo(0, size.height)
//       ..close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }



// class DiagonalClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     const double cutSize = 40; // Define the size of the cutout corner

//     Path path = Path()
//       ..lineTo(0, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height - cutSize)
//       ..lineTo(size.width - cutSize, size.height)
//       ..lineTo(0, size.height)
//       ..lineTo(0, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

// class CityContainer extends StatelessWidget {
//   final String cityName;
//   final String imageUrl;

//   const CityContainer({
//     super.key,
//     required this.cityName,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topCenter,
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           height: 200,
//           margin: const EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             image: DecorationImage(
//               image: AssetImage(imageUrl),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Positioned(
//           top: -10, // Aligns with the top edge of the stack
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.9),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
//             child: Text(
//               cityName,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 5,
//           right: 5,
//           child: ElevatedButton(
//             onPressed: () {
//               // TODO: Implement the plan now action
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black, // Button color
//               foregroundColor: Colors.white, // Text color
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//             ),
//             child: const Text('Plan Now'),
//           ),
//         ),
//       ],
//     );
//   }
// }
