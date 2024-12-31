import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/userItem.dart';

class RequestJoinTable extends StatefulWidget {
  final Client client;

  const RequestJoinTable({
    super.key,
    required this.client,
  });
  @override
  _RequestJoinTableState createState() => _RequestJoinTableState();
}

class _RequestJoinTableState extends State<RequestJoinTable> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: TextStyle(
          color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          child: Icon(
            Icons.close,
            size: 27,
            color: Colors.red,
          ),
          onTap: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Text("Request to join your table"),
            SizedBox(
              height: 30,
            ),
            Text(widget.client.name + " is Requesting to join"),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        "Reject",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFF006C81),
                    ),
                    child: Center(
                      child: Text(
                        "Accept",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
