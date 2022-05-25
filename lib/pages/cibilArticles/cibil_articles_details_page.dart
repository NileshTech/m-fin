import 'package:finance/common/index.dart';

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
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showSidebar = true;
      });
    });
    Size? screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: screenSize.height * 0.9,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 35, left: 10, right: 80.0),
                  child: Material(
                    // elevation: 20,
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.01),
                          /*    widget.articleDetails!['images'] != ""
                              ? Container(
                                  height: screenSize.height * 0.2,
                                  child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/place_holder.jpg',
                                      image: widget.articleDetails!['images']),
                                )
                              : Container(), */
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Material(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(),
                    height: screenSize.height * 0.05,
                    width: screenSize.width,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                  ),
                ),
              ),
              showSidebar == true
                  ? Positioned(
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100),
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0)),
                              color: Colors.black,
                              border: Border(
                                top: BorderSide(width: 16.0, color: white),
                                bottom: BorderSide(width: 16.0, color: white),
                              ),
                            ),
                            height: screenSize.height * 0.7,
                            width: screenSize.width * 0.2,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              /* Positioned(
                right: 0,
                bottom: 10,
                child: Material(
                  elevation: 20,
                  borderRadius: new BorderRadius.circular(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)),
                      color: Colors.black,
                    ),
                    height: screenSize.height * 0.1,
                    width: screenSize.width * 0.2,
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
