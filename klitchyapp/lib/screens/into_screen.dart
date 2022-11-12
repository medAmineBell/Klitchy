import 'package:flutter/material.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/barecode_scan_screen.dart';
import 'package:klitchyapp/screens/resto_screen.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Klitchy App"),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => BarecodeScanScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Scan Table QR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
    ));
  }
}
