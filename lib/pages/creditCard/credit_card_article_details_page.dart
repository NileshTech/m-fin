import 'package:finance/common/index.dart';

class CreditCardArticleDetailsPage extends StatefulWidget {
  final Map? articleDetails;
  CreditCardArticleDetailsPage(this.articleDetails);

  @override
  _CreditCardArticleDetailsPageState createState() =>
      _CreditCardArticleDetailsPageState();
}

class _CreditCardArticleDetailsPageState
    extends State<CreditCardArticleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size? screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: screenSize.height,
          child: Column(
            children: [
              Text(widget.articleDetails!['name']),
              Text(widget.articleDetails!['articleDate']),
              Text(widget.articleDetails!['bestFor']),
            ],
          ),
        ),
      ),
    );
  }
}
