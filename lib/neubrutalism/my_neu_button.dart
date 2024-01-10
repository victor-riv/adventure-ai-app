import 'package:flutter/material.dart';
import 'package:sylas_ai/neubrutalism/my_neu_container.dart';
import 'package:sylas_ai/neubrutalism/neu_constants.dart';

class MyNeuButton extends StatefulWidget {
  /// A customizable neubrutalist-style  button.
  ///
  /// The button has a customizable background color, border color,
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

  const MyNeuButton({
    Key? key,
    required this.enableAnimation,
    this.buttonColor = NeuConstants.neuDefault1,
    this.shadowColor = NeuConstants.neuShadow,
    this.borderColor = NeuConstants.neuBlack,
    this.onPressed,
    this.borderRadius = NeuConstants.neuBorderRadius,
    this.offset = NeuConstants.neuOffset,
    this.buttonHeight = 50,
    this.buttonWidth = 50,
    this.shadowBlurRadius = NeuConstants.neuShadowBlurRadius,
    this.borderWidth = NeuConstants.neuBorder,
    this.animationDuration = 100,
    required this.child,
  }) : super(key: key);

  /// - child: The child widget inside of the button
  ///
  final Widget? child;

  /// - buttonColor (optional) : A Color that defines the color of the button.
  ///
  /// By default, it is set to neuDefault1 (black).
  final Color buttonColor;

  /// shadowColor (optional) : A Color that defines the color of the button's shadow.
  ///
  /// By default, it is set to neuShadow.
  ///
  final Color shadowColor;

  // - borderColor (optional) : A Color that defines the color of the button's border.
  //
  //By default, it is set to neuBlack.

  final Color borderColor;

  /// - onPressed (optional) : A callback function that is called when the button is pressed.
  ///
  final GestureTapCallback? onPressed;

  /// - borderRadius (optional) : A BorderRadiusGeometry that defines the border radius of the button.
  ///
  /// If not specified, the button will have a circular border radius.
  final BorderRadius? borderRadius;

  /// - offset : An Offset that defines the amount and direction of the blur applied to the shadow of the card.
  ///
  final Offset offset;

  /// - buttonHeight (optional) : A double value that defines the height of the button.
  ///
  final double buttonHeight;

  /// - buttonWidth (optional) : A double value that defines the width of the button.
  ///
  final double buttonWidth;

  /// - shadowBlurRadius (optional) : A double that defines the radius of the blur applied to the shadow of the card.
  ///
  /// By default, it is set to neuShadowBlurRadius.
  ///
  final double shadowBlurRadius;

  /// - borderWidth (optional) : A double value that defines the width of the button's border.
  ///
  /// By default, it is set to neuBorder.
  ///
  final double borderWidth;

  /// animate (required) : Boolean Property to toggle the Animation property of the Button Widget.
  ///
  /// Creates a smooth pressing animation beginning from Offset(0,0) to the defined [`offset`] property. (Default offset value is (4,4))
  final bool enableAnimation;

  ///animationDuration (optional) : An Int. defining the Animation Duration in milliseconds.
  ///
  ///Default value is 100ms
  final int animationDuration;

  @override
  State<MyNeuButton> createState() => MyNeuButtonState();
}

class MyNeuButtonState extends State<MyNeuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<Offset>(begin: const Offset(0, 0), end: widget.offset)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        void doOnPressedAction() {
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        }

        if (widget.enableAnimation) {
          // do the on pressed action after the
          // first part of animation
          _controller.forward().then((value) {
            doOnPressedAction();
            _controller.reverse();
          });
        } else {
          // do on pressed action without any
          // animation
          doOnPressedAction();
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        child: MyNeuContainer(
          width: widget.buttonWidth,
          height: widget.buttonHeight,
          borderRadius: widget.borderRadius,
          color: widget.buttonColor,
          borderColor: widget.borderColor,
          borderWidth: widget.borderWidth,
          shadowColor: widget.shadowColor,
          shadowBlurRadius: widget.shadowBlurRadius,
          offset: widget.offset - _animation.value,
          child: Center(child: widget.child),
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: _animation.value,
            child: child,
          );
        },
      ),
    );
  }
}

class MyNeuTextButton extends MyNeuButton {
  /// A customizable neubrutalist-style text button.
  ///
  /// The button has a text label, customizable background color, border color,
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

  const MyNeuTextButton({
    Key? key,
    required enableAnimation,
    required this.text,
    int animationDuration = 100,
    Color borderColor = NeuConstants.neuBlack,
    BorderRadius? borderRadius = NeuConstants.neuBorderRadius,
    double borderWidth = NeuConstants.neuBorder,
    Color buttonColor = NeuConstants.neuDefault1,
    double buttonHeight = 50,
    double buttonWidth = 100,
    Offset offset = NeuConstants.neuOffset,
    GestureTapCallback? onPressed,
    double shadowBlurRadius = NeuConstants.neuShadowBlurRadius,
    Color shadowColor = NeuConstants.neuShadow,
  }) : super(
          animationDuration: animationDuration,
          borderColor: borderColor,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
          buttonColor: buttonColor,
          buttonHeight: buttonHeight,
          buttonWidth: buttonWidth,
          child: text,
          enableAnimation: enableAnimation,
          key: key,
          offset: offset,
          onPressed: onPressed,
          shadowBlurRadius: shadowBlurRadius,
          shadowColor: shadowColor,
        );

  ///
  /// This Property helps to insert a Text Widget and Customize it according to your need
  final Text text;
}

class MyNeuIconButton extends MyNeuButton {
  /// A customizable neubrutalist-style icon button.
  ///
  /// The button has an icon, customizable background color, border color,
  /// and drop shadow. The button's shape can also be customized with a rounded
  /// border radius. The button's behavior is specified with an `onPressed`
  /// callback function.
  ///
  /// This button is built using Flutter's `Material` widget, and is designed to
  /// follow the Neubrutalism UI style guidelines.
  ///
  /// *[Constants]

  ///   - const neuBlack = Colors.black; /   - const neuDefault1 = Colors.teal;
  ///   - const neuShadow = Color(0xFF080808);
  ///
  ///   - const neuBorder = 3.0;
  ///   - const neuShadowBlurRadius = 0.0;
  ///
  ///   - const neuOffset = Offset(4, 4);
  ///   - const neuBlurStyle = BlurStyle.solid;

  const MyNeuIconButton({
    Key? key,
    required enableAnimation,
    required this.icon,
    int animationDuration = 100,
    Color borderColor = NeuConstants.neuBlack,
    BorderRadius? borderRadius = NeuConstants.neuBorderRadius,
    double borderWidth = NeuConstants.neuBorder,
    Color buttonColor = NeuConstants.neuDefault1,
    double buttonHeight = 50,
    double buttonWidth = 100,
    Offset offset = NeuConstants.neuOffset,
    GestureTapCallback? onPressed,
    double shadowBlurRadius = NeuConstants.neuShadowBlurRadius,
    Color shadowColor = NeuConstants.neuShadow,
  }) : super(
          animationDuration: animationDuration,
          borderColor: borderColor,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
          buttonColor: buttonColor,
          buttonHeight: buttonHeight,
          buttonWidth: buttonWidth,
          child: icon,
          enableAnimation: enableAnimation,
          key: key,
          offset: offset,
          onPressed: onPressed,
          shadowBlurRadius: shadowBlurRadius,
          shadowColor: shadowColor,
        );

  /// - icon (required) : A Icon Widget to help you add icons.
  ///
  final Icon icon;
}
