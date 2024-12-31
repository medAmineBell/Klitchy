import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/models/event.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:klitchyresto/screens/events/add_event.dart';
import 'package:klitchyresto/widgets/app_drawer.dart';
import 'package:klitchyresto/widgets/event_item.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).getEvents();
  }

  @override
  Widget build(BuildContext context) {
    events = Provider.of<DataProvider>(context).events;

    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: AppConstants.primaryColorDark1,
      appBar: AppBar(
        title: Text("Events"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => AddEventScreen(),
                  ),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventItem(
            event: events[index],
          );
        },
      ),
    );
  }
}
