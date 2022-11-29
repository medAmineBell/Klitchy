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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(),
          Column(
            children: [
              Image.asset("images/illustration.png"),
              SizedBox(
                height: 25,
              ),
              Image.asset(
                "images/logo.png",
                width: 166,
              ),
              //Text("Klitchy App"),
              SizedBox(
                height: 20,
              ),
              Text(
                "Let’s start by locating you",
                style: TextStyle(fontSize: 14, color: Color(0xFF6D6D6D)),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
            child: InkWell(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => BarecodeScanScreen(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(68),
                  color: Color.fromRGBO(0, 108, 129, 0.3),
                ),
                child: Center(
                  child: Text(
                    "SCAN TABLE QR CODE",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //     onPressed: () async {
          //       Navigator.of(context).pushReplacement(
          //         MaterialPageRoute(
          //           builder: (BuildContext context) => BarecodeScanScreen(),
          //         ),
          //       );
          //     },
          //     style: ElevatedButton.styleFrom(
          //         primary: Colors.teal,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20))),
          //     child: Padding(
          //       padding: const EdgeInsets.all(10),
          //       child: Text(
          //         "Scan Table QR",
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     )),
        ],
      ),
    ));
  }
}
