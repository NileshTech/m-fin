import 'package:finance/common/index.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: MaterialButton(
            minWidth: 100,
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            color: Colors.brown,
            hoverColor: Colors.brown[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                Text("Signin/Login with Google",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          )),
    );
  }
}
