import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyvpn/extra/rate/viewmodel/rate_sheet_viewmodel.dart';
import 'package:mightyvpn/services/notification_service.dart';
import 'package:mightyvpn/store/global_store.dart';
import 'package:mightyvpn/utils/purchase_helper.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'app_theme.dart';
import 'component/AdmobComponent.dart';
import 'language/base_language.dart';
import 'screen/splash_screen.dart';
import 'services/server_services.dart';
import 'services/vpn_services.dart';
import 'store/appstore.dart';
import 'store/vpnstore.dart';
import 'utils/common.dart';
import 'utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import 'language/app_localizations.dart';

AppStore appStore = AppStore();
VpnStore vpnStore = VpnStore();
GlobalStore globalStore = GlobalStore();
RateSheetViewModel rateSheetViewModel = RateSheetViewModel();

ServerService serverService = ServerService();

const MethodChannel platform = MethodChannel(VpnConstants.methodChannelName);
const EventChannel vpnData = EventChannel(VpnConstants.eventData);
const EventChannel vpnStage = EventChannel(VpnConstants.eventStage);

FirebaseFirestore fireStore = FirebaseFirestore.instance;

VpnServicesMethods vpnServicesMethods = VpnServicesMethods();
StreamSubscription? stageStream;
StreamSubscription? dataStream;
Mixpanel? mixpanel;

late BaseLanguage language;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  defaultRadius = 20.0;
  await initialize(aLocaleLanguageList: languageList());

  forceEnableDebug = true;

  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  await PurchaseHelper.shared.initPurchase();
  PurchaseHelper.shared.loadProducts();
  mixpanel = await Mixpanel.init(mixpanelKey, optOutTrackingDefault: false);
  await loadOpenAd();
  vpnStore.setIsPrepared(getBoolAsync(SharedPrefKeys.isPrepared));
  vpnStore.setVPNStatus();
  globalStore.checkVersion();
  CloudMessageHelper.shared.init();
  if (!isWeb) {
    int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
    if (themeModeIndex == AppThemeMode.themeModeLight) {
      appStore.setDarkMode(false);
    } else if (themeModeIndex == AppThemeMode.themeModeDark) {
      appStore.setDarkMode(true);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    init();
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) {
      if (state == AppState.foreground) {
        loadOpenAd();
      }
    });
  }

  void init() async {
    WidgetsBinding.instance!.addObserver(this);

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      appStore.setConnectivityResult(event);
    });

    afterBuildCreated(() async {
      setOrientationPortrait();
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(
      AppLifecycleState appLifecycleState) async {
    super.didChangeAppLifecycleState(appLifecycleState);
    if (appLifecycleState == AppLifecycleState.detached ||
        appLifecycleState == AppLifecycleState.paused ||
        appLifecycleState == AppLifecycleState.inactive) {
      _connectivitySubscription.cancel();
      if (stageStream != null) {
        stageStream?.cancel();
      }
      dataStream?.cancel();
    }

    if (appLifecycleState == AppLifecycleState.resumed) {
      _connectivitySubscription.resume();
      if (stageStream != null) {
        stageStream?.resume();
      }
      dataStream?.resume();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Observer(
      builder: (_) => ScreenUtilInit(
        designSize: const Size(414, 896),
        child: MaterialApp(
          title: AppConstant.appName,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          navigatorKey: navigatorKey,
          supportedLocales: LanguageDataModel.languageLocales(),
          localizationsDelegates: const [
            AppLocalizations(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate, // Here !
          ],
          localeResolutionCallback: (locale, supportedLocales) => locale,
          locale: Locale(appStore.selectedLanguage
              .validate(value: AppConstant.defaultLanguage)),
        ),
      ),
    );
  }
}
