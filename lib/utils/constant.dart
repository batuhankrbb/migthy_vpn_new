import 'package:flutter/material.dart';

import '../main.dart';
import '../model/server_model.dart';
import '../screen/onboard/widgets/onboard_page_widget.dart';
import 'package:nb_utils/nb_utils.dart';

//* -------- DON'T FORGET --------
//? App Name'i değiştir android dosyalarından
//? Bundle id değitşir android dosyalarından
//? Projeyi Firebase'e ekleyip Firebase JSON ları değiştir
//? Proje Logosunu değiştir android dosyalarından
//? Proje hard update'i için firebase'in app kısmına bundle id ile yeni document ekle


//* -------- KEYS --------

const revenueCatKey = 'goog_HkYGxKQJURUnLdBZHGuFKuHUXKz';
const mixpanelKey = '1d81f3fb8497319e960929e845d790e2';

//* -------- PRICING --------

const annualPriceHighConstant = 58.99;
const annualPriceConstant = 38.99;
const monthlyPriceConstant = 13.99;

//* -------- CONSTANTS --------

const vpnLogo = 'assets/images/vpn_logo.png';

class AppConstant {
  static const appName = 'GPS Spoofer';
  static const defaultLanguage = 'en';
  static ServerModel defaultServer = ServerModel(
      country: 'Japan',
      ovpn: 'japan',
      ovpnUserName: 'vpn',
      ovpnUserPassword: 'vpn',
      flagUrl: LanguageImages.icJapanese);
}

//* -------- URLS --------

class Urls {
  static const packageName = "com.location.spoofer.gps";
  static const privacyPolicy = "https://www.google.com/";
  static const termsAndConditionURL = 'https://www.google.com/';
  static const appShareURL = '$playStoreBaseURL$packageName';
  static const mailto = 'hi@appstun.com';
}

//* -------- ADMOB --------

const AD_MOB_OPEN_AD_ID = "ca-app-pub-3940256099942544/3419835294";
const AD_MOB_BANNER_ID = "ca-app-pub-8037703403650159/3070447519";
const AD_MOB_INTERSTITIAL_ID = "ca-app-pub-8037703403650159/6016175059";
const AD_MOB_REWARDED_ID = "ca-app-pub-8037703403650159/6016175059";
const AD_MOB_NATIVE_ID_SPEED = "ca-app-pub-3940256099942544/2247696110";
const AD_MOB_NATIVE_ID_SETTINGS = "ca-app-pub-3940256099942544/2247696110";

//* -------- COLORS --------

const primaryColor = Color(0xFF005AFF);
const appButtonColor = Color(0xFFe3effe);
const onboardBackgroundColor = Color(0xFFe3effe);
const onboardTextColor = Colors.black;
const defaultPrimaryColor = primaryColor;
const secondaryColor = Color(0xFF000000);
const scaffoldColorDark = Color(0xFF090909);
const appButtonColorDark = Color(0xFF282828);
const premiumColor = Color(0xFFFFD200);


//* ------------------------------- AŞAĞISI RESKİN EDİLMEYECEK ---------------------------

//* -------- ONBOARD --------

final List<Widget> introWidgetsList = [
  OnboardPageWidget(
    image: "assets/images/globe_lottie.json",
    title: language.onboard1Title,
    description: language.onboard2Description,
    index: 0,
  ),
  OnboardPageWidget(
    image: "assets/images/unlock_lottie.json",
    title: language.onboard2Title,
    description: language.onboard2Description,
    index: 1,
  ),
  OnboardPageWidget(
    image: "assets/images/rocket_lottie.json",
    title: language.onboard3Title,
    description: language.onboard3Description,
    index: 2,
  ),
];

//* -------- LOCALIZATIONS --------

class LanguageImages {
  static const icUs = "assets/flag/ic_us.png";
  static const icGermany = "assets/flag/ic_germany.png";
  static const icBrazil = "assets/flag/ic_brazil.png";
  static const icSpain = "assets/flag/ic_spain.png";
  static const icAr = "assets/flag/ic_ar.png";
  static const icFrance = "assets/flag/ic_france.png";
  static const icChina = "assets/flag/ic_china.png";
  static const icPhilippines = "assets/flag/ic_philippines.png";
  static const icIndonesia = "assets/flag/ic_indonesia.png";
  static const icJapanese = "assets/flag/ic_japanese.png";
  static const icKorean = "assets/flag/ic_korean.png";
  static const icThai = "assets/flag/ic_thai.png";
  static const icVietnamese = "assets/flag/ic_vietnamese.png";
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(
        id: 1,
        name: 'English',
        subTitle: 'English',
        languageCode: 'en',
        fullLanguageCode: 'en-US',
        flag: LanguageImages.icUs),
    LanguageDataModel(
        id: 2,
        name: 'Germany',
        subTitle: 'Deutsch',
        languageCode: 'de',
        fullLanguageCode: 'de-DE',
        flag: LanguageImages.icGermany),
    LanguageDataModel(
        id: 3,
        name: 'Arabic',
        subTitle: 'عربي',
        languageCode: 'ar',
        fullLanguageCode: 'ar-AR',
        flag: LanguageImages.icAr),
    LanguageDataModel(
        id: 4,
        name: 'Korean',
        subTitle: '한국인',
        languageCode: 'ko',
        fullLanguageCode: 'ko-KR',
        flag: LanguageImages.icKorean),
    LanguageDataModel(
        id: 5,
        name: 'Indonesian',
        subTitle: 'Bahasa Indonesia',
        languageCode: 'id',
        fullLanguageCode: 'id-ID',
        flag: LanguageImages.icIndonesia),
    LanguageDataModel(
        id: 6,
        name: 'Spanish',
        subTitle: 'Español',
        languageCode: 'es',
        fullLanguageCode: 'es-ES',
        flag: LanguageImages.icSpain),
    LanguageDataModel(
        id: 7,
        name: 'Chinese',
        subTitle: '中国人',
        languageCode: 'zh',
        fullLanguageCode: 'zh-CN',
        flag: LanguageImages.icChina),
    LanguageDataModel(
        id: 8,
        name: 'French',
        subTitle: 'Français',
        languageCode: 'fr',
        fullLanguageCode: 'fr-FR',
        flag: LanguageImages.icFrance),
    LanguageDataModel(
        id: 9,
        name: 'Portuguese',
        subTitle: 'Português',
        languageCode: 'pt',
        fullLanguageCode: 'pt-PT',
        flag: LanguageImages.icBrazil),
    LanguageDataModel(
        id: 10,
        name: 'Filipino',
        subTitle: 'Filipino',
        languageCode: 'fil',
        fullLanguageCode: 'en-PH',
        flag: LanguageImages.icPhilippines),
  ];
}

class AppThemeMode {
  static const themeModeSystem = 0;
  static const themeModeLight = 1;
  static const themeModeDark = 2;
}

const iconSize = 26.0;
const textSize = 16.0;

class VpnConstants {
  //Native Event Name
  static const String eventStage = 'com.mighty.vpn/vpnStage';
  static const String eventData = 'com.mighty.vpn/vpnData';
  static const String methodChannelName = 'vpn_channel';

  // Native Method Name
  static const String prepareVpn = 'prepareVpn';
  static const String startVpn = 'startVpn';
  static const String updateVpn = 'updateVpn';
  static const String stopVpn = 'stopVpn';
  static const String fromServer = 'fromServer';

  static const String connecting = 'Connecting';
  static const String wait = 'Waiting for server reply';
  static const String auth = 'Authenticating';
  static const String getConfig = 'Getting client configuration';
  static const String assignIp = 'Assigning IP addresses';
  static const String addRoutes = 'Adding routes';
  static const String connected = 'Connected';
  static const String disconnected = 'Disconnect';
  static const String reconnecting = 'Reconnecting';
  static const String exiting = 'Exiting';
  static const String resolve = 'Not running';
  static const String tcpConnect = 'Resolving host names';
  static const String noNetwork = 'Not Connected to network';
  static const String connectRetry = 'Retrying';
  static const String authPending = 'Connecting (TCP)';
  static const String userPause = 'Connection paused';
  static const String notConnected = 'Not connected';
}

class SharedPrefKeys {
  static const selectedServer = 'selectedServer';
  static const vpnConnected = 'vpnConnected';
  static const vpnConnecting = 'vpnConnecting';
  static const vpnDisconnected = 'vpnDisconnected';
  static const vpnWaitConnection = 'vpnWaitConnection';
  static const language = 'language';
  static const isPrepared = 'isPrepared';
}
