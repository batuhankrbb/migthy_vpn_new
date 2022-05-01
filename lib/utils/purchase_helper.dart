//* Monthly [0]
//* 12 Months [1]

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../main.dart';

class PurchaseHelper {
  static var shared = PurchaseHelper();
  var isPremium = false;
  List<Package> packageList = [];

  //*DONE
  Future<void> initPurchase() async {
    try {
      await Purchases.setDebugLogsEnabled(true);
      await Purchases.setup(revenueCatKey);
      await checkIsPremium();
    } catch (e) {}
  }

//* DONE
  Future<void> loadProducts() async {
    try {
      var offerings = await Purchases.getOfferings();

      if (offerings.current != null) {
        packageList = offerings.current!.availablePackages;
        packageList.sort((first, second) =>
            first.product.price.compareTo(second.product.price));
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //* DONE
  Future<void> checkIsPremium() async {
    try {
      var purchaserInfo = await Purchases.getPurchaserInfo();
      isPremium = purchaserInfo.entitlements.all["premium"]?.isActive ?? false;
      globalStore.isPremium = isPremium;
    } catch (e) {}
  }

  //* DONE
  Future<bool> purchase(Package packageToPurchase) async {
    try {
      var info = await Purchases.purchasePackage(packageToPurchase);
      isPremium = info.entitlements.all['premium']?.isActive ?? false;
      globalStore.isPremium = isPremium;
      return isPremium;
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      print(errorCode);
      print(e);
      return false;
    }
  }

  //* DONE
  Future<bool> restorePurchase() async {
    try {
      PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
      isPremium = restoredInfo.entitlements.all['premium']?.isActive ?? false;
      globalStore.isPremium = isPremium;
      return restoredInfo.entitlements.all['premium']?.isActive ?? false;
    } on PlatformException catch (e) {
      print(e);
      isPremium = false;
      globalStore.isPremium = isPremium;
      return false;
    }
  }

  //* May be used later
  void addPurchaseInfoListener() {
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) {
      isPremium = purchaserInfo.entitlements.all["premium"]?.isActive ?? false;
      globalStore.isPremium = isPremium;
    });
  }

  String get12MonthsDiscount() {
    try {
      var month1Product = packageList[0].product;
      var month12Product = packageList[1].product;
      var priceWithoutDiscount = month1Product.price * 12;
      var priceWithDiscount = month12Product.price;
      var x = (priceWithDiscount / priceWithoutDiscount) * 100;
      var discountRate = 100 - x;
      return discountRate.toStringAsFixed(2);
    } catch (e) {
      return "";
    }
  }



  String get12MonthsMonthly() {
    try {
      var month12Product = packageList[1].product;
      var prefix = packageList[1].product.priceString[0];
      return prefix + (month12Product.price / 12).toStringAsFixed(2);
    } catch (e) {
      return "";
    }
  }

    String get12MonthsDiscountForWeek() {
    try {
      var month1Product = packageList[0].product;
      var month12Product = packageList[1].product;
      var priceWithoutDiscount = month1Product.price * 52;
      var priceWithDiscount = month12Product.price;
      var x = (priceWithDiscount / priceWithoutDiscount) * 100;
      var discountRate = 100 - x;
      return discountRate.toStringAsFixed(2);
    } catch (e) {
      return "";
    }
  }

    String get12MonthsMonthlyForWeek() {
    try {
      var month12Product = packageList[1].product;
      var prefix = packageList[1].product.priceString[0];
      return prefix + (month12Product.price / 52).toStringAsFixed(2);
    } catch (e) {
      return "";
    }
  }
}
