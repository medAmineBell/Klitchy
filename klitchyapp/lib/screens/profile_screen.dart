import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/into_screen.dart';
import 'package:klitchyapp/screens/orders_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController telcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  bool _validtel = false;
  bool _validname = false;

  late Client client;

  @override
  void initState() {
    super.initState();

    client = Provider.of<DataProvider>(context, listen: false).client;
    namecontroller.text = client.name;
    telcontroller.text = client.phone;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
          return Future.value(false);
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     autofocus: false,
                  //     // style: TextStyle(
                  //     //   color: Colors.white,
                  //     // ),
                  //     controller: namecontroller,
                  //     decoration: InputDecoration(
                  //       labelText: 'Nom et prénom',
                  //       // labelStyle: TextStyle(
                  //       //   color: Colors.white,
                  //       // ),
                  //       // hintStyle: TextStyle(
                  //       //   color: Colors.white,
                  //       // ),
                  //       errorText: _validname ? 'Nom et Prénom vide !' : null,
                  //       contentPadding:
                  //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(32.0)),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: TextFormField(
                  //     keyboardType: TextInputType.phone,
                  //     autofocus: false,
                  //     controller: telcontroller,
                  //     // style: TextStyle(
                  //     //   color: Colors.white,
                  //     // ),
                  //     decoration: InputDecoration(
                  //       labelText: 'Téléphone',
                  //       // labelStyle: TextStyle(
                  //       //   color: Colors.white,
                  //       // ),
                  //       errorText: _validtel ? 'Téléphone vide !' : null,
                  //       contentPadding:
                  //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(32.0)),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  // ElevatedButton(
                  //     onPressed: () async {
                  //       setState(() {
                  //         telcontroller.text.isEmpty
                  //             ? _validtel = true
                  //             : _validtel = false;
                  //         namecontroller.text.isEmpty
                  //             ? _validname = true
                  //             : _validname = false;
                  //       });
                  //       if (telcontroller.text.isNotEmpty &&
                  //           namecontroller.text.isNotEmpty) {}
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //         primary: Colors.teal,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(20))),
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(10),
                  //       child: Text(
                  //         "Save",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     )),

                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.teal,
                    child: ClipOval(
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  buildProfile(),
                  buildSettings(),
                  buildLogOut(),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildProfile() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(top: 20, right: 16, left: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(
                  Icons.person,
                ),
                // title: Text(
                //   "Full name",
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.black,
                //   ),
                // ),
                title: Text(
                  client.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.phone),
                // title: Text(
                //   "Phone",
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.black,
                //   ),
                // ),
                title: Text(
                  client.phone,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettings() {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 16, left: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        padding: EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => OrdersScreen()));
              },
              child: ListTile(
                leading: Icon(Icons.list_alt_outlined),
                title: Text(
                  "Orders",
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => PaymentsScreen()));
              },
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogOut() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => IntroScreen()));
      },
      child: Padding(
        padding: EdgeInsets.only(top: 20, right: 16, left: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.all(15),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
