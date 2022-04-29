import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../utils/AdMobUtils.dart';

RewardedAd? rewardedAd;
InterstitialAd? myInterstitial;

BannerAd buildBannerAd() {
  return BannerAd(
    adUnitId: kReleaseMode ? getBannerAdUnitId() : BannerAd.testAdUnitId,
    size: AdSize.banner,
    listener: BannerAdListener(onAdLoaded: (ad) {
      //
    }),
    request: AdRequest(),
  );
}

Future<void> loadInterstitialAd() async {
  InterstitialAd.load(
    adUnitId: kReleaseMode ? getInterstitialAdUnitId() : InterstitialAd.testAdUnitId,
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
  if (myInterstitial == null) {
    print('Warning: attempt to show interstitial before loaded.');
    return;
  }
  myInterstitial!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
      loadInterstitialAd();
    },
    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      ad.dispose();
    },
  );
  myInterstitial!.show();
  myInterstitial = null;
}

