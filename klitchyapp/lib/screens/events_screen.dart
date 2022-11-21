import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
                  Text("Events"),
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
