import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/order.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/models/userItem.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/widgets/split_bill.dart';
import 'package:klitchyapp/widgets/table_order_item.dart';
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
  List<Order> orders = [];
  Map<String, UserItem> listTableUsers = {};

  double total = 0;

  @override
  void initState() {
    super.initState();
    resto = Provider.of<DataProvider>(context, listen: false).resto;
    tableResto = Provider.of<DataProvider>(context, listen: false).tableResto;
    owner = Provider.of<DataProvider>(context, listen: false).owner;
    client = Provider.of<DataProvider>(context, listen: false).client;
    Provider.of<DataProvider>(context, listen: false).getOrders();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //Provider.of<DataProvider>(context, listen: false).getListTableUsers();
    // });
  }

  @override
  Widget build(BuildContext context) {
    orders = Provider.of<DataProvider>(context).orders;
    total = 0;
    //listTableUsers = Provider.of<DataProvider>(context).listTableUsers;
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
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromRGBO(0, 108, 129, 0.3),
                                    ),
                                    child: Icon(
                                      Icons.restaurant,
                                      size: 30,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(tableResto.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)),
                                      Text(owner.name,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Text("OWNER",
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                            ...orders.map((e) {
                              final food = Provider.of<DataProvider>(context,
                                      listen: false)
                                  .foods
                                  .firstWhere(
                                      (element) => element.id == e.foodId);
                              total += food.price * e.qty;
                              return TableOrderItem(
                                qty: e.qty.toString(),
                                name: food.name,
                                total: food.price.toStringAsFixed(2),
                              );
                            }).toList(),
                            Divider(
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Row(
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
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Image.asset("images/barcode.png"),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: Provider.of<DataProvider>(context, listen: false)
                        .getListTableUsers(orders),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        listTableUsers = snapshot.data as Map<String, UserItem>;

                        return buildListUsers(
                            snapshot.data as Map<String, UserItem>);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  if (owner.id == client.id)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: InkWell(
                            onTap: () async {
                              await showDialog(
                                context: this.context,
                                builder: (BuildContext context) => SplitBill(
                                  listTableUsers: listTableUsers,
                                  ownerId: owner.id,
                                ),
                              );
                            },
                            child: Container(
                              width: 160,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "SPLIT THE BILL",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: InkWell(
                            onTap: () async {
                              final result = await showDialogAlert(
                                context: context,
                                title: 'Pay All',
                                message: 'Do you want to Pay all?',
                                actionButtonTitle: 'Yes',
                                cancelButtonTitle: 'Cancel',
                              );
                              if (result!.index == 0) {
                                for (var order in orders) {
                                  await Provider.of<DataProvider>(context,
                                          listen: false)
                                      .payOrder(order.id);
                                }
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
                                  "PAY ALL",
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
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildListUsers(Map<String, UserItem> listTableUsers) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...listTableUsers.keys.map((user) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                leading: Icon(
                  Icons.person_outline,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
                subtitle: Text(
                  client.id == user ? "Me" : "Guest",
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  listTableUsers[user]!.name,
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                trailing: Text(
                  listTableUsers[user]!.total.toStringAsFixed(2),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
