import 'package:flutter/material.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/create_client_screen.dart';
import 'package:klitchyapp/screens/home_screen.dart';
import 'package:klitchyapp/screens/pending_screen.dart';
import 'package:klitchyapp/screens/restaurant_preview_screen.dart';
import 'package:klitchyapp/screens/resto_screen.dart';
import 'package:provider/provider.dart';

class ScannedTableScreen extends StatefulWidget {
  const ScannedTableScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ScannedTableScreen> createState() => _ScannedTableScreenState();
}

class _ScannedTableScreenState extends State<ScannedTableScreen> {
  TextEditingController telcontroller = TextEditingController();

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
  void dispose() {
    super.dispose();
    telcontroller.dispose();
  }

  bool _validtel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "images/logo.png",
                  width: 166,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: 210,
                height: 210,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      resto.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(0, 108, 129, 0.3),
                      ),
                      child: Icon(
                        Icons.restaurant,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(tableResto.name,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(owner.name,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Owner",
                        style: TextStyle(
                            color: Color(0xFF717579),
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
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
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Theme.of(context).primaryColor,
                  ),

                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  errorText: _validtel ? 'Téléphone vide !' : null,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    telcontroller.text.isEmpty
                        ? _validtel = true
                        : _validtel = false;
                  });
                  if (telcontroller.text.isNotEmpty) {
                    // Provider.of<DataProvider>(context, listen: false)
                    //     .setClient(namecontroller.text, telcontroller.text);

                    final isClient =
                        await Provider.of<DataProvider>(context, listen: false)
                            .getClientByPhone(telcontroller.text);
                    if (isClient) {
                      final isOwner =
                          Provider.of<DataProvider>(context, listen: false)
                              .isOwner();
                      if (isOwner) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RestaurantPreviewScreen(
                              resto: resto,
                            ),
                          ),
                        );
                      } else {
                        final client =
                            Provider.of<DataProvider>(context, listen: false)
                                .client;
                        print("yet3da ?");
                        print(tableResto.listclients.contains(client.id));
                        if (tableResto.listclients.contains(client.id)) {
                          print("direct yet3da");

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RestaurantPreviewScreen(
                                resto: resto,
                              ),
                            ),
                          );
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PendingScreen(),
                            ),
                          );
                        }
                      }
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => CreateClientScreen(
                            phone: telcontroller.text,
                            isOwner: false,
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(68),
                    color: Color(0xFF006C81),
                  ),
                  child: Center(
                    child: Text(
                      "REQUEST",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
