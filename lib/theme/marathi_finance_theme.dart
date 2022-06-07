import 'package:finance/common/index.dart';
import 'package:finance/env/user_app_env.dart';
import 'package:finance/helpers/mfin_utils.dart';
import 'package:flutter/material.dart';

import '../ads/ads.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // ======= user details at top of home screen =====
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ======== feature to be launched ======
            isLoading == false
                ? Expanded(
                    flex: 1,
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                                      side: BorderSide(
                                          color: Colors.red, width: 2)),
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
                        : Column(
                            children: [
                              Flexible(
                                  child: Marquee(
                                text: 'coming soon..',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                scrollAxis: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                blankSpace: 20.0,
                                velocity: 100.0,
                                pauseAfterRound: Duration(milliseconds: 500),
                                startPadding: 10.0,
                                accelerationDuration: Duration(seconds: 1),
                                accelerationCurve: Curves.linear,
                                decelerationDuration:
                                    Duration(milliseconds: 500),
                                decelerationCurve: Curves.easeOut,
                              )),
                            ],
                          ),
                  )
                : SizedBox(),
            Expanded(flex: 12, child: VerticalTabLayout()),
            Expanded(
              child: MFinAds(),
            )
          ],
        ),
      ),
    );
  }
}
