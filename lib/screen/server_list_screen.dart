import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyvpn/screen/paywall_screen.dart';
import '../component/AdmobComponent.dart';
import '../main.dart';
import '../model/server_model.dart';
import '../utils/AdConfigurationConstants.dart';
import '../utils/AdMobUtils.dart';
import '../utils/cached_network_image.dart';

import 'package:nb_utils/nb_utils.dart';

import '../utils/constant.dart';

class ServerListScreen extends StatefulWidget {
  const ServerListScreen({Key? key}) : super(key: key);

  @override
  _ServerListScreenState createState() => _ServerListScreenState();
}

class _ServerListScreenState extends State<ServerListScreen> {
  int isSelected = -1;
  int selectedButNotPremium = -1;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isSelected = vpnStore.serverList.indexWhere(
        (element) => element.uid == appStore.mSelectedServerModel.uid);
    loadInterstitialAd();
    loadRewardedAd();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: appBarWidget(
          language.lblServerList,
          backWidget: IconButton(
            onPressed: () {
              showInterstitialAd();
              doneAction();
            },
            icon: Icon(Icons.arrow_back_outlined, color: context.iconColor),
          ),
          showBack: true,
          elevation: 0,
          center: true,
        ),
        // myBanner != null ? Container(height: AdSize.banner.height.toDouble(), child: AdWidget(ad: myBanner!), color: Colors.white):SizedBox(),
        body: Observer(
          builder: (_) => Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: List.generate(
                  vpnStore.serverList.length,
                  (index) {
                    ServerModel data = vpnStore.serverList[index];
                    bool selected = isSelected == index;
                    return Stack(
                      children: [
                        SettingItemWidget(
                          title: data.country.validate(),
                          decoration: BoxDecoration(
                              color: context.cardColor, borderRadius: radius()),
                          leading: cachedImage(
                              data.flagUrl.validate(
                                  value: 'assets/images/vpn_logo.png'),
                              width: 34,
                              height: 34),
                          trailing:
                              buildTrailing(data, context, selected, index),
                          onTap: () {
                            if (globalStore.isPremium ||
                                !(data.isPremium ?? true)) {
                              isSelected = index;
                              setState(() {});
                            } else {
                              selectedButNotPremium = index;
                              showPremiumAlert(context, index);
                            }
                          },
                          radius: radius(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<dynamic> showPremiumAlert(BuildContext context, int index) {
    return showDialog(
        context: context,
        barrierColor: Colors.black87,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21.0),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21.0),
                ),
                width: context.width() * 0.9,
                height: context.height() * 0.5,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(21.0),
                              topRight: Radius.circular(21.0))),
                      width: double.infinity,
                      height: context.height() * 0.1,
                      alignment: Alignment.center,
                      child: Text(
                        "This is a premium server.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    40.height,
                    TextButton(
                      onPressed: () {
                        alertWatchAdClick(index);
                      },
                      child: Text("Watch Ad"),
                    ),
                    20.height,
                    TextButton(
                      onPressed: alertPaywallClick,
                      child: Text("Get Premium"),
                    ),
                  ],
                ),
              ));
        });
  }

  void alertWatchAdClick(int index) {
    showRewardedAd(onWinReward: (() {
      isSelected = index;
      setState(() {});
    }));
    Navigator.pop(context);
  }

  void alertPaywallClick() {
    Navigator.pop(context);
    push(const PaywallScreen(),
        pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
        duration: 250.milliseconds);
  }

  Widget buildTrailing(
      ServerModel data, BuildContext context, bool selected, int index) {
    if (globalStore.isPremium ||
        !(data.isPremium ?? true) ||
        isSelected == index) {
      //* premium ise
      return Row(
        children: [
          selected
              ? Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor)),
                  child: const Icon(Icons.done, size: 16, color: primaryColor),
                )
              : Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      shape: BoxShape.circle),
                ),
        ],
      );
    } else {
      return buildPremiumRow();
    }
  }

  Widget buildPremiumRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/king.png",
          width: MediaQuery.of(context).size.width * 0.063,
          height: MediaQuery.of(context).size.width * 0.063,
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          children: [
            SizedBox(
              height: 3,
            ),
            Image.asset("assets/images/watch_ads.png",
                width: MediaQuery.of(context).size.width * 0.05,
                height: MediaQuery.of(context).size.width * 0.05,
                fit: BoxFit.fill),
          ],
        )
      ],
    );
  }

  void doneAction() {
    if (vpnStore.serverList[isSelected].uid ==
        appStore.mSelectedServerModel.uid) {
      finish(context);
    } else {
      appStore.setSelectedServerModel(vpnStore.serverList[isSelected]);
      toasty(
        context,
        "${language.lblServerChangedTo} ${vpnStore.serverList[isSelected].country}, ${language.lblPleaseWaitWhileReconnecting} ",
        gravity: ToastGravity.TOP,
        borderRadius: radius(),
        bgColor: context.cardColor,
        duration: 3.seconds,
        textColor: textPrimaryColorGlobal,
      );
      vpnServicesMethods.updateVpn(server: vpnStore.serverList[isSelected]);
    }

    finish(context);
  }
}
