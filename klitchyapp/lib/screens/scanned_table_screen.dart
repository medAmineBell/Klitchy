import 'package:flutter/material.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/home_screen.dart';
import 'package:klitchyapp/screens/pending_screen.dart';
import 'package:klitchyapp/screens/resto_screen.dart';
import 'package:provider/provider.dart';

class ScannedTableScreen extends StatefulWidget {
  final TableResto tableResto;
  const ScannedTableScreen({Key? key, required this.tableResto})
      : super(key: key);

  @override
  State<ScannedTableScreen> createState() => _ScannedTableScreenState();
}

class _ScannedTableScreenState extends State<ScannedTableScreen> {
  TextEditingController telcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  late Resto resto;

  @override
  void initState() {
    super.initState();
    resto = Provider.of<DataProvider>(context, listen: false).resto;
  }

  bool _validtel = false;
  bool _validname = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
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
            Text("Table: " + widget.tableResto.name),
            SizedBox(
              height: 30,
            ),
            Text("Owner: " + widget.tableResto.owner),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                autofocus: false,
                // style: TextStyle(
                //   color: Colors.white,
                // ),
                controller: namecontroller,
                decoration: InputDecoration(
                  labelText: 'Nom et prénom',
                  // labelStyle: TextStyle(
                  //   color: Colors.white,
                  // ),
                  // hintStyle: TextStyle(
                  //   color: Colors.white,
                  // ),
                  errorText: _validname ? 'Nom et Prénom vide !' : null,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                autofocus: false,
                controller: telcontroller,
                // style: TextStyle(
                //   color: Colors.white,
                // ),
                decoration: InputDecoration(
                  labelText: 'Téléphone',
                  // labelStyle: TextStyle(
                  //   color: Colors.white,
                  // ),
                  errorText: _validtel ? 'Téléphone vide !' : null,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    telcontroller.text.isEmpty
                        ? _validtel = true
                        : _validtel = false;
                    namecontroller.text.isEmpty
                        ? _validname = true
                        : _validname = false;
                  });
                  if (telcontroller.text.isNotEmpty &&
                      namecontroller.text.isNotEmpty) {
                    Provider.of<DataProvider>(context, listen: false)
                        .setClient(namecontroller.text, telcontroller.text);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PendingScreen(tableResto: widget.tableResto),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Request",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
