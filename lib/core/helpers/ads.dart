import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static final AdHelper _instance = AdHelper._internal();
  InterstitialAd? _interstitialAd;

  factory AdHelper() {
    return _instance;
  }

  AdHelper._internal();

  // IDs de unidade de anúncio de teste fornecidos pelo Google
  // Substitua por seus próprios IDs de unidade de anúncio quando for ao vivo
  static const String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  static const String interstitialAdUnitId =
      'ca-app-pub-3940256099942544/1033173712';

  BannerAd? bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          if (kDebugMode) {
            print('BannerAd loaded: ${ad.adUnitId}');
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          if (kDebugMode) {
            print('BannerAd failed to load: $error');
          }
        },
      ),
    );
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          if (kDebugMode) {
            print('InterstitialAd loaded: ${ad.adUnitId}');
          }
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (kDebugMode) {
            print('InterstitialAd failed to load: $error');
          }
          _interstitialAd = null;
        },
      ),
    );
  }

  void showInterstitialAd() {
    _interstitialAd?.show();
  }
}
