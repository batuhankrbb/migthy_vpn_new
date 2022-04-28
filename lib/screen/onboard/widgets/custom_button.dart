import 'package:flutter/material.dart';
import 'package:mightyvpn/utils/constant.dart';

//* This is the main button component. Other buttons depend on this button.
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.child,
    this.width,
    this.gradient,
    this.fontSize,
    this.color,
    this.height = 50,
    this.padding,
    this.elevatedButtonPadding,
    this.borderRadius,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;
  final LinearGradient? gradient;
  final Color?
      color; //* Either color or gradient should be null. If they aren't null, gradient will be ignored. // if you want to have a transparent background, give Colors.transparent
  final double? fontSize;
  final double? width;
  final double height;
  final EdgeInsets? padding;
  final EdgeInsets? elevatedButtonPadding;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        color: primaryColor,
      ),
      child: ElevatedButton(
      onPressed: onTap,
      child: child,
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: elevatedButtonPadding),
    ),
    );
  }
}
