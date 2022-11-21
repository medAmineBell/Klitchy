import 'package:flutter/material.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/into_screen.dart';
import 'package:provider/provider.dart';

class NoTableScreen extends StatefulWidget {
  const NoTableScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NoTableScreen> createState() => _NoTableScreenState();
}

class _NoTableScreenState extends State<NoTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Table not found ( Wrong QR code )"),
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.close,
            size: 100,
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => IntroScreen(),
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
                  "Quit",
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
