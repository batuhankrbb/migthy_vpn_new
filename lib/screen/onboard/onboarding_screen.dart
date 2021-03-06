import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightyvpn/main.dart';
import 'package:mightyvpn/screen/onboard/widgets/custom_button.dart';
import 'package:mightyvpn/screen/onboard/widgets/main_layout.dart';
import 'package:mightyvpn/screen/onboard/widgets/onboard_page_widget.dart';
import 'package:mightyvpn/screen/onboard/widgets/onboarding_dots_list.dart';
import 'package:mightyvpn/services/notification_service.dart';

import '../../utils/constant.dart';
import '../hard_update_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageController = PageController(initialPage: 0, keepPage: true);

  var selectedIndex = 0;

  //* All Pages to show in onboarding

  @override
  void initState() {
    super.initState();
    CloudMessageHelper.shared.subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (globalStore.versionToUpdate != null) {
        return HardUpdateScreen();
      }
      return LoadingWrapper(
        child: MainLayout(
          backgroundColor: onboardBackgroundColor,
          content: Stack(
            children: [
              PageView.builder(
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return introWidgetsList[index];
                },
                onPageChanged: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                itemCount: introWidgetsList.length,
                controller: pageController,
              ),
              OnboardingDotsList(
                  introWidgetsList: introWidgetsList,
                  selectedIndex: selectedIndex),
            ],
          ),
          safeAreaBottomActivated: true,
        ),
      );
    });
  }
}
