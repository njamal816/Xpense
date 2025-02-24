import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  static AppOpenAd? _appOpenAd;
  static bool _isAdAvailable = false;

  static void loadAd() {
    AppOpenAd.load(
      adUnitId: 'ca-app-pub-2035149885634118/6175604106', // Test Ad Unit ID
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isAdAvailable = true;
        },
        onAdFailedToLoad: (error) {
          print('App Open Ad failed to load: $error');
          _isAdAvailable = false;
        },
      ),
    );
  }

  static void showAdIfAvailable() {
    if (_isAdAvailable && _appOpenAd != null) {
      _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadAd(); // Preload next ad
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _isAdAvailable = false;
          loadAd();
        },
      );
      _appOpenAd!.show();
      _appOpenAd = null;
      _isAdAvailable = false;
    } else {
      print('Ad not available yet');
    }
  }
}
