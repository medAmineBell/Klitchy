import 'package:flutter/material.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/home_screen.dart';
import 'package:klitchyapp/screens/into_screen.dart';
import 'package:provider/provider.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  TextEditingController telcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  late Resto resto;
  late TableResto tableResto;
  late Client owner;

  @override
  void initState() {
    super.initState();
    resto = Provider.of<DataProvider>(context, listen: false).resto;
    tableResto = Provider.of<DataProvider>(context, listen: false).tableResto;
    owner = Provider.of<DataProvider>(context, listen: false).owner;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(resto.name),
          const SizedBox(
            height: 30,
          ),
          const Text("Pending confirmation"),
          const SizedBox(
            height: 30,
          ),
          Text("Table: " + tableResto.name),
          const SizedBox(
            height: 30,
          ),
          Text("Owner: " + owner.name),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 50,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
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
              child: const Padding(
                padding: EdgeInsets.all(10),
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
                    builder: (BuildContext context) => const IntroScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Padding(
                padding: EdgeInsets.all(10),
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
