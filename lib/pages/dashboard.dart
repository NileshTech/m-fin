import 'package:finance/common/index.dart';
import 'package:finance/env/user_app_env.dart';
import 'package:finance/games/sudoku/sudoku.dart';
import 'package:finance/helpers/mfin_utils.dart';
import 'package:finance/pages/common_widgets/reawards_icon.dart';

class Dashboard extends StatefulWidget {
  final user;
  Dashboard({Key? key, this.user});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  AnimationController? _resizableController;

  bool isLoading = true;
  @override
  void initState() {
    checkAdFreeInterest();
    _resizableController = new AnimationController(
      vsync: this,
      duration: new Duration(
        milliseconds: 1000,
      ),
    );
    _resizableController!.addStatusListener((animationStatus) {
      switch (animationStatus) {
        case AnimationStatus.completed:
          _resizableController!.reverse();
          break;
        case AnimationStatus.dismissed:
          _resizableController!.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }
    });
    _resizableController!.forward();
    super.initState();
  }

  void checkAdFreeInterest() async {
    await MFinUtils.checkForAdFreeInterest(widget.user.uid);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size? screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        // ======= user details at top of home screen =====
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(35),
                bottomLeft: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                    color: white,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // ======== feature to be launched ======
        isLoading == false
            ? Expanded(
                flex: UserEnvirnment.interestForAdsUpdated == false ? 1 : 2,
                child: UserEnvirnment.interestForAdsUpdated == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  "तुम्ही ad-free app मध्ये इच्छुक आहात का?\n are you willing to go for ad-free app?",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              onPressed: () async {
                                await MFinUtils.updateAdFreeInterest(
                                    widget.user.uid, 'नाही');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MFTheme(user: widget.user)),
                                );
                              },
                              child: Text(
                                'नाही',
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side:
                                      BorderSide(color: Colors.red, width: 2)),
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              onPressed: () async {
                                await MFinUtils.updateAdFreeInterest(
                                    widget.user.uid, 'हो');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MFTheme(user: widget.user)),
                                );
                              },
                              child: Text('हो'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                      color: Colors.yellow, width: 2)),
                            ),
                          )),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedBuilder(
                          animation: _resizableController!.view,
                          builder: (context, child) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Sudoku()),
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(
                                        color: Colors.blue,
                                        width: _resizableController!.value * 2),
                                  ),
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //     width: 1,
                                  //     color: white,
                                  //   ),
                                  // ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.asset(
                                              "assets/icon/icon_square.png"),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Sudoku"),
                                            Text(
                                                "तुमच्यासाठी एक आधुनिक आणि पुनर्विचार\n सुडोकू डिझाइन सादर करत आहे."),
                                          ],
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.05,
                                        ),
                                        Column(
                                          children: [
                                            Icon(Icons.play_arrow),
                                            Text("Play")
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
              )
            : SizedBox(),
        Expanded(flex: 12, child: VerticalTabLayout()),
      ],
    );
  }
}
