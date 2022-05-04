import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mightyvpn/screen/paywall/widgets/paywall_feature_cell.dart';

import '../../onboard/widgets/custom_text_button.dart';

class PaywallOptionCell extends StatelessWidget {
  const PaywallOptionCell(
      {Key? key,
      required this.title,
      this.subtitle,
      required this.icon,
      this.tag,
      this.isColored = false,
      required this.onTap})
      : super(key: key);

  final String title;
  final String? subtitle;
  final String icon;
  final String? tag;
  final bool isColored;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
                gradient: isColored ? cardGradient : null,
                borderRadius: BorderRadius.circular(
                  15.r,
                ),
                border: Border.all(color: Color(0xFFF6F3FF), width: 3),
                color: isColored ? null : AppColors.background),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 13.w,
                  ),
                  SvgPicture.asset(
                    icon,
                    width: 30.w,
                    height: 30.w,
                    color: isColored ? AppColors.purple : AppColors.grey,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.headline2(
                            color: isColored ? darkGrey : AppColors.white),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        subtitle!,
                        style: AppTextStyle.button(
                            color: isColored ? darkGrey : AppColors.white),
                      ),
                    ],
                  ),
                ]),
          ),
          buildTagText()
        ],
      ),
    );
  }

  Widget buildTagText() {
    if (tag != null) {
      return Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 35.h,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            gradient: cardGradient,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Text(
            tag!,
            style: AppTextStyle.button(color: AppColors.background),
          ),
        ),
      );
    }
    return SizedBox();
  }
}
