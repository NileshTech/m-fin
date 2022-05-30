import 'package:finance/common/index.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../ads/ads.dart';

class CibilArticleDetailsPage extends StatefulWidget {
  final Map? articleDetails;
  CibilArticleDetailsPage(this.articleDetails);

  @override
  _CibilArticleDetailsPageState createState() =>
      _CibilArticleDetailsPageState();
}

class _CibilArticleDetailsPageState extends State<CibilArticleDetailsPage> {
  bool showSidebar = false;

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
                  child: Container(
                    child: Column(
                      children: [
                        MFinAds(),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            widget.articleDetails!['article'],
                          ),
                        ),
                        MFinAds(),
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
            Expanded(child: MFinAds())
          ],
        ),
      ),
    );
  }
}
