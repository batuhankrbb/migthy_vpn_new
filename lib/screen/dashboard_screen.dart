import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    stageStream?.cancel();
    myInterstitial?.dispose();
    dataStream.cancel();
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
          toast("VPN Permission Denied");
          vpnStore.setIsPrepared(false, initialize: true);
        } else if (value == "-1") {
          toast("VPN Permission Granted");
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
                    HapticFeedback.heavyImpact();
                    if (!globalStore.hasPaywallAlertShowed &&
                        !globalStore.isPremium) {
                      globalStore.hasPaywallAlertShowed = true;
                      //TODO showalert
                      //TODO NO BASARSA AŞAĞIYA İN
                      //TODO YES BASARSA PAYWALL ÇIKART
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
              child: AutoSizeText(language.lblCurrentServer, style: boldTextStyle()),
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
              popFirst: false,
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
