import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MFinAds extends StatefulWidget {
  MFinAds({Key? key}) : super(key: key);

  @override
  State<MFinAds> createState() => _MFinAdsState();
}

class _MFinAdsState extends State<MFinAds> {
  AdRequest? adRequest;

  BannerAd? bannerAd;

  @override
  void initState() {
    adRequest = const AdRequest(
      keywords: ["Mobile", "Finance", "Cibil Score", "Credit Cards"],
      nonPersonalizedAds: false,
    );

    BannerAdListener bannerAdListener = BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd!.load();
          print('=== ad in loaded ===');
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          print('=== ad load falied: $err ===');
        },
        onAdClicked: (ad) => print('=== ad is clicked ==='),
        onAdClosed: (ad) => print('=== ad is closed ==='));

    bannerAd = BannerAd(
        size: AdSize.banner,
        // ========= Production ======
        adUnitId: 'ca-app-pub-2953987482308747/5314125953',
        // ========= Testing ======
        //  adUnitId:'ca-app-pub-3940256099942544/6300978111',
        listener: bannerAdListener,
        request: adRequest!);

    bannerAd!.load();
    super.initState();
  }

  @override
  void dispose() {
    bannerAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size? screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.1,
      child: AdWidget(ad: bannerAd!),
    );
  }
}

class MFinRewardedAds {
  static RewardedAd? rewardedAd;

  static Future<void> loadRewardedAd() async {
    await RewardedAd.load(
        adUnitId: "ca-app-pub-2953987482308747/1491925278",
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          rewardedAd = null;
        }));
  }
}
