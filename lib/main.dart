import 'dart:io';

import 'package:finance/helpers/http_pdf_override.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'common/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  HttpOverrides.global = MyHttpOverrides();

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
        theme: ThemeData(),
        darkTheme: ThemeData(
          primaryColorDark: Colors.black,
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
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
