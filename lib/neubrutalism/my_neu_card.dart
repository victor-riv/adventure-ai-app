import 'package:flutter/material.dart';
import 'package:sylas_ai/neubrutalism/neu_constants.dart';

class MyNeuCard extends StatelessWidget {
  /// A customizable neubrutalist-style Image-Container.
  ///
  /// The Container has a child, customizable background color, border color,
  /// and drop shadow. The button's shape can also be customized with a rounded
  /// border radius. The button's behavior is specified with an `onPressed`
  /// callback function.
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
  ///
  ///
  ///
  MyNeuCard({
    Key? key,
    this.offset = NeuConstants.neuOffset,
    this.cardColor,
    this.shadowColor = NeuConstants.neuShadow,
    this.cardBorderColor = NeuConstants.neuBlack,
    this.imageBorderColor = NeuConstants.neuBlack,
    this.paddingData,
    this.cardHeight,
    this.cardWidth,
    this.cardBorderWidth = NeuConstants.neuBorder,
    this.shadowBlurRadius = NeuConstants.neuShadowBlurRadius,
    this.imageBorderWidth = NeuConstants.neuBorder,
    this.shadowBlurStyle = NeuConstants.neuBlurStyle,
    this.child,
    this.borderRadius,
  }) : super(key: key);

  /// - offset : An Offset that defines the amount and direction of the blur applied to the shadow of the card.
  ///
  final Offset offset;

  /// - cardColor (optional) : A Color that defines the background color of the card.
  ///
  /// By default, it is set to neuDefault1.
  final Color? cardColor;

  /// - shadowColor (optional) : A Color that defines the color of the card's shadow.
  ///
  /// By default, it is set to neuShadow.
  ///
  final Color shadowColor;

  /// - cardBorderColor (optional) : A Color that defines the color of the border of the card.
  ///
  /// By default, it is set to neuBlack
  final Color cardBorderColor;

  /// - imageBorderColor (optional) : A Color that defines the color of the border of the image inside the card.
  ///
  /// By default, it is set to neuBlack.
  final Color imageBorderColor;

  /// - paddingData (optional) : An EdgeInsetsGeometry that defines the padding for the contents of the card.
  final EdgeInsets? paddingData;

  /// - cardHeight (optional) : A double that defines the height of the card.
  ///
  ///
  final double? cardHeight;

  /// - cardWidth (optional) : A double that defines the width of the card.
  ///
  final double? cardWidth;

  /// - cardBorderWidth (optional) : A double that defines the width of the border of the card.
  ///
  ///  By default, it is set to neuBorder.
  final double cardBorderWidth;

  /// - shadowBlurRadius (optional) : A double that defines the radius of the blur applied to the shadow of the card.
  ///
  /// By default, it is set to neuShadowBlurRadius.
  ///
  final double shadowBlurRadius;

  /// - imageBorderWidth (optional) : A double that defines the width of the border of the image inside the card.
  ///
  /// By default, it is set to 1.0.
  ///
  final double imageBorderWidth;

  /// - shadowBlurStyle (optional) : A BlurStyle that defines the style of the blur applied to the shadow of the card.
  ///
  /// By default, it is set to BlurStyle.normal.
  final BlurStyle shadowBlurStyle;

  /// - child (optional) : A widget that is displayed inside the card.
  final Widget? child;

  /// - borderRadius(optional): A BorderRadius parameter helpful for twerking the Card Shape
  ///
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: cardBorderColor,
            width: cardBorderWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: shadowBlurRadius,
              offset: offset,
              blurStyle: shadowBlurStyle,
            ),
          ],
          color: cardColor,
        ),
        padding: paddingData,
        child: child);
  }
}
