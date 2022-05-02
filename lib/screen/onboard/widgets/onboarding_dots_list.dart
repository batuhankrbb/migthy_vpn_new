import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mightyvpn/extra/rate/rate_sheet_first.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../main.dart';
import '../../../utils/constant.dart';
import '../../../utils/purchase_helper.dart';
import '../../bottom_nav_bar.dart';
import 'custom_text_button.dart';
import 'onboard_dot_widget.dart';

class OnboardingDotsList extends StatelessWidget {
  const OnboardingDotsList(
      {Key? key, required this.introWidgetsList, required this.selectedIndex})
      : super(key: key);

  final List<Widget> introWidgetsList;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == (introWidgetsList.length - 1)) {
      //* Return Get Started Button instead of dots if it's the last page.
      return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextButton(
                width: 325,
                onTap: () async {
                  try {
                    await setValue("showOnboard", false);
                    globalStore.isLoading = true;
                    var isPurchased = await PurchaseHelper.shared
                        .purchase(PurchaseHelper.shared.packageList[2]);
                    globalStore.isLoading = false;
                    if (isPurchased) {
                      push(const BottomNavBar(),
                          isNewTask: true,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    }
                    mixpanel?.track('Onboard expensive purchase clicked');
                  } catch (e) {
                         globalStore.isLoading = false;
                  }
                },
                text: language.buyAndContinueText),
            SizedBox(
              height: 10,
            ),
            AutoSizeText(getYearlyPrice() + " " + language.perYearText),
            SizedBox(
              height: 5,
            ),
            AutoSizeText(
             language.recurringText,
              style: TextStyle(
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w100,
                  fontSize: 8),
            ),
          ],
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Spacer(),
        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < introWidgetsList.length; i++) ...[
                OnboardDotWidget(
                  isActive: selectedIndex == i,
                )
              ]
            ],
          ),
        ),
        SizedBox(
          height: 65,
        ),
      ],
    );
  }

  String getYearlyPrice() {
    try {
      return PurchaseHelper.shared.packageList[2].product.priceString;
    } catch (e) {
      return "\$$annualPriceHighConstant";
    }
  }
}
