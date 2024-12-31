import 'package:flutter/material.dart';
import 'package:klitchyresto/models/tableResto.dart';
import 'package:klitchyresto/screens/tables/view_table_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TableItem extends StatelessWidget {
  final TableResto table;

  TableItem({Key? key, required this.table}) : super(key: key);
  final doc = pw.Document();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ViewTableScreen(
                  table: table,
                ),
              ),
            );
          },
          leading: Icon(
            Icons.table_restaurant_outlined,
            size: 30,
            color: Colors.black,
          ),
          title: Text(table.name),
          subtitle: Text(table.qrcode),
          trailing: IconButton(
            icon: Icon(
              Icons.qr_code_2,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () async {
              doc.addPage(pw.Page(
                  pageFormat: PdfPageFormat.a4,
                  build: (pw.Context context) {
                    return pw.Center(
                        child: pw.Column(
                      children: [
                        pw.Text(table.name, style: pw.TextStyle(fontSize: 20)),
                        pw.SizedBox(height: 20),
                        pw.SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: pw.BarcodeWidget(
                            color: PdfColor.fromHex("#000000"),
                            barcode: pw.Barcode.qrCode(),
                            data: table.qrcode,
                          ),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Text("Klitchy", style: pw.TextStyle(fontSize: 20)),
                      ],
                    ));
                  }));

              await Printing.sharePdf(
                  bytes: await doc.save(), filename: '${table.name}.pdf');
            },
          ),
        ),
      ),
    );
  }
}
