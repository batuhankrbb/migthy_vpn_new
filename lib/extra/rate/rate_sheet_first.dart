import 'package:auto_size_text/auto_size_text.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'widgets/rate_starts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

class RateSheetFirst extends StatelessWidget {
  RateSheetFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(builder: (context) {
        return AnimatedOpacity(
          opacity: rateSheetViewModel.firstSheetOpacity,
          duration: Duration(seconds: 1),
          child: Visibility(
            visible: rateSheetViewModel.isFirstSheetVisible,
            child: Container(
              color: primaryColor,
              child: Column(
                children: [
                  Image.asset(
                    vpnLogo,
                    width: context.width() * (0.2),
                    height: context.width() * (0.2),
                  ),
                  SizedBox(
                    height: context.height() * (0.003),
                  ),
                  CustomText(
                    language.doYouLikeUs,
                    fontWeight: fontBold,
                    color: Colors.white,
                    fontSize: context.width() * (0.07),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: context.height() * (0.005),
                  ),
                  CustomText(
                   language.letUsKnowWhat,
                    fontWeight: fontLight,
                    color: Colors.white,
                    fontSize: context.width() * (0.04),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: context.height() * (0.03),
                  ),
                  Container(
                    height: context.height() * (0.1),
                    child: RatingBar(
                      rating: 0,
                      icon: SvgPicture.asset(
                        "assets/images/icon_rating_star.svg",
                        color: Colors.black26,
                      ),
                      starCount: 5,
                      onRatingCallback: (value, isIndicator) {
                        rateSheetViewModel.rating = value;
                        isIndicator?.value = true;
                        rateSheetViewModel.firstSheetOpacity = 0;
                        Future.delayed(Duration(seconds: 1), () {
                          rateSheetViewModel.isFirstSheetVisible = false;
                        });
                      },
                      spacing: context.width() * (0.01),
                      size: context.width() * (0.13),
                      isIndicator: false,
                      allowHalfRating: true,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class CustomText extends StatelessWidget {
  String text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  TextOverflow? overflow;
  bool isItalic;
  String? fontFamily;
  int? maxLines;
  TextAlign? textAlign;
  double? minFontSize;
  TextDecoration? decoration;

  CustomText(
    this.text, {
    Key? key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.isItalic = false,
    this.fontFamily,
    this.maxLines,
    this.textAlign,
    this.minFontSize,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: fontSize ?? 22,
          fontWeight: fontWeight ?? FontWeight.bold,
          overflow: overflow,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          fontFamily: fontFamily,
          decoration: decoration),
      maxLines: maxLines,
      overflow: overflow,
      minFontSize: minFontSize ?? 12,
      textAlign: textAlign,
    );
  }
}

const fontThin = FontWeight.w200;
const fontLight = FontWeight.w300;
const fontRegular = FontWeight.w400;
const fontMedium = FontWeight.w500;
const fontSemibold = FontWeight.w600;
const fontBold = FontWeight.w700;
const fontHeavy = FontWeight.w800;
const fontBlack = FontWeight.w900;
