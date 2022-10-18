import 'dart:io';
import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sozashop_app/core/core.dart';

class BarcodeRepository {
  var selectedBatch;
  var filePath;

  Future<Uint8List> generateBarcodePdf(
      {required totalBarCode, required batch}) async {
    selectedBatch = batch;

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.GridView(
              crossAxisCount: 5,
              childAspectRatio: 1.1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: generateItems(totalBarCode),
            )
          ];
        },
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      ),
    );
    return pdf.save();
  }

  // barcode item body
  barcodeItem() {
    return pw.Container(
      width: double.maxFinite,
      height: double.maxFinite,
      // margin: const pw.EdgeInsets.symmetric(
      //   vertical: 10,
      //   horizontal: 10,
      // ),
      // padding: const pw.EdgeInsets.symmetric(
      //   vertical: 10,
      //   horizontal: 10,
      // ),
      // color: PdfColors.amber.shade(.2),

      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text(
            selectedBatch!.product.name,
            style: pw.TextStyle(
              fontSize: 11.sp,
            ),
          ),
          pw.SizedBox(height: 2.h),
          pw.Text(
            selectedBatch!.name,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 8.sp,
            ),
          ),
          pw.AspectRatio(
            aspectRatio: 1.8,
            child: pw.Expanded(
              child: pw.BarcodeWidget(
                barcode: Barcode.code128(),
                data: 'Hello world',
                drawText: false,
                margin: pw.EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 20.w,
                ),
                // width: double.infinity * .8,
              ),
            ),
          ),
          pw.Text(
            'Price: ${selectedBatch!.sellingRate}',
            style: pw.TextStyle(
              fontSize: 11.sp,
              color: PdfColors.grey.shade(0.7),
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // generate items for pdf
  generateItems(int count) {
    final items = <pw.Widget>[];
    for (var i = 0; i < count; i++) {
      items.add(barcodeItem());
    }
    return items;
  }

  // save pdf to device
  Future<void> savePdfFile(String filename, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    print('before filePath $filePath');
    filePath = "${output.path}/$filename.pdf";
    print('after filePath $filePath');
    final file = File(filePath);
    await file.writeAsBytes(byteList);
  }

  // open pdf from device
  Future<void> openPdfFile() async {
    await OpenFile.open(filePath);
  }
}
