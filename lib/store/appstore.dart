import 'dart:convert';

import 'package:flutter/material.dart';
import '../language/app_localizations.dart';
import '../language/base_language.dart';
import '../main.dart';
import '../model/server_model.dart';

import '../utils/constant.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'appstore.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  ConnectivityResult mConnectivityResult = ConnectivityResult.none;

  @observable
  bool isLoading = false;

  @observable
  String selectedLanguage = "";

  @observable
  bool isDarkMode = false;

  @observable
  ServerModel mSelectedServerModel = AppConstant.defaultServer;

  @action
  Future<void> setConnectivityResult(
      ConnectivityResult aConnectivityResult) async {
    mConnectivityResult = aConnectivityResult;
  }

  @computed
  bool get isNetworkAvailable => mConnectivityResult != ConnectivityResult.none;

  @action
  void setLoading(bool val) {
    isLoading = val;
  }

  @action
  void setSelectedServerModel(ServerModel aSelectedServerModel) {
    mSelectedServerModel = aSelectedServerModel;
    if (globalStore.isPremium){
      setValue(SharedPrefKeys.selectedServer, jsonEncode(aSelectedServerModel));
    }
    log('Server Changed to ${aSelectedServerModel.country}');
  }

  @action
  Future<void> setDarkMode(bool aIsDarkMode) async {
    isDarkMode = aIsDarkMode;

    if (isDarkMode) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = viewLineColor;
      appBarBackgroundColorGlobal = scaffoldDarkColor;

      defaultLoaderBgColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = Colors.white;
      shadowColorGlobal = Colors.white12;

      setStatusBarColor(scaffoldDarkColor);
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;

      appBarBackgroundColorGlobal = Colors.white;

      defaultLoaderBgColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = primaryColor;
      shadowColorGlobal = Colors.black12;

      setStatusBarColor(Colors.white);
    }
  }

  @action
  Future<void> setLanguage(String aCode, {BuildContext? context}) async {
    selectedLanguageDataModel =
        getSelectedLanguageModel(defaultLanguage: AppConstant.defaultLanguage);
    selectedLanguage =
        getSelectedLanguageModel(defaultLanguage: AppConstant.defaultLanguage)!
            .languageCode!;
    log("Selected language $selectedLanguage");
    if (context != null) language = BaseLanguage.of(context)!;
    language = await const AppLocalizations().load(Locale(selectedLanguage));
  }
}
