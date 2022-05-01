import 'package:flutter/material.dart';
import 'package:mightyvpn/screen/paywall_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../main.dart';
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
                  await setValue("showOnboard", false);
                  push(const BottomNavBar(),
                      isNewTask: true,
                      pageRouteAnimation: PageRouteAnimation.Fade);
                  //TODO PURCHASE
                },
                text: language.buyAndContinueText),
            SizedBox(
              height: 10,
            ),
            Text("\$49.00 ." + language.perYearText),
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
          height: 50,
        ),
      ],
    );
  }
}
