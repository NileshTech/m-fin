import 'package:finance/ads/ads.dart';
import 'package:flutter/material.dart';

class ComingSoonPage extends StatefulWidget {
  ComingSoonPage({Key? key}) : super(key: key);

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("coming soon..."),
        MFinAds(),
      ],
    );
  }
}
