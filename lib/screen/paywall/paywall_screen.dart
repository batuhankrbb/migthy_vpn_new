import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mightyvpn/screen/onboard/widgets/custom_button.dart';
import 'package:mightyvpn/screen/paywall/widgets/paywall_feature_cell.dart';
import 'package:mightyvpn/screen/paywall/widgets/paywall_option_cell.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../main.dart';
import '../../utils/constant.dart';
import '../../utils/purchase_helper.dart';
import '../onboard/widgets/custom_text_button.dart';
import '../onboard/widgets/main_layout.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({Key? key}) : super(key: key);

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  @override
  Widget build(BuildContext context) {
    return LoadingWrapper(
      child: MainLayout(
        backgroundColor: AppColors.background,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        content: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: LottieBuilder.asset(
                  "assets/images/rocket_lottie.json",
                  width: 240.w,
                  height: 240.w,
                )),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 55.h,
                ),
                Opacity(
                  opacity: 0,
                  child: Center(
                      child: LottieBuilder.asset(
                    "assets/images/rocket_lottie.json",
                    width: 150.w,
                    height: 150.w,
                  )),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  language.paywallTitleText,
                  style: AppTextStyle.headline1(
                      weight: fontBold, size: 40.sp, color: AppColors.white),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  language.paywallSubTitleText,
                  style: AppTextStyle.headline1(
                      weight: fontSemibold,
                      size: 26.sp,
                      color: const Color(0xFFCBC8D7)),
                ),
                SizedBox(
                  height: 29.h,
                ),
                const PaywallFeatureCell(
                    icon: "assets/images/world.svg",
                    text: language.paywallCountriesText),
                SizedBox(
                  height: 25.h,
                ),
                const PaywallFeatureCell(
                    icon: "assets/images/fast.svg",
                    text: language.paywallFastServersText),
                SizedBox(
                  height: 25.h,
                ),
                const PaywallFeatureCell(
                    icon: "assets/images/bandwith.svg",
                    text: language.paywallBandwithText),
                SizedBox(
                  height: 25.h,
                ),
                const PaywallFeatureCell(
                  icon: "assets/images/no_ads.svg",
                  text: language.paywallNoAds,
                ),
                SizedBox(
                  height: 60.h,
                ),
                PaywallOptionCell(
                  onTap: () async {
                    try {
                      await purchase(
                          package: PurchaseHelper.shared.packageList[1],
                          context: context);
                      mixpanel?.track("Click Annual Purchase");
                    } catch (e) {
                      globalStore.isLoading = false;
                    }
                  },
                  title: "${getYearlyPrice()} / ${language.yearText}",
                  subtitle:
                      "${getYearlyMonthlyPrice()} / ${language.monthOrWeekText}",
                  icon: "assets/images/crown.fill.svg",
                  isColored: true,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PaywallOptionCell(
                  onTap: () async {
                    try {
                      await purchase(
                          package: PurchaseHelper.shared.packageList[0],
                          context: context);
                      mixpanel?.track("Click Monthly Purchase");
                    } catch (e) {
                      globalStore.isLoading = false;
                    }
                  },
                  title: "${getMonthlyPrice()} / ${language.monthOrWeekText}",
                  subtitle: language.billedMonthlyOrWeeklyText,
                  icon: "assets/images/icon_rating_star.svg",
                ),
                SizedBox(
                  height: 20.h,
                ),
                AutoSizeText(
                  language.recurringText,
                  style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w100,
                      fontSize: 8),
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                mixpanel?.track('Paywall skip button clicked');
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(right: 10.w, top: 30.h),
                alignment: Alignment.topRight,
                child:
                    Icon(CupertinoIcons.xmark, size: 30.w, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> purchase(
      {required Package package, required BuildContext context}) async {
    try {
      globalStore.isLoading = true;
      var isPurchased = await PurchaseHelper.shared.purchase(package);
      globalStore.isLoading = false;
      if (isPurchased) {
        Navigator.pop(context);
      }
    } catch (e) {
      globalStore.isLoading = false;
    }
  }

  String getMonthlyPrice() {
    try {
      return PurchaseHelper.shared.packageList[0].product.priceString;
    } catch (e) {
      return "\$$monthlyPriceConstant";
    }
  }

  String getYearlyPrice() {
    try {
      return PurchaseHelper.shared.packageList[1].product.priceString;
    } catch (e) {
      return "\$$annualPriceConstant";
    }
  }

  String getYearlyMonthlyPrice() {
    try {
      return PurchaseHelper.shared.get12MonthsMonthly();
    } catch (e) {
      var sale = (annualPriceConstant / 12).toStringAsFixed(2);
      return "\$$sale";
    }
  }
}

const fontRegular = FontWeight.w400;
const fontMedium = FontWeight.w500;
const fontSemibold = FontWeight.w600;
const fontBold = FontWeight.w700;

String getHighYearlyPriceForAlert() {
  try {
    return PurchaseHelper.shared.packageList[2].product.priceString;
  } catch (e) {
    return "\$$annualPriceHighConstant";
  }
}

String getLowYearlyPriceForAlert() {
  try {
    return PurchaseHelper.shared.packageList[2].product.priceString;
  } catch (e) {
    return "\$$annualPriceConstant";
  }
}
