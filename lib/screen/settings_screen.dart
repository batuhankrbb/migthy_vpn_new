import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyvpn/screen/paywall_screen.dart';
import 'package:mightyvpn/screen/server_list_screen.dart';
import 'package:mightyvpn/utils/AdMobUtils.dart';
import '../main.dart';
import 'about_screen.dart';
import 'language_screen.dart';
import 'theme_screen.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo? packageInfo;

  late NativeAd ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    packageInfo = await PackageInfo.fromPlatform().catchError((e) {
      toast(e.toString());
    });
    setState(() {});
    setupNativeAd();
  }

  bool isNativeAdLoaded = false;

  NativeAd? settingsNativeAd;

  void setupNativeAd() {
    settingsNativeAd = NativeAd(
      adUnitId: getSettingsNativeUnitID(),
      factoryId: "listTile",
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isNativeAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
      request: AdRequest(),
    );
    settingsNativeAd?.load();
  }

  @override
  void dispose() {
    super.dispose();
    settingsNativeAd?.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget trailingIcon({bool? isVersion}) {
    return const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        language.lblSetting,
        showBack: false,
        center: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildPremium(),
            16.height,
            SettingItemWidget(
              leading:
                  Icon(FontAwesome.globe, color: context.iconColor, size: 20),
              title: language.selectServerText,
              trailing: Row(
                children: [
                  8.width,
                  const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 14),
                ],
              ),
              onTap: () {
                push(const ServerListScreen(),
                    pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
                    duration: 250.milliseconds);
              },
            ),
            SettingItemWidget(
              leading: Icon(FontAwesome.language,
                  color: context.iconColor, size: 20),
              title: language.lblChangeLanguage,
              trailing: Row(
                children: [
                  8.width,
                  const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 14),
                ],
              ),
              onTap: () {
                push(LanguageScreen(),
                    pageRouteAnimation: PageRouteAnimation.Slide);
              },
            ),
            Observer(
              builder: (_) => SettingItemWidget(
                title: language.lblTheme,
                leading: Icon(
                    !appStore.isDarkMode
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    size: 20),
                onTap: () {
                  push(ThemeScreen(),
                      pageRouteAnimation: PageRouteAnimation.Slide);
                },
                trailing: trailingIcon(),
              ),
            ),
            SettingItemWidget(
              title: language.lblPrivacyLolicy,
              leading: const Icon(Icons.privacy_tip_outlined, size: 20),
              trailing: trailingIcon(),
              onTap: () {
                launch(Urls.privacyPolicy);
              },
            ),
            SettingItemWidget(
              leading: const Icon(Icons.rate_review_outlined, size: 20),
              title: language.lblRateLs,
              onTap: () async {
                await rateSheetViewModel.showRatingSheet(context);
              },
              trailing: trailingIcon(),
            ),
            SettingItemWidget(
              leading: const Icon(LineIcons.file, size: 20),
              title: language.lblTermsAndConditions,
              onTap: () {
                AppCommon.launchUrl(Urls.termsAndConditionURL);
              },
              trailing: trailingIcon(),
            ),
            SnapHelperWidget(
              future: PackageInfo.fromPlatform(),
              onSuccess: (data) {
                return SettingItemWidget(
                  leading: const Icon(Icons.share_outlined, size: 20),
                  title: language.lblShareApp,
                  onTap: () {
                    Share.share(
                      '${language.lblShare} ${AppConstant.appName} app\n\n${AppConstant.appDescription}\n\n$playStoreBaseURL${packageInfo?.packageName}',
                    );
                  },
                );
              },
            ),
            SettingItemWidget(
              title: language.lblAboutUs,
              leading: const Icon(Icons.perm_device_info, size: 20),
              onTap: () {
                AboutScreen().launch(context);
              },
              trailing: trailingIcon(),
            ),
            isNativeAdLoaded && !globalStore.isPremium
                ? Container(
                    alignment: Alignment.center,
                    child: AdWidget(ad: settingsNativeAd!),
                    width: context.width() * 0.9,
                    height: context.height() * 0.23,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildPremium() {
    if (globalStore.isPremium) {
      return SizedBox();
    }
    return Column(
      children: [
        20.height,
        PremiumButton(
          popFirst: false,
        ),
      ],
    );
  }
}

class PremiumButton extends StatelessWidget {
  const PremiumButton({Key? key, required this.popFirst}) : super(key: key);

  final bool popFirst;
  @override
  Widget build(BuildContext context) {
    if (globalStore.isPremium) {
      return SizedBox();
    }
    return Container(
      width: context.width() * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
          onTap: () {
            if (popFirst) {
              Navigator.pop(context);
            }
            push(const PaywallScreen(),
                pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
                duration: 150.milliseconds);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(116, 116, 191, 1.0).withOpacity(0.5),
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
                SizedBox(width: 30),
                Image.asset(
                  "assets/images/king.png",
                  width: 50,
                  height: 50,
                ),
                Spacer(),
                Container(
                  width: context.width() * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        language.getPremiumText,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: context.width() * 0.05,
                        ),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        "Get access to all servers, no ads, 8x faster, all features.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          )),
    );
  }
}
