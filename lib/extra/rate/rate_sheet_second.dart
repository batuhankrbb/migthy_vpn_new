import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:mightyvpn/extra/rate/rate_sheet_first.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import 'widgets/rate_starts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

class RateSheetSecond extends StatelessWidget {
  RateSheetSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              height: context.height() * (0.1),
              child: Observer(builder: (_) {
                return RatingBar(
                  rating: rateSheetViewModel.rating,
                  preRating: rateSheetViewModel.rating,
                  icon: SvgPicture.asset(
                      "assets/images/icon_rating_star.svg",
                    color: Colors.black26,
                  ),
                  starCount: 5,
                  spacing: context.width() * (0.01),
                  size: context.width() * (0.13),
                  isIndicator: true,
                  color: Colors.yellow,
                );
              })),
          Observer(builder: (_) {
            return CustomText(
              rateSheetViewModel.rating >= 4
                  ? "You are amazing!"
                  : "Oh! That is sad.",
              fontWeight: fontBold,
              color: Colors.white,
              fontSize: context.width() * (0.08),
              maxLines: 1,
            );
          }),
          SizedBox(
            height: context.height() * (0.009),
          ),
          Observer(builder: (_) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: context.width() * (0.02)),
              child: CustomText(
                rateSheetViewModel.rating >= 3
                    ? "Would you mind rating us?"
                    : "Would you like to tell us your problem?  We promise that we'll reply you and fix your problem as soon as humanly possible.",
                fontWeight: fontLight,
                color: Colors.white,
                textAlign: TextAlign.center,
                maxLines: 2,
                fontSize: context.width() * (0.04),
              ),
            );
          }),
          SizedBox(
            height: context.height() * (0.04),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width() * (0.05)),
            child: Row(
              children: [
                RoundedCustomButton(
                  text: "NO, THANKS",
                  onTap: () async {
                    await rateSheetViewModel.noAction(context);
                  },
                  backgroundColor: Colors.transparent,
                  radius: context.height() * (1),
                  border: Border.all(color: Colors.white, width: 2),
                  height: context.height() * (0.07),
                  padding: EdgeInsets.all(context.width() * (0.035)),
                  width: context.width() * (0.4),
                ),
                Spacer(),
                RoundedCustomButton(
                  text: "SURE",
                  onTap: () async {
                    if (rateSheetViewModel.rating >= 3) {
                      await rateSheetViewModel.sureAction(context);
                    } else {
                      rateSheetViewModel.navigateToFeedback(context);
                    }
                  },
                  backgroundColor: Colors.white,
                  radius: context.width() * (1),
                  height: context.height() *  (0.07),
                  padding: EdgeInsets.all(context.width() * (0.035)),
                  width: context.width() * (0.4),
                  textColor: primaryColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class RoundedCustomButton extends StatefulWidget {
  RoundedCustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.backgroundColor = primaryColor,
      this.textColor = Colors.white,
      this.radius = 12,
      this.width,
      this.padding,
      this.height,
      this.border})
      : super(key: key);

  @override
  _RoundedCustomButtonState createState() => _RoundedCustomButtonState();

  Color backgroundColor;
  String text;
  Color textColor;
  double radius;
  double? width;
  VoidCallback onTap;
  EdgeInsets? padding;
  double? height;
  BoxBorder? border;
}

class _RoundedCustomButtonState extends State<RoundedCustomButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: widget.onTap,
      child: Container(
        height: widget.height,
        alignment: Alignment.center,
        padding: widget.padding ?? EdgeInsets.all(context.width() * (0.02)),
        width: widget.width ?? context.width() * (0.6),
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.radius),
            border: widget.border),
        child: AutoSizeText(
          widget.text,
          maxLines: 1,
          style: TextStyle(
              color: widget.textColor,
              fontSize: context.width() * (0.055),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
