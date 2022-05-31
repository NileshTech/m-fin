import 'package:finance/common/index.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool? showLoadeer;
  @override
  void initState() {
    setState(() {
      showLoadeer = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: showLoadeer == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      child: Image.asset("assets/images/m-fin.png"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    MaterialButton(
                      minWidth: 100,
                      onPressed: () async {
                        setState(() {
                          showLoadeer = true;
                        });
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        await provider.googleLogin();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      color: Colors.brown,
                      hoverColor: Colors.brown[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                      ),
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator(color: white))),
    );
  }
}
