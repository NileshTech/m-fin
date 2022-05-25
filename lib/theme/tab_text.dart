import 'package:finance/common/index.dart';

class TabText extends StatefulWidget {
  final bool? isTabSelected;

  final String? text;
  final Function? onTabTap;

  TabText({Key? key, this.isTabSelected = false, this.text, this.onTabTap});

  @override
  _TabTextState createState() => _TabTextState();
}

class _TabTextState extends State<TabText> {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -1.58,
      child: InkWell(
        onTap: () {
          // widget.onTabTap;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.text!,
            style: TextStyle(
                color: brown,
                fontWeight: widget.isTabSelected == false
                    ? FontWeight.normal
                    : FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
