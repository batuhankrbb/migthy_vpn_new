import 'package:flutter/material.dart';

import 'custom_button.dart';


class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.gradient,
      this.fontSize,
      this.height = 50,
      this.width,
      this.color,
      this.padding,
      this.textColor,
      this.textStyle,
      this.textAlign,
      this.elevatedButtonPadding,
      this.borderRadius})
      : super(key: key);

  final VoidCallback onTap;
  final String text;
  final LinearGradient? gradient;
  final double? fontSize;
  final double? width;
  final double height;
  final Color? color;
  final EdgeInsets? padding;
  final Color? textColor;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final EdgeInsets? elevatedButtonPadding;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: onTap,
      padding: padding,
      borderRadius: borderRadius,
      child: Text(
        text,
        style: textStyle ??
            AppTextStyle.buttonText(
              color: textColor ?? Colors.white,
            ),
        textAlign: textAlign,
      ),
      elevatedButtonPadding: elevatedButtonPadding,
      fontSize: fontSize,
      height: height,
      width: width,
      gradient: gradient,
      color: color,
    );
  }
}



class AppTextStyle {
  AppTextStyle._();

  static TextStyle headline({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
        color: color ?? Colors.black,
        fontSize: (size ?? 22),
        fontWeight: weight ?? fontBold,
        overflow: overflow ?? TextOverflow.ellipsis,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal);
  }

  static TextStyle buttonText({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
        color: color ?? Colors.black,
        fontSize: (size ?? 16),
        fontWeight: weight ?? fontSemibold,
        overflow: overflow ?? TextOverflow.ellipsis,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal);
  }

  static TextStyle largeText({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
        color: color ?? Colors.black,
        fontSize: (size ?? 16),
        fontWeight: weight ?? fontMedium,
        overflow: overflow ?? TextOverflow.ellipsis,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal);
  }

  static TextStyle paragraph({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
       
        color: color ?? Colors.black,
        fontSize: (size ?? 14),
        fontWeight: weight ?? fontRegular,
        overflow: overflow ?? TextOverflow.ellipsis,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal);
  }

  static TextStyle tag({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
        color: color ?? Colors.black,
        fontSize: (size ?? 9),
        fontWeight: weight ?? fontSemibold,
        overflow: overflow ?? TextOverflow.ellipsis,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal);
  }
}


const fontRegular = FontWeight.w400;
const fontMedium = FontWeight.w500;
const fontSemibold = FontWeight.w600;
const fontBold = FontWeight.w700;

/* font sizes*/
const fsSmall = 12.0;
const fsSMedium = 14.0;
const fsMedium = 16.0;
const fsLargeMedium = 18.0;
const fsNormal = 20.0;
const fsLarge = 24.0;
const fsXLarge = 28.0;
const fsXXLarge = 30.0;
