import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static final AdHelper _instance = AdHelper._internal();
  InterstitialAd? _interstitialAd;
  bool isAdLoaded = true; // Adicione esta linha

  factory AdHelper() {
    return _instance;
  }

  AdHelper._internal();

  // IDs de unidade de anúncio de teste fornecidos pelo Google
  static const String bannerAdUnitId = 'ca-app-pub-6625580398265467/1218136997';
  static const String interstitialAdUnitId =
      'ca-app-pub-6625580398265467/2550318392';

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
          isAdLoaded = true; // Atualize esta linha
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (kDebugMode) {
            print('InterstitialAd failed to load: $error');
          }
          isAdLoaded = false; // Atualize esta linha
          _interstitialAd = null;
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (isAdLoaded) {
      _interstitialAd?.show();
    } else {
      if (kDebugMode) {
        print('Ad not loaded yet');
      }
    }
  }
}
