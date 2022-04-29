// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appstore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on AppStoreBase, Store {
  Computed<bool>? _$isNetworkAvailableComputed;

  @override
  bool get isNetworkAvailable => (_$isNetworkAvailableComputed ??=
          Computed<bool>(() => super.isNetworkAvailable,
              name: 'AppStoreBase.isNetworkAvailable'))
      .value;

  late final _$mConnectivityResultAtom =
      Atom(name: 'AppStoreBase.mConnectivityResult', context: context);

  @override
  ConnectivityResult get mConnectivityResult {
    _$mConnectivityResultAtom.reportRead();
    return super.mConnectivityResult;
  }

  @override
  set mConnectivityResult(ConnectivityResult value) {
    _$mConnectivityResultAtom.reportWrite(value, super.mConnectivityResult, () {
      super.mConnectivityResult = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'AppStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$selectedLanguageAtom =
      Atom(name: 'AppStoreBase.selectedLanguage', context: context);

  @override
  String get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(String value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  late final _$isDarkModeAtom =
      Atom(name: 'AppStoreBase.isDarkMode', context: context);

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$mSelectedServerModelAtom =
      Atom(name: 'AppStoreBase.mSelectedServerModel', context: context);

  @override
  ServerModel get mSelectedServerModel {
    _$mSelectedServerModelAtom.reportRead();
    return super.mSelectedServerModel;
  }

  @override
  set mSelectedServerModel(ServerModel value) {
    _$mSelectedServerModelAtom.reportWrite(value, super.mSelectedServerModel,
        () {
      super.mSelectedServerModel = value;
    });
  }

  late final _$setConnectivityResultAsyncAction =
      AsyncAction('AppStoreBase.setConnectivityResult', context: context);

  @override
  Future<void> setConnectivityResult(ConnectivityResult aConnectivityResult) {
    return _$setConnectivityResultAsyncAction
        .run(() => super.setConnectivityResult(aConnectivityResult));
  }

  late final _$setDarkModeAsyncAction =
      AsyncAction('AppStoreBase.setDarkMode', context: context);

  @override
  Future<void> setDarkMode(bool aIsDarkMode) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(aIsDarkMode));
  }

  late final _$setLanguageAsyncAction =
      AsyncAction('AppStoreBase.setLanguage', context: context);

  @override
  Future<void> setLanguage(String aCode, {BuildContext? context}) {
    return _$setLanguageAsyncAction
        .run(() => super.setLanguage(aCode, context: context));
  }

  late final _$AppStoreBaseActionController =
      ActionController(name: 'AppStoreBase', context: context);

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedServerModel(ServerModel aSelectedServerModel) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setSelectedServerModel');
    try {
      return super.setSelectedServerModel(aSelectedServerModel);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mConnectivityResult: ${mConnectivityResult},
isLoading: ${isLoading},
selectedLanguage: ${selectedLanguage},
isDarkMode: ${isDarkMode},
mSelectedServerModel: ${mSelectedServerModel},
isNetworkAvailable: ${isNetworkAvailable}
    ''';
  }
}
