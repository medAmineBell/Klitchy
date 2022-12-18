import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/widgets/event_item.dart';
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
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Découvrez nos meilleures offres spéciales",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  EventItem(
                    productUrl: "",
                    productName: "Sea Food ",
                    productDesc: "Ostelflow Lounge",
                    productPrice: "87",
                  ),
                  EventItem(
                    productUrl: "",
                    productName: "Sea Food ",
                    productDesc: "Ostelflow Lounge",
                    productPrice: "87",
                  ),
                  EventItem(
                    productUrl: "",
                    productName: "Sea Food ",
                    productDesc: "Ostelflow Lounge",
                    productPrice: "87",
                  ),
                  EventItem(
                    productUrl: "",
                    productName: "Sea Food ",
                    productDesc: "Ostelflow Lounge",
                    productPrice: "87",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
