import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:provider/provider.dart';

class RestoScreen extends StatefulWidget {
  const RestoScreen({Key? key}) : super(key: key);

  @override
  _RestoScreenState createState() => _RestoScreenState();
}

class _RestoScreenState extends State<RestoScreen> {
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
                  Text("Categories"),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Foods"),
                ],
              ),
            ),
          ),
        ));
  }
}
