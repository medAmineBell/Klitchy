import 'package:flutter/material.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/home_screen.dart';
import 'package:klitchyapp/screens/into_screen.dart';
import 'package:provider/provider.dart';

class PendingScreen extends StatefulWidget {
  final TableResto tableResto;
  const PendingScreen({Key? key, required this.tableResto}) : super(key: key);

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  TextEditingController telcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  late Resto resto;

  @override
  void initState() {
    super.initState();
    resto = Provider.of<DataProvider>(context, listen: false).resto;
  }

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
          Text(resto.name),
          SizedBox(
            height: 30,
          ),
          Text("Pending confirmation"),
          SizedBox(
            height: 30,
          ),
          Text("Table: " + widget.tableResto.name),
          SizedBox(
            height: 30,
          ),
          Text("Owner: " + widget.tableResto.owner),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
          ),
          CircularProgressIndicator(),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(),
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
                  "Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )),
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
