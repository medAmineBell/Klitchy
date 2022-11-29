import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:provider/provider.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  late Resto resto;
  late TableResto tableResto;
  late Client owner;
  late Client client;

  @override
  void initState() {
    super.initState();
    resto = Provider.of<DataProvider>(context, listen: false).resto;
    tableResto = Provider.of<DataProvider>(context, listen: false).tableResto;
    owner = Provider.of<DataProvider>(context, listen: false).owner;
    client = Provider.of<DataProvider>(context, listen: false).client;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
          return Future.value(false);
        },
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
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
                  Text("Owner: " + owner.name),
                  SizedBox(
                    height: 30,
                  ),
                  buildListUsers(),
                  SizedBox(
                    height: 30,
                  ),
                  if (owner.id == client.id)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {},
                            style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Pay Separate",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        ElevatedButton(
                            onPressed: () async {},
                            style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Pay All",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildListUsers() {
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
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.person),
                subtitle: Text(
                  "17 DT",
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  owner.name,
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.arrow_drop_down),
              ),
            ),
            Divider(),
            if (owner.id != client.id)
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.person),
                  subtitle: Text(
                    "17 DT",
                    style: TextStyle(
                      // fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    client.name,
                    style: TextStyle(
                      // fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_drop_down),
                ),
              ),
            if (owner.id != client.id) Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.person),
                subtitle: Text(
                  "13 DT",
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "Mehdi",
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.arrow_drop_down),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.person),
                subtitle: Text(
                  "21 DT",
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "Ali",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.arrow_drop_down),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
