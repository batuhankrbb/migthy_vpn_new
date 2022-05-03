import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:mightyvpn/screen/paywall/paywall_screen.dart';
import 'package:mightyvpn/screen/settings_screen.dart';
import '../component/AdmobComponent.dart';
import '../component/bandwidth_component.dart';
import '../component/duration_component.dart';
import '../component/ip_component.dart';
import '../component/status_component.dart';
import '../component/vpn_component.dart';
import '../main.dart';
import 'server_list_screen.dart';
import '../utils/AdConfigurationConstants.dart';
import '../utils/cached_network_image.dart';

import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/enums.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  InterstitialAd? myInterstitial;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    initializeStream();
    loadInterstitialAd();
    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
      if (globalStore.hasComeFromNotification) {
        showPaywallDashboardAlert(context);
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    stageStream?.cancel();
    myInterstitial?.dispose();
    dataStream?.cancel();
    super.dispose();
  }

  void startVPN() {
    appStore.setLoading(true);
    vpnServicesMethods
        .startVpn(server: appStore.mSelectedServerModel)
        .then((value) {
      initializeStream();
    }).catchError((e) {
      toast(e.toString(), print: true);
    });
  }

  void prepareVPN() {
    vpnServicesMethods.prepareVpn().then(
      (value) {
        log(value);
        if (value == "0") {
          toast(language.vpnPermissionDenied);
          vpnStore.setIsPrepared(false, initialize: true);
        } else if (value == "-1") {
          toast(language.vpnPermissionGranted);
          vpnStore.setIsPrepared(true, initialize: true);
        } else if (value == "1") {
          vpnStore.setIsPrepared(true, initialize: true);
          startVPN();
        }
      },
    ).catchError((e) {
      log(e.toString());
    });
  }

  Future<void> stopVpn() async {
    await vpnServicesMethods.stopVpn().then((value) {
      toast(language.lblDisconnect);
      showInterstitialAd();
      appStore.setLoading(false);
    }).catchError((e) {
      toast(e.toString());
    });
    vpnStore.setVPNStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        AppConstant.appName,
        showBack: false,
        center: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: context.height() * 0.06,
            ),
            Observer(
              builder: (_) {
                return VpnComponent(
                  vpnStatus: vpnStore.vpnStatus == VPNStatus.connected,
                  onStartTapped: () async {
                    mixpanel?.track('VPN Start Clicked');
                    HapticFeedback.heavyImpact();
                    if (!globalStore.hasPaywallAlertShowed &&
                        !globalStore.isPremium) {
                      globalStore.hasPaywallAlertShowed = true;
                      showPaywallDashboardAlert(context);
                      return;
                    }
                    if (vpnStore.vpnStatus == VPNStatus.disconnected) {
                      if (!vpnStore.mIsPrepared) {
                        prepareVPN();
                      } else {
                        startVPN();
                      }
                    } else {
                      stopVpn();
                    }
                  },
                  onTapped: () {
                    showConfirmDialogCustom(
                      context,
                      dialogType: DialogType.DELETE,
                      dialogAnimation: DialogAnimation.SCALE,
                      positiveText: language.lblDisconnect,
                      title: language
                          .lblWouldYouLikeToCancelTheCurrentVPNConnection,
                      onAccept: (c) async {
                        HapticFeedback.heavyImpact();
                        await stopVpn();
                        mixpanel?.track('VPN Stopped');
                      },
                    );
                  },
                );
              },
            ),
            60.height,
            Observer(builder: (_) => Loader().visible(appStore.isLoading)),
            16.height,
            const StatusComponent(),
            8.height,
            const DurationComponent(),
            36.height,
            const BandwidthComponent(),
            60.height,
            Align(
              alignment: Alignment.bottomLeft,
              child: AutoSizeText(language.lblCurrentServer,
                  style: boldTextStyle()),
            ).paddingSymmetric(horizontal: 26),
            8.height,
            Observer(
              builder: (_) => SettingItemWidget(
                radius: radius(),
                decoration: boxDecorationDefault(
                    borderRadius: radius(),
                    color: context.cardColor,
                    boxShadow:
                        defaultBoxShadow(blurRadius: 0, spreadRadius: 0)),
                title: appStore.mSelectedServerModel.country.validate(),
                titleTextStyle: boldTextStyle(color: primaryColor),
                leading: cachedImage(
                    appStore.mSelectedServerModel.flagUrl
                        .validate(value: 'assets/images/vpn_logo.png'),
                    width: 34,
                    height: 34),
                onTap: () {
                  push(const ServerListScreen(),
                      pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
                      duration: 250.milliseconds);
                },
              ).paddingSymmetric(horizontal: 26),
            ),
            16.height,
            PremiumButton(
              fromText: "Dashboard Screen",
              popFirst: false,
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}

///*********** */
///
///

Future<dynamic> showPaywallDashboardAlert(BuildContext context) async {
  return await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21.0),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                push(const PaywallScreen(),
                    pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
                    duration: 250.milliseconds);
                mixpanel?.track('SALE! Alert Premium Clicked');
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(116, 116, 191, 1.0)
                              .withOpacity(0.55),
                          spreadRadius: 20,
                          blurRadius: 35),
                    ]),
                width: context.width() * 0.95,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      height: context.height() * 0.07,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(116, 116, 191, 1.0),
                            Color.fromRGBO(52, 138, 199, 1.0)
                          ]),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(21.0),
                              topLeft: Radius.circular(21.0))),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        language.saleText,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: context.width() * 0.10,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: LottieBuilder.asset(
                                    "assets/images/premium_lottie.json",
                                    height: context.height() * 0.25,
                                    fit: BoxFit.fitHeight),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(116, 116, 191, 1.0)
                                                .withOpacity(0.5),
                                        spreadRadius: 4,
                                        blurRadius: 9)
                                  ],
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(116, 116, 191, 1.0),
                                    Color.fromRGBO(52, 138, 199, 1.0)
                                  ]),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 10),
                                    Image.asset(
                                      "assets/images/king.png",
                                      width: 35,
                                      height: 35,
                                    ),
                                    Spacer(),
                                    AutoSizeText(
                                      language.getPremiumText,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: context.width() * 0.05,
                                      ),
                                      maxLines: 1,
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                height: context.height() * 0.08,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(language.onlyAvailableTodayText +
                                    " " +
                                    getLowYearlyPriceForAlert() +
                                    " " +
                                    language.perYearText),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(
                                  getHighYearlyPriceForAlert() +
                                      " " +
                                      language.perYearText,
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
}
