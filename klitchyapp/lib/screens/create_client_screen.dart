import 'package:flutter/material.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/home_screen.dart';
import 'package:klitchyapp/screens/into_screen.dart';
import 'package:klitchyapp/screens/pending_screen.dart';
import 'package:provider/provider.dart';

class CreateClientScreen extends StatefulWidget {
  final String phone;
  final bool isOwner;
  const CreateClientScreen({
    Key? key,
    required this.phone,
    required this.isOwner,
  }) : super(key: key);

  @override
  State<CreateClientScreen> createState() => _CreateClientScreenState();
}

class _CreateClientScreenState extends State<CreateClientScreen> {
  TextEditingController telcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  late Resto resto;
  late TableResto tableResto;

  @override
  void initState() {
    super.initState();
    resto = Provider.of<DataProvider>(context, listen: false).resto;
    tableResto = Provider.of<DataProvider>(context, listen: false).tableResto;
    telcontroller.text = widget.phone;
  }

  @override
  void dispose() {
    super.dispose();
    telcontroller.dispose();
    namecontroller.dispose();
  }

  bool _validtel = false;
  bool _validname = false;

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
          Text("Write your name for we can remember you next time"),
          SizedBox(
            height: 30,
          ),
          Text("Table: " + tableResto.name),
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
                  await Provider.of<DataProvider>(context, listen: false)
                      .addClient(telcontroller.text, namecontroller.text);
                  if (widget.isOwner) {
                    await Provider.of<DataProvider>(context, listen: false)
                        .setOwner();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                    );
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PendingScreen(),
                      ),
                    );
                  }
                }
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
          // ElevatedButton(
          //     onPressed: () async {
          //       Navigator.of(context).pushReplacement(
          //         MaterialPageRoute(
          //           builder: (BuildContext context) => IntroScreen(),
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
          //         "Quit",
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
