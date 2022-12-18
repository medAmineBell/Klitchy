import 'dart:io';
import 'package:flutter/material.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/home_screen.dart';
import 'package:klitchyapp/screens/notable_screen.dart';
import 'package:klitchyapp/screens/openTable_screen.dart';
import 'package:klitchyapp/screens/scanned_table_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class BarecodeScanScreen extends StatefulWidget {
  @override
  _BarecodeScanScreenState createState() => _BarecodeScanScreenState();
}

class _BarecodeScanScreenState extends State<BarecodeScanScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 7, child: _buildQrView(context)),
          Expanded(
            child: Container(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Container(),
                  Container(),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextButton(
                        onPressed: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: FutureBuilder(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            return Icon(
                              snapshot.data != null
                                  ? Icons.flash_on
                                  : Icons.flash_off,
                              size: 50,
                              color: Colors.white,
                            );
                          },
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextButton(
                      onPressed: () async {
                        final tableResto = await Provider.of<DataProvider>(
                                context,
                                listen: false)
                            .getTableByQrCode("1234");

                        if (tableResto == null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  NoTableScreen(),
                            ),
                          );
                        } else {
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) => HomeScreen(),
                          //   ),
                          // );

                          if (tableResto.owner.isEmpty) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    OpenTableScreen(),
                              ),
                            );
                          } else {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ScannedTableScreen(),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        "Annuler",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        controller.pauseCamera();
        // if (scanData.code.contains("https://kmandi-app.tn/menu_digital/")) {
        //   _launchURL(scanData.code);
        // } else {
        //   Provider.of<CompanyProvider>(context, listen: false)
        //       .fetchAndSetCompanyFromAPI(scanData.code)
        //       .then((value) {
        //     Navigator.of(context).pushNamed(WelcomePage.routeName);
        //   });
        // }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
