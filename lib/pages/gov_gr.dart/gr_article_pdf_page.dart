import 'package:finance/ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GRArticlePDFPage extends StatefulWidget {
  final Map? articleDetails;

  GRArticlePDFPage(this.articleDetails);

  @override
  State<GRArticlePDFPage> createState() => _GRArticlePDFPageState();
}

class _GRArticlePDFPageState extends State<GRArticlePDFPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(child: Image.asset("assets/images/mh_logo.png")),
                Expanded(
                    flex: 10,
                    child: Text(widget.articleDetails!['articleDate'] +
                        " - रोजी प्रकाशित")),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: SfPdfViewer.network(widget.articleDetails!['link'],
                    scrollDirection: PdfScrollDirection.vertical),
              ),
              MFinAds()
            ],
          )),
    );
  }
}
