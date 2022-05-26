import 'package:finance/common/index.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CibilArticleDetailsPage extends StatefulWidget {
  final Map? articleDetails;
  CibilArticleDetailsPage(this.articleDetails);

  @override
  _CibilArticleDetailsPageState createState() =>
      _CibilArticleDetailsPageState();
}

class _CibilArticleDetailsPageState extends State<CibilArticleDetailsPage> {
  bool showSidebar = false;
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
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  widget.articleDetails!['title'],
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: Material(
                  // elevation: 20,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            widget.articleDetails!['article'],
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.articleDetails!['article-date'],
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: AdWidget(ad: bannerAd!))
          ],
        ),
      ),
    );
  }
}
