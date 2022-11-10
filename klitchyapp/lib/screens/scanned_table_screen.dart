import 'package:flutter/material.dart';

class ScannedTableScreen extends StatefulWidget {
  const ScannedTableScreen({Key? key}) : super(key: key);

  @override
  State<ScannedTableScreen> createState() => _ScannedTableScreenState();
}

class _ScannedTableScreenState extends State<ScannedTableScreen> {
  TextEditingController telcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  bool _validtel = false;
  bool _validname = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        Text("Plan B"),
        SizedBox(
          height: 30,
        ),
        Text("Table: 20"),
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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
                  namecontroller.text.isNotEmpty) {}
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Valider",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ],
    ));
  }
}
