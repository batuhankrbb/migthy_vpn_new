import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage? of(BuildContext context) =>
      Localizations.of<BaseLanguage>(context, BaseLanguage);

  String get lblYouAreConnectedTo;

  String get lblGettingIP;

  String get lblConnect;

  String get lblVersion;

  String get lblVPNConnect;

  String get lblInternetSpeed;

  String get lblSetting;

  String get lblVpnStarted;

  String get lblDisconnect;

  String get lblWouldYouLikeToCancelTheCurrentVPNConnection;

  String get lblYourVPNConnectionHasBeenDisconnected;

  String get lblCurrentServer;

  String get lblInternetSpeedTest;

  String get lblDownload;

  String get lblStartDownload;

  String get lblUpload;

  String get lblStartUploading;

  String get lblServerList;

  String get lblSameServerSelected;

  String get lblServerChangedTo;

  String get lblPleaseWaitWhileReconnecting;

  String get lblChangeLanguage;

  String get lblTheme;

  String get lblPrivacyLolicy;

  String get lblRateLs;

  String get lblTermsAndConditions;

  String get lblShareApp;

  String get lblShare;

  String get lblAboutUs;

  String get lblLight;

  String get lblDark;

  String get lblSystemDefault;

  String get lblSelectYourTheme;

  String get lblSettings;

  String get lblPurchase;

  String get lblDocument;

  String get lblConnecting;

  String get lblWait;

  String get lblAuth;

  String get lblGetConfig;

  String get lblAssignIp;

  String get lblAddRoutes;

  String get lblConnected;

  String get lblDisconnected;

  String get lblReconnecting;

  String get lblExiting;

  String get lblResolve;

  String get lblTcpConnect;

  String get lblNoNetwork;

  String get lblConnectRetry;

  String get lblAuthPending;

  String get lblUserPause;

  String get lblNotConnected;

  String get lblStartTest;

  String get lblDownloadTestFailed;

  String get lblStartTestAgain;

  String get lblUploadTestFailed;

  String get onboard1Title;
  String get onboard1Description;
  String get onboard2Title;
  String get onboard2Description;
  String get onboard3Title;
  String get onboard3Description;
  String get bestServerText;
  String get moreThan3ErrorText;
  String get getPremiumText;

  String get selectServerText;

  String get themePremiumText;
  String get watchAdUnlockOnceText;

  String get unlockForeverText;

  String get thisIsPremiumServerText;
  String get getPremiumUnlockLongText;
  String get buyAndContinueText;
  String get perYearText;

  String get saleText;

  String get onlyAvailableTodayText;

  String get recurringText;
  String get billedMonthlyOrWeeklyText;
  String get monthOrWeekText;
  String get yearText;
  String get paywallBandwithText;
  String get paywallFastServersText;
  String get paywallCountriesText;
  String get paywallSubTitleText;
  String get paywallTitleText;
  String get premiumSmallText;
  String get restorePurchase;
  String get uploadingSpeed;
  String get downloadingSpeed;
  String get vpnPermissionGranted;
  String get vpnPermissionDenied;
  String get sureText;
  String get noThanks;
  String get tellUsProblemNew;
  String get thatIsSad;
  String get youAreAmazing;
  String get letUsKnowWhat;
  String get doYouLikeUs;
  String get paywallNoAds;
  String get mindRatingUs;
}
