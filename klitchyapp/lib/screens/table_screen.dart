import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:provider/provider.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  void initState() {
    super.initState();
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
                  Text("Table"),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
