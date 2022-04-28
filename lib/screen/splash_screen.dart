import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mightyvpn/screen/onboard/onboarding_screen.dart';
import 'package:mightyvpn/screen/paywall_screen.dart';
import '../main.dart';
import '../model/server_model.dart';
import 'bottom_nav_bar.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    afterBuildCreated(
      () {
        setStatusBarColor(context.scaffoldBackgroundColor);

        appStore.setLanguage(
            getStringAsync(SharedPrefKeys.language,
                defaultValue: AppConstant.defaultLanguage),
            context: context);
      },
    );
    animationController = AnimationController(vsync: this, duration: 1.seconds);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInQuad);
    animationController.forward();

    vpnStore.setVPNStatus();

    serverService.getServerList().listen((event) {
      vpnStore.serverList.clear();

      vpnStore.setServerList(event);

      if (getStringAsync(SharedPrefKeys.selectedServer).isEmpty) {
        appStore.setSelectedServerModel(event.first);
      } else {
        appStore.setSelectedServerModel(ServerModel.fromJson(
            jsonDecode(getStringAsync(SharedPrefKeys.selectedServer))));
      }
    });
    var showOnboard = getBoolAsync("showOnboard",defaultValue: true);
    if (showOnboard) {
      2.seconds.delay.then((value) => push(const OnboardingScreen(),
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade));
    } else {
      2.seconds.delay.then((value) => push(const PaywallScreen(),
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade));
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                  scale: animation,
                  child: commonCacheImageWidget(vpnLogo, 120,
                      width: 120, fit: BoxFit.cover)),
              16.height,
              Text(AppConstant.appName,
                  style: primaryTextStyle(size: 24, weight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
