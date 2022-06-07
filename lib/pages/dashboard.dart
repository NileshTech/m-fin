import 'package:finance/common/index.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return CibilArticles();
  }
}
