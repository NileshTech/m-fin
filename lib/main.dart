import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'common/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  runApp(const MyApp());
}

const int maxAttempts = 3;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'm-fin',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: const MyHomePage(title: 'm-fin'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BannerAd staticAd;
  bool staticAdLoaded = false;

  late BannerAd inlineAd;
  bool inLineAdLoaded = false;

  static const AdRequest request = AdRequest(
      // keywords: ['', ''],
      // contentUrl: '',
      // nonPersonalizedAds: false,
      );
  void loadStaticBannerAd() {
    staticAd = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          staticAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, err) {
        ad.dispose();
        print('ad failed to load ${err.message}');
      }),
    );
    staticAd.load();
  }

  void loadInlineBannerAd() {
    inlineAd = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          inLineAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, err) {
        ad.dispose();
        print('ad failed to load ${err.message}');
      }),
    );
    inlineAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
