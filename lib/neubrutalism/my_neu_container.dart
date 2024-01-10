import 'package:flutter/material.dart';
import 'package:sylas_ai/neubrutalism/neu_constants.dart';

class MyNeuContainer extends StatelessWidget {
  /// A customizable neubrutalist-style Container Template, allowing
  /// user to experiment freely without any restriction in functionality.
  ///
  /// This button is built using Flutter's `Material` widget, and is designed to
  /// follow the Neubrutalism UI style guidelines.
  ///
  /// *[Constants]

  ///   - const neuBlack = Colors.black;
  ///   - const neuDefault1 = Colors.teal;
  ///   - const neuShadow = Color(0xFF080808);
  ///
  ///   - const neuBorder = 3.0;
  ///   - const neuShadowBlurRadius = 0.0;
  ///
  ///   - const neuOffset = Offset(4, 4);
  ///   - const neuBlurStyle = BlurStyle.solid;

  const MyNeuContainer({
    Key? key,
    this.offset = NeuConstants.neuOffset,
    this.color = NeuConstants.neuDefault1,
    this.shadowColor = NeuConstants.neuShadow,
    this.borderColor = NeuConstants.neuBlack,
    this.height,
    this.width,
    this.borderWidth = NeuConstants.neuBorder,
    this.shadowBlurRadius = NeuConstants.neuShadowBlurRadius,
    this.shadowBlurStyle = NeuConstants.neuBlurStyle,
    this.child,
    this.borderRadius = NeuConstants.neuBorderRadius,
  }) : super(key: key);

  /// - offset (optional): An Offset that defines the position of the shadow of the container.
  ///
  /// By default, it is set to neuOffset.

  final Offset offset;

  /// - color (optional): A Color that defines the background color of the container.
  ///
  /// By default, it is set to neuDefault1.

  final Color? color;

  /// - shadowColor (optional): A Color that defines the color of the shadow of the container.
  ///
  /// By default, it is set to neuShadow.

  final Color shadowColor;

  /// - borderColor (optional): A Color that defines the color of the border of the container.
  ///
  /// By default, it is set to neuBlack.

  final Color borderColor;

  /// - height (optional): A double that defines the height of the container.
  ///
  /// By default, it is set to null.

  final double? height;

  /// - width (optional): A double that defines the width of the container.
  ///
  /// By default, it is set to null.

  final double? width;

  /// - borderWidth (optional): A double that defines the width of the border of the container.
  ///
  /// By default, it is set to neuBorder.

  final double borderWidth;

  /// - shadowBlurRadius (optional): A double that defines the blur radius of the shadow of the container.
  ///
  /// By default, it is set to neuShadowBlurRadius.

  final double shadowBlurRadius;

  /// - shadowBlurStyle (optional): A BlurStyle that defines the style of the blur of the shadow of the container.
  ///
  /// By default, it is set to neuBlurStyle.

  final BlurStyle shadowBlurStyle;

  /// - child (optional): A widget that is displayed inside the container.
  ///
  /// By default, it is set to null.

  final Widget? child;

  /// - borderRadius (optional): A BorderRadiusGeometry that defines the radius of the corners of the container.
  ///
  /// By default, it is set to null.

  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: shadowBlurRadius,
            offset: offset,
            blurStyle: shadowBlurStyle,
          ),
        ],
        color: color,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
