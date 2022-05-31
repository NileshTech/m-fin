import 'package:finance/common/index.dart';

import '../../ads/ads.dart';

class CreditCardArticles extends StatefulWidget {
  CreditCardArticles();

  @override
  _CreditCardArticlesState createState() => _CreditCardArticlesState();
}

class _CreditCardArticlesState extends State<CreditCardArticles> {
  Query? _creditCardArticlesRef;
  @override
  void initState() {
    _creditCardArticlesRef =
        FirebaseDatabase.instance.ref().child('inventory/cards/credit-cards');
    super.initState();
  }

  _creditCardArticles({Map? map, double? screenHeight}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreditCardArticleDetailsPage(map)),
          );
        },
        child: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: white,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  map!['name'] + " ...",
                  style: const TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  map['annualFee'].toString(),
                  style: const TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 10),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size? screenSize = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("coming soon..."),
        MFinAds(),
      ],
    );

    // FirebaseAnimatedList(
    //   query: _creditCardArticlesRef!,
    //   itemBuilder: (BuildContext ctx, DataSnapshot snapshot,
    //       Animation<double> animation, int index) {
    //     Map articles = snapshot.value as Map<dynamic, dynamic>;
    //     return _creditCardArticles(
    //         map: articles, screenHeight: screenSize.height * 0.1);
    //   },
    // );
  }
}
