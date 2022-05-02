import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      child: AutoSizeText(
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

  static TextStyle headline1({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
      fontFamily: "SfPro",
      color: color ?? AppColors.darkGrey,
      fontSize: (size ?? 32).sp,
      fontWeight: weight ?? fontSemibold,
      overflow: overflow ?? TextOverflow.visible,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

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

  static TextStyle headline2({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
      fontFamily: "SfPro",
      color: color ?? darkGrey,
      fontSize: (size ?? 25).sp,
      fontWeight: weight ?? fontBold,
      overflow: overflow ?? TextOverflow.visible,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle headline3({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
      fontFamily: "SfPro",
      color: color ?? darkGrey,
      fontSize: (size ?? 20).sp,
      fontWeight: weight ?? fontSemibold,
      overflow: overflow ?? TextOverflow.visible,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle button({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
      fontFamily: "SfPro",
      color: color ?? darkGrey,
      fontSize: (size ?? 16).sp,
      fontWeight: weight ?? fontMedium,
      overflow: overflow ?? TextOverflow.visible,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle buttonLarge({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
      fontFamily: "SfPro",
      color: color ?? darkGrey,
      fontSize: (size ?? 18).sp,
      fontWeight: weight ?? fontBold,
      overflow: overflow ?? TextOverflow.visible,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle bodySmall({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
      fontFamily: "SfPro",
      color: color ?? darkGrey,
      fontSize: (size ?? 16).sp,
      fontWeight: weight ?? fontRegular,
      overflow: overflow ?? TextOverflow.visible,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle bodyText({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
      fontFamily: "SfPro",
      color: color ?? darkGrey,
      fontSize: (size ?? 18).sp,
      fontWeight: weight ?? fontRegular,
      overflow: overflow ?? TextOverflow.visible,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle bodyMedium({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
      fontFamily: "SfPro",
      color: color ?? darkGrey,
      fontSize: (size ?? 16).sp,
      fontWeight: weight ?? fontSemibold,
      overflow: overflow ?? TextOverflow.visible,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle label({
    Color? color,
    double? size,
    FontWeight? weight,
    TextOverflow? overflow,
    bool isItalic = false,
  }) {
    return TextStyle(
      fontFamily: "SfPro",
      color: color ?? darkGrey,
      fontSize: (size ?? 14).sp,
      fontWeight: weight ?? fontRegular,
      overflow: overflow ?? TextOverflow.visible,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
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

const darkGrey = Color(0xFF33353F);

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class
  static const transparent = Colors.transparent;
  static const white = Color(0XFFFFFFFF);
  static const background = Color(0XFF1C1D22);
  static const darkGrey = Color(0XFF33353F);
  static const lightPurple = Color(0XFFC9B1FF);
  static const grey = Color(0XFFCBC8D7);
  static const purple = Color(0XFF6563FF);
  static const blue = Color(0XFFD4EDFB);
  static const mediumGrey = Color(0XFF676A79);
  static const purpGrey = Color(0XFFB1ABC7);
  static const whitePurple = Color(0XFFF6F3FF);

  static const logo = LinearGradient(colors: [
    Color(0xFFA998FF),
    Color(0xFF6563FF),
  ]);

  static final whiteLinearGradient = LinearGradient(colors: [
    const Color(0xFFFFFFFF),
    const Color(0xFFFFFFFF).withOpacity(0),
  ]);

  static const greenLinearGradient = LinearGradient(colors: [
    Color(0xFF3BC9DB),
    Color(0xFF3FDBAC),
  ]);

  static const redLinearGradient =
      LinearGradient(colors: [Color(0xFFD86A70), Color(0xFFE6ACB8)]);

  static const cardGradient = LinearGradient(colors: [
    Color(0xFFF6F3FF),
    Color(0xFFD8D3FD),
    Color(0xFFB3DAF4),
  ]);
}
