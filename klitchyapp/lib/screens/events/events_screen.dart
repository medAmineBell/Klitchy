import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klitchyapp/models/event.dart';
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
    Provider.of<DataProvider>(context, listen: false).getEvents();
  }

  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    events = Provider.of<DataProvider>(context).events;
    return WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
          return Future.value(false);
        },
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Découvrez nos meilleures offres spéciales",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  //height: 400,
                  child: ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return EventItem(
                        event: events[index],
                      );
                    },
                  ),
                ),

                // EventItem(
                //   productUrl: "",
                //   productName: "Sea Food ",
                //   productDesc: "Ostelflow Lounge",
                //   productPrice: "87",
                // ),
              ],
            ),
          ),
        ));
  }
}
