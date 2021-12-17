// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService
{
  static String get bannerAdUnitId => 'ca-app-pub-2823662566409957/5464897366' ;
  static String get InterstitialAdUnitId => 'ca-app-pub-2823662566409957/8464086483' ;
  static InterstitialAd _interstitialAd;
  static int _numInterstitialLoadAttempts = 0;
  static int maxFailedLoadAttempts = 3;


  static initialize()
  {
    if(MobileAds.instance == null)
    {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAd()
  {
    BannerAd ad = new BannerAd(
        adUnitId: bannerAdUnitId,
        size:  AdSize.largeBanner,
        request: AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) => print('Ad loaded'),
          onAdFailedToLoad: (Ad ad, LoadAdError error )
          {
            ad.dispose();
          },
          onAdOpened:  (Ad ad) => print('Ad opened'),
          onAdClosed: (Ad ad) => print('On Ad Closed'),
          onAdImpression: (Ad ad) => print('Ad impression.'),

        )
    );
    return ad;
  }

  static createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  static showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),

      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },

      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },

    );
    _interstitialAd.show();
    _interstitialAd = null;
  }

}
