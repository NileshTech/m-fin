import 'package:finance/common/index.dart';
import 'package:finance/pages/gov_gr.dart/gr_article_pdf_page.dart';

import '../../ads/ads.dart';

class GRArticles extends StatefulWidget {
  GRArticles();

  @override
  _GRArticlesState createState() => _GRArticlesState();
}

class _GRArticlesState extends State<GRArticles> {
  Query? _grArticleRef;
  @override
  void initState() {
    _grArticleRef = FirebaseDatabase.instance
        .ref()
        .child('inventory/gr/articles')
        .orderByChild('index');
    super.initState();
  }

  _grArticles({Map? map, double? screenHeight}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GRArticlePDFPage(map)),
          );
        },
        child: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: white,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/mh_logo.png',
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          map!['article'] + " ...",
                          style: const TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_month),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        map['articleDate'].toString(),
                        style: const TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size? screenSize = MediaQuery.of(context).size;

    return FirebaseAnimatedList(
      query: _grArticleRef!,
      itemBuilder: (BuildContext ctx, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        Map articles = snapshot.value as Map<dynamic, dynamic>;

        if (((index + 1) % 3) == 0) {
          return Column(
            children: [
              _grArticles(map: articles, screenHeight: screenSize.height * 0.1),
              Container(
                  height: screenSize.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MFinAds(),
                  ))
            ],
          );
        } else {
          return _grArticles(
              map: articles, screenHeight: screenSize.height * 0.1);
        }
      },
    );
  }
}
