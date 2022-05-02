import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../extra/rate/rate_sheet_first.dart';
import '../../onboard/widgets/custom_text_button.dart';

class PaywallFeatureCell extends StatelessWidget {
  const PaywallFeatureCell({Key? key, required this.icon, required this.text})
      : super(key: key);

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          color: Color(0xFFB3DAF4),
          width: 24.w,
          height: 24.w,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          text,
          style: AppTextStyle.headline2(
            color: Colors.white,
            size: 18.sp,
            weight: fontRegular,
          ),
        ),
      ],
    );
  }
}

//* Svg Picture doesn't have a gradient property. So, I creatd this widget.
class GradientSvgPicture extends StatelessWidget {
  const GradientSvgPicture(
      {Key? key, required this.gradient, required this.svgPicture})
      : super(key: key);

  final Gradient gradient;
  final SvgPicture svgPicture;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      //* SvgPicture doesn't have a gradient property. So, we should add gradident with shared mask widget.
      shaderCallback: (rect) {
        return gradient.createShader(rect);
      },
      child: svgPicture,
    );
  }
}

const cardGradient = LinearGradient(colors: [
  Color(0xFFF6F3FF),
  Color(0xFFD8D3FD),
  Color(0xFFB3DAF4),
]);

const fontRegular = FontWeight.w400;
const fontMedium = FontWeight.w500;
const fontSemibold = FontWeight.w600;
const fontBold = FontWeight.w700;
