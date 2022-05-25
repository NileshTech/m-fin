import 'package:finance/common/index.dart';

class VerticalTabLayout extends StatefulWidget {
  VerticalTabLayout({Key? key}) : super(key: key);

  @override
  _VerticalTabLayoutState createState() => _VerticalTabLayoutState();
}

class _VerticalTabLayoutState extends State<VerticalTabLayout> {
  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size? screenSize = MediaQuery.of(context).size;

    onTapTapped(int index) {
      setState(() {
        selectedTabIndex = index;
      });
    }

    return Container(
      child: Stack(
        children: [
          // ============== vertical Tab menu ==============
          Positioned(
            left: -20,
            top: 0,
            bottom: 0,
            width: screenSize.width * 0.25,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.rotate(
                    angle: -1.58,
                    child: InkWell(
                      onTap: () {
                        onTapTapped(0);
                      },
                      child: Container(
                        decoration: selectedTabIndex == 0
                            ? BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: white,
                                ),
                              )
                            : BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedDefaultTextStyle(
                            style: TextStyle(
                                color: selectedTabIndex == 0
                                    ? white
                                    : white.withOpacity(0.5),
                                fontWeight: selectedTabIndex == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                            duration: const Duration(milliseconds: 500),
                            child: Text("सिबिल (cibil)"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -1.58,
                    child: InkWell(
                      onTap: () {
                        onTapTapped(1);
                      },
                      child: Container(
                        decoration: selectedTabIndex == 1
                            ? BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: white,
                                ),
                              )
                            : BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedDefaultTextStyle(
                            style: TextStyle(
                                color: selectedTabIndex == 1
                                    ? white
                                    : white.withOpacity(0.5),
                                fontWeight: selectedTabIndex == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                            duration: const Duration(milliseconds: 500),
                            child: Text("क्रेडिट कार्ड"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -1.58,
                    child: InkWell(
                      onTap: () {
                        onTapTapped(2);
                      },
                      child: Container(
                        decoration: selectedTabIndex == 2
                            ? BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: white,
                                ),
                              )
                            : BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedDefaultTextStyle(
                            style: TextStyle(
                                color: selectedTabIndex == 2
                                    ? white
                                    : white.withOpacity(0.5),
                                fontWeight: selectedTabIndex == 2
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                            duration: const Duration(milliseconds: 500),
                            child: Text("Apps"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ============== right side list view of articles ==============
          Padding(
            padding: const EdgeInsets.only(
              left: 60.0,
            ),
            child: selectedTabIndex == 0
                ? CibilArticles()
                : selectedTabIndex == 1
                    ? CreditCardArticles()
                    : CibilArticles(),
          ),
        ],
      ),
    );
  }
}
