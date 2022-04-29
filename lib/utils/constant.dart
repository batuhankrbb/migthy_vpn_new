import 'package:flutter/material.dart';

import '../model/server_model.dart';
import '../screen/onboard/widgets/onboard_page_widget.dart';
import 'images.dart';
import 'package:nb_utils/nb_utils.dart';

const appName = 'Anonymous VPN';

const iconSize = 26.0;
const textSize = 16.0;

const mRevenueCatKey = 'goog_HkYGxKQJURUnLdBZHGuFKuHUXKz';

class AppConstant {
  static const appName = 'IP Changer';
  static const appDescription =
      'Surf the web anonymously and securely with IP Changer app template. If you are a web surfer, IP Changer is for you. For an uninterrupted, high speed browsing and zero logs, this app template allows online activity to be private. Facilitate lightning fast speed, IP Changer is compatible with PC, Mac, iOS, Android, Routers, and more. Protect your privacy, keeping you safe from third party tracking, unblock geographically restricted sites, one click to connect VPN, encrypt the internet traffic, and more. Unblock and access streaming videos, movies, series, matches, shows, and more without buffering. The super fast IP Changer app is ideal for streaming games. You can also change your IP address to wherever you want. With a set of resourceful features.';

  static const defaultLanguage = 'en';
  static ServerModel defaultServer = ServerModel(
      country: 'Japan',
      ovpn: 'japan',
      ovpnUserName: 'vpn',
      ovpnUserPassword: 'vpn',
      flagUrl: LanguageImages.icJapanese);
}

class AppThemeMode {
  static const themeModeSystem = 0;
  static const themeModeLight = 1;
  static const themeModeDark = 2;
}

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

class Urls {
  static const appDescription = "";
  static String copyRight =
      'copyright @${DateTime.now().year} ${AppConstant.appName}';
  static const packageName = "com.mighty.vpn";
  static const privacyPolicy = "https://www.google.com/";
  static const termsAndConditionURL = 'https://www.google.com/';
  static const supportURL = 'https://mighty.desky.support/';
  static const appShareURL = '$playStoreBaseURL$packageName';
  static const mailto = 'hi@appstun.com';
  static const purchaseUrl =
      'https://codecanyon.net/user/meetmighty/portfolio?direction=desc&order_by=sortable_at&view=grid';
  static const documentation =
      'https://meetmighty.com/codecanyon/document/mightyvpn/';
}

const AD_MOB_OPEN_AD_ID = "ca-app-pub-8037703403650159/1710755075";
const AD_MOB_BANNER_ID = "ca-app-pub-8037703403650159/3070447519";
const AD_MOB_INTERSTITIAL_ID = "ca-app-pub-8037703403650159/6016175059";

const primaryColor = Color(0xFF005AFF);
const appButtonColor = Color(0xFFe3effe);
const onboardBackgroundColor = Color(0xFFe3effe);
const onboardTextColor = Colors.black;
const defaultPrimaryColor = primaryColor;
const secondaryColor = Color(0xFF000000);
const scaffoldColorDark = Color(0xFF090909);
const appButtonColorDark = Color(0xFF282828);

const vpnLogo = 'assets/images/vpn_logo.png';
const onBoardScreenImg = 'assets/images/onBoardScreenImage2.png';

class LanguageImages {
  static const icUs = "assets/flag/ic_us.png";
  static const icGermany = "assets/flag/ic_germany.png";
  static const icBrazil = "assets/flag/ic_brazil.png";
  static const icSpain = "assets/flag/ic_spain.png";
  static const icAr = "assets/flag/ic_ar.png";
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
        name: 'Portuguese',
        subTitle: 'Português',
        languageCode: 'pt',
        fullLanguageCode: 'pt-PT',
        flag: LanguageImages.icBrazil),
    LanguageDataModel(
        id: 6,
        name: 'Spanish',
        subTitle: 'Español',
        languageCode: 'es',
        fullLanguageCode: 'es-ES',
        flag: LanguageImages.icSpain),
  ];
}

final List<Widget> introWidgetsList = [
  const OnboardPageWidget(
    image: LanguageImages.icGermany,
    title: "Learn faster, than ever!",
    description:
        "Thanks to 123 Spanish’s visually supported flashcards, you’ll learn and memorise faster. ",
  ),
  const OnboardPageWidget(
    image: LanguageImages.icJapanese,
    title: "Regularly Updated Decks",
    description:
        "123 Spanish's content team studies regularly and creates and shares the most successful decks with you.",
  ),
  const OnboardPageWidget(
    image: LanguageImages.icKorean,
    title: "Study More Efficiently",
    description:
        "Maybe you only need some basic words for your Spain holiday. So, why do you start from the beginning? 123 Spanish gives you exactly what you need.",
  ),
];
