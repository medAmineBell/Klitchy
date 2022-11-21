import 'package:flutter/material.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/create_client_screen.dart';
import 'package:klitchyapp/screens/home_screen.dart';
import 'package:klitchyapp/screens/pending_screen.dart';
import 'package:provider/provider.dart';

class OpenTableScreen extends StatefulWidget {
  const OpenTableScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OpenTableScreen> createState() => _OpenTableScreenState();
}

class _OpenTableScreenState extends State<OpenTableScreen> {
  TextEditingController telcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  late Resto resto;
  late TableResto tableResto;

  @override
  void initState() {
    super.initState();
    resto = Provider.of<DataProvider>(context, listen: false).resto;
    tableResto = Provider.of<DataProvider>(context, listen: false).tableResto;
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
            Text("Table: " + tableResto.name),
            SizedBox(
              height: 30,
            ),
            Text("You will be the Owner of this table"),
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
                  });
                  if (telcontroller.text.isNotEmpty) {
                    final isClient =
                        await Provider.of<DataProvider>(context, listen: false)
                            .getClientByPhone(telcontroller.text);
                    if (isClient) {
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
                          builder: (BuildContext context) => CreateClientScreen(
                            phone: telcontroller.text,
                            isOwner: true,
                          ),
                        ),
                      );
                    }

                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         PendingScreen(tableResto: tableResto),
                    //   ),
                    // );
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Open Table",
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
