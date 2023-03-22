import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:klitchyapp/models/userItem.dart';

class SplitBill extends StatefulWidget {
  final Map<String, UserItem> listTableUsers;
  final String ownerId;

  const SplitBill(
      {super.key, required this.listTableUsers, required this.ownerId});
  @override
  _SplitBillState createState() => _SplitBillState();
}

class _SplitBillState extends State<SplitBill> {
  Map<String, bool> selectedUser = {};
  double total = 0;

  @override
  void initState() {
    super.initState();
    widget.listTableUsers.forEach((key, value) {
      if (widget.ownerId == key) {
        selectedUser.addAll({key: true});
      } else {
        selectedUser.addAll({key: false});
      }
    });
    setTotal();
  }

  void setTotal() {
    total = 0;
    selectedUser.forEach((key, value) {
      if (value) {
        total += widget.listTableUsers[key]!.total;
      }
    });
  }

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
            Navigator.of(context).pop();
          },
        ),
      ),
      content: Container(
        //height: 500,
        child: Column(
          // shrinkWrap: true,
          children: [
            ...widget.listTableUsers.keys.map((user) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CheckboxListTile(
                  value: selectedUser[user],
                  onChanged: (value) {
                    setState(() {
                      if (widget.ownerId != user) {
                        selectedUser[user] = value!;
                      }
                      setTotal();
                    });
                  },
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  //leading: CheckboxListTile(value: value, onChanged: onChanged),
                  title: Text(
                    widget.listTableUsers[user]!.name,
                    style: TextStyle(
                      // fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    widget.listTableUsers[user]!.total.toStringAsFixed(2),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "TOTAL",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "$total DT",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () async {
                  final result = await showDialogAlert(
                    context: context,
                    title: 'Pay Bill',
                    message: 'Do you want to Pay?',
                    actionButtonTitle: 'Yes',
                    cancelButtonTitle: 'Cancel',
                  );
                  if (result!.index == 0) {
                    //                             selectedUser.forEach((key, value) {
                    //   if (value) {
                    //      await Provider.of<DataProvider>(context,
                    //                                       listen: false)
                    //                                   .payOrder(value.);
                    //   }
                    // });

                  }
                },
                child: Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF006C81),
                  ),
                  child: Center(
                    child: Text(
                      "PAY",
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
    );
  }
}
