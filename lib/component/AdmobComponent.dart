import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mightyvpn/main.dart';
import '../utils/AdMobUtils.dart';
import 'dart:io' show Platform;

import '../utils/constant.dart';

RewardedAd? rewardedAd;
InterstitialAd? myInterstitial;

Future<void> loadInterstitialAd() async {
  if (globalStore.isPremium) {
    return;
  }
  InterstitialAd.load(
    adUnitId:
        kReleaseMode ? getInterstitialAdUnitId() : InterstitialAd.testAdUnitId,
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        myInterstitial = ad;
      },
      onAdFailedToLoad: (LoadAdError error) {
        myInterstitial = null;
      },
    ),
  );
}

Future<void> showInterstitialAd() async {
    if (globalStore.isPremium) {
    return;
  }
  if (myInterstitial == null) {
    print('Warning: attempt to show interstitial before loaded.');
    return;
  }
  myInterstitial!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (InterstitialAd ad) =>
        print('ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
      loadInterstitialAd();
    },
    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
    },
  );
  myInterstitial?.show();
  myInterstitial = null;
}

Future<void> loadRewardedAd() async {
    if (globalStore.isPremium) {
    return;
  }
  await RewardedAd.load(
      adUnitId: kReleaseMode ? getRewardedAdId() : RewardedAd.testAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          rewardedAd = null;
        },
      ));
}

Future<void> showRewardedAd({required VoidCallback onWinReward}) async {
    if (globalStore.isPremium) {
    return;
  }
  if (rewardedAd == null) {
    print('Warning: attempt to show rewarded before loaded.');
    return;
  }
  rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (RewardedAd ad) =>
        print('$ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (RewardedAd ad) {
      ad.dispose();
      loadRewardedAd();
    },
    onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
      ad.dispose();
    },
    onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
  );

  rewardedAd?.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
    onWinReward();
  });
  rewardedAd = null;
}

AppOpenAd? openAd;

Future<void> loadOpenAd() async {
    if (globalStore.isPremium) {
    return;
  }
  await AppOpenAd.load(
      adUnitId: AD_MOB_OPEN_AD_ID,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
        openAd = ad;
        openAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            openAd = null;
          },
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            openAd = null;
          },
        );
        openAd!.show();
      }, onAdFailedToLoad: (LoadAdError error) {
        openAd = null;
      }),
      orientation: AppOpenAd.orientationPortrait);
}

