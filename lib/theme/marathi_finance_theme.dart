import 'package:finance/common/index.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MFTheme extends StatefulWidget {
  final Widget? appBar;
  final Widget? body;
  final bool? isBackButtonOnAppBar;
  final user;
  MFTheme(
      {this.appBar, this.body, this.isBackButtonOnAppBar = false, this.user});

  @override
  _MFThemeState createState() => _MFThemeState();
}

class _MFThemeState extends State<MFTheme> {
  AdRequest? adRequest;

  BannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
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
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        listener: bannerAdListener,
        request: adRequest!);

    bannerAd!.load();
  }

  @override
  void dispose() {
    bannerAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size? screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          height: screenSize.height * 0.05,
                          width: screenSize.height * 0.05,
                          child: CircleAvatar(
                            radius: 48, // Image radius
                            backgroundImage:
                                NetworkImage(widget.user!.photoURL, scale: 1.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.user!.displayName,
                                  style: TextStyle(
                                      color: brown,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                widget.user!.email,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Flexible(
                      child: Marquee(
                    text: 'comming ssom..',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 50.0,
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  )),
                  Flexible(
                      child: Marquee(
                    text: 'comming soon..',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 100.0,
                    pauseAfterRound: Duration(milliseconds: 500),
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  )),
                ],
              ),
            ),
            Expanded(flex: 12, child: VerticalTabLayout()),
            Expanded(
              child: AdWidget(ad: bannerAd!),
            )
          ],
        ),
      ),
    );
  }
}
