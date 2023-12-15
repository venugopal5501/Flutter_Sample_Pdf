import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'dart:html' as html;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Sample PDF')),
        body: Center(child: GenerateButton()),
      ),
    );
  }
}

class GenerateButton extends StatelessWidget {
  Future<String> generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World from SXCCE!!!!!!',
                style: pw.TextStyle(fontSize: 40)),
          );
        },
      ),
    );
    final pdfBytes = await pdf.save();
    final base64Pdf = base64.encode(pdfBytes);
    return base64Pdf;
  }

  void downloadPdf(String base64Pdf) {
    final anchorElement = html.AnchorElement(
      href: 'data:application/pdf;base64,$base64Pdf',
    )
      ..setAttribute('download', 'sample.pdf')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Download Sample PDF'),
      onPressed: () async {
        final base64Pdf = await generatePdf();
        downloadPdf(base64Pdf);
      },
    );
  }
}
