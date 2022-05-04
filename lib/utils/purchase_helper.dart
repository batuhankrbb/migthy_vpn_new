//* Monthly [0]
//* 12 Months [1]

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mightyvpn/services/notification_service.dart';
import 'package:mightyvpn/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../main.dart';

var testPackageMonthly = Package(
  "monthly_package_offer",
  PackageType.annual,
  Product("monthly_product", "description", "Monthly Product", 12.99, "\$12.99",
      "usd"),
  "monthly_offering",
);

var testPackageAnnualNormal = Package(
  "yearly_package_offer",
  PackageType.annual,
  Product("yearly_product", "description", "Yearly Product", 38.99, "\$38.99",
      "usd"),
  "yearly_offering",
);

var testPackageAnnualHigh = Package(
  "yearly_package_high_offer",
  PackageType.annual,
  Product("yearly_product_high", "description", "Yearly Product High", 58.99,
      "\$58.99", "usd"),
  "yearly_offering_high",
);

//* [0] -> Monthly
//* [1] -> Annual Normal
//* [2] -> Annual High

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
    } catch (e) {
      globalStore.isLoading = false;
    }
  }

//* DONE
  Future<void> loadProducts() async {
    try {
      var offerings = await Purchases.getOfferings();

      if (offerings.current != null) {
        var offeringList = offerings.all.values.toList();
        offeringList.forEach((element) {
          packageList.addAll(element.availablePackages);
        });
        
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
      setValue("isPremium", isPremium);
      if (isPremium) {
        CloudMessageHelper.shared.unsubscribe();
      } else {
        CloudMessageHelper.shared.subscribe();
      }
    } catch (e) {
      isPremium = getBoolAsync("isPremium", defaultValue: false);
      globalStore.isPremium = isPremium;
    }
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

  String get12MonthsMonthly() {
    var month12Product = packageList[1].product;
    var prefix = packageList[1].product.priceString[0];
    return prefix + (month12Product.price / 12).toStringAsFixed(2);
  }

  String get12MonthsMonthlyForWeek() {
    var month12Product = packageList[1].product;
    var prefix = packageList[1].product.priceString[0];
    return prefix + (month12Product.price / 52).toStringAsFixed(2);
  }
}
