import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
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
      () async {
        setStatusBarColor(context.scaffoldBackgroundColor);
        String defaultLocale = Platform.localeName;
        print("nihat = ${defaultLocale}");
        late LanguageDataModel data;
        var changeLanguageBefore =
            getBoolAsync("changeLanguageBefore", defaultValue: false);
        if (!changeLanguageBefore) {
          try {
            data = languageList().firstWhere(((element) {
              return element.languageCode ==
                  defaultLocale[0] + defaultLocale[1];
            }));
          } catch (e) {
            data = LanguageDataModel(
                id: 1,
                name: 'English',
                subTitle: 'English',
                languageCode: 'en',
                fullLanguageCode: 'en-US',
                flag: LanguageImages.icUs);
          }
          await setValue(SELECTED_LANGUAGE_CODE, data.languageCode);
          selectedLanguageDataModel = data;
          await appStore.setLanguage(data.languageCode!, context: context);
        } else {
          try {
            await appStore.setLanguage(
                getStringAsync(SharedPrefKeys.language,
                    defaultValue: AppConstant.defaultLanguage),
                context: context);
          } catch (e) {
            await appStore.setLanguage(
                getStringAsync(AppConstant.defaultLanguage,
                    defaultValue: AppConstant.defaultLanguage),
                context: context);
          }
        }
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
    var showOnboard = getBoolAsync("showOnboard", defaultValue: true);
    if (showOnboard) {
      2.seconds.delay.then((value) => push(const OnboardingScreen(),
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade));
    } else {
      2.seconds.delay.then((value) => push(const BottomNavBar(),
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
              AutoSizeText(AppConstant.appName,
                  style: primaryTextStyle(size: 24, weight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
