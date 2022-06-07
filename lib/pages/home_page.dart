import 'package:finance/common/index.dart';
import 'package:finance/helpers/mfin_utils.dart';

class HomePage extends StatefulWidget {
  final Widget? adWidget;
  HomePage({Key? key, this.adWidget});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return FutureBuilder<bool>(
                future: MFinUtils.userUserInfoInDB(snapshot.data),
                builder: (context, snapshot1) {
                  if (!snapshot1.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return MFTheme(
                    user: snapshot.data,
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong..!"),
            );
          } else {
            return SignUpPage();
          }
        });
  }
}
