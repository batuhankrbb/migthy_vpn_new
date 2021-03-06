import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyvpn/screen/server_list_screen.dart';
import '../component/AdmobComponent.dart';
import '../main.dart';
import '../utils/AdConfigurationConstants.dart';
import '../utils/AdMobUtils.dart';

import 'package:nb_utils/nb_utils.dart';

import '../utils/constant.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    loadInterstitialAd();
  }

  Color? getSelectedColor(LanguageDataModel data) {
    if (getStringAsync(SELECTED_LANGUAGE_CODE) ==
            data.languageCode.validate() &&
        appStore.isDarkMode) {
      return primaryColor.withOpacity(0.2);
    } else if (getStringAsync(SELECTED_LANGUAGE_CODE) ==
            data.languageCode.validate() &&
        !appStore.isDarkMode) {
      return primaryColor.withOpacity(0.1);
    } else {
      return null;
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        language.lblChangeLanguage,
        backWidget: IconButton(
          onPressed: () {
            showInterstitialAd();

            finish(context);
          },
          icon: Icon(Icons.arrow_back_outlined, color: context.iconColor),
        ),
        showBack: true,
        elevation: 0,
        color: context.scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              localeLanguageList.length,
              (index) {
                LanguageDataModel data = localeLanguageList[index];

                return GestureDetector(
                    onTap: () async {
                      await setValue("changeLanguageBefore", true);
                      print(data.languageCode);
                      await setValue(SELECTED_LANGUAGE_CODE, data.languageCode);
                      selectedLanguageDataModel = data;
                      await appStore.setLanguage(data.languageCode!);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: radius(),
                        color: getSelectedColor(data),
                        border: Border.all(color: context.dividerColor),
                      ),
                      width: context.width() / 2 - 24,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(data.name.validate(),
                                  style: boldTextStyle()),
                              8.height,
                              AutoSizeText(data.subTitle.validate(),
                                  style: secondaryTextStyle()),
                            ],
                          ).expand(),
                          Image.asset(data.flag.validate(), width: 34),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
