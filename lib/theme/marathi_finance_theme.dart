import 'package:finance/common/index.dart';
import 'package:finance/games/games_hub.dart/game_hubs.dart';
import 'package:finance/helpers/mfin_utils.dart';
import 'package:finance/pages/coming_soon_page.dart';

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
  bool isLoading = true;

  @override
  void initState() {
    checkAdFreeInterest();
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

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: widget.body != null
              ? widget.body
              : Center(child: Text('No data flound .. ')),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
              height: screenSize.width * 0.15,
              width: screenSize.width * 0.15,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                color: white,
              )),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(35),
              topLeft: Radius.circular(35),
              // bottomRight: Radius.circular(50),
              // bottomLeft: Radius.circular(50),
            ),
            child: Container(
              height: screenSize.width * 0.2,
              child: BottomAppBar(
                notchMargin: 10,
                shape: CircularNotchedRectangle(),
                color: Colors.black87,
                elevation: 20,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.home),
                          onPressed: () {
                            User? user = FirebaseAuth.instance.currentUser;

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MFTheme(
                                  body: Dashboard(user: user),
                                ),
                              ),
                            );
                          },
                        ),
                        Text("Home")
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.note_add_rounded),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MFTheme(body: ComingSoonPage())),
                            );
                          },
                        ),
                        Text("GR")
                      ],
                    ),
                    SizedBox(
                      height: screenSize.width * 0.1,
                      width: screenSize.width * 0.1,
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.games_rounded),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MFTheme(body: GamesHub())),
                            );
                          },
                        ),
                        Text("Games")
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.account_circle),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MFTheme(body: ComingSoonPage())),
                            );
                          },
                        ),
                        Text("Profile")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
