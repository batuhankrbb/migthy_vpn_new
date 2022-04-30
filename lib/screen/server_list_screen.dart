import 'package:auto_size_text/auto_size_text.dart';
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

List<String> unlockedUIds = [];

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
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
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
                                color: context.cardColor,
                                borderRadius: radius()),
                            leading: cachedImage(
                                data.flagUrl.validate(
                                    value: 'assets/images/vpn_logo.png'),
                                width: 34,
                                height: 34),
                            trailing:
                                buildTrailing(data, context, selected, index),
                            onTap: () {
                              if (globalStore.isPremium ||
                                  !(data.isPremium ?? true) ||
                                  unlockedUIds.contains(data.uid)) {
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
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21.0),
                ),
                width: context.width() * 0.9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "This is a premium server.",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: context.width() * 0.05,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              "Get premium to unlock all servers forever and remove ads or watch ads to unlock once.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: context.width() * 0.03,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.height,
                    //    alertWatchAdClick(index); alertPaywallClick
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(116, 116, 191, 1.0),
                                      Color.fromRGBO(52, 138, 199, 1.0)
                                    ]),
                                  ),
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    "GET PREMIUM",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: context.width() * 0.05,
                                    ),
                                    maxLines: 1,
                                  ),
                                  height: context.height() * 0.08,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 30,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Color.fromRGBO(0, 179, 134, 1.0),
                                  ),
                                  height: context.height() * 0.08,
                                ),
                                Text(
                                  "Watch ad to unlock once.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  void alertWatchAdClick(int index) {
    if (unlockedUIds.length >= 3) {
      //TODO
      print("YOU CAN'T UNLOCK MORE THAN 3");
      return;
    }
    showRewardedAd(onWinReward: (() {
      isSelected = index;
      unlockedUIds.add(vpnStore.serverList[index].uid ?? "");
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
        isSelected == index ||
        unlockedUIds.contains(data.uid)) {
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
