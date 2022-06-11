import 'package:finance/ads/ads.dart';
import 'package:finance/common/index.dart';
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
        child: MFTheme(
            body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(35),
                    bottomLeft: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.articleDetails!['article'],
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: SfPdfViewer.network(widget.articleDetails!['link'],
                  scrollDirection: PdfScrollDirection.vertical),
            ),
            MFinAds()
          ],
        )));
  }
}
