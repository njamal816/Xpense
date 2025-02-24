import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-2035149885634118/2167806830", // Test Ad ID
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => setState(() => _isAdLoaded = true),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print("Failed to load banner ad: $error");
          ad.dispose();
        },
      ),
      request: AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Container(
      alignment: Alignment.center,
      child: AdWidget(ad: _bannerAd),
      width: _bannerAd.size.width.toDouble(),
      height: _bannerAd.size.height.toDouble(),
    )
        : SizedBox();
  }
}