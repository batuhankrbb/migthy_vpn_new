// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GlobalStore on _GlobalStoreBase, Store {
  late final _$isPremiumAtom =
      Atom(name: '_GlobalStoreBase.isPremium', context: context);

  @override
  bool get isPremium {
    _$isPremiumAtom.reportRead();
    return super.isPremium;
  }

  @override
  set isPremium(bool value) {
    _$isPremiumAtom.reportWrite(value, super.isPremium, () {
      super.isPremium = value;
    });
  }

  late final _$hasPaywallAlertShowedAtom =
      Atom(name: '_GlobalStoreBase.hasPaywallAlertShowed', context: context);

  @override
  bool get hasPaywallAlertShowed {
    _$hasPaywallAlertShowedAtom.reportRead();
    return super.hasPaywallAlertShowed;
  }

  @override
  set hasPaywallAlertShowed(bool value) {
    _$hasPaywallAlertShowedAtom.reportWrite(value, super.hasPaywallAlertShowed,
        () {
      super.hasPaywallAlertShowed = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_GlobalStoreBase.isLoading', context: context);

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

  @override
  String toString() {
    return '''
isPremium: ${isPremium},
hasPaywallAlertShowed: ${hasPaywallAlertShowed},
isLoading: ${isLoading}
    ''';
  }
}
