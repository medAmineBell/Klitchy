import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:klitchyapp/models/food.dart';
import 'package:klitchyapp/models/order.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders = [];
  Map<String, List<Order>> myorders = {};
  List<Food> foods = [];

  @override
  void initState() {
    super.initState();
    foods = Provider.of<DataProvider>(context, listen: false).foods;
    Provider.of<DataProvider>(context, listen: false).getOrders().then(
      (value) {
        setState(() {
          getMyOrders();
        });
      },
    );
  }

  void getMyOrders() {
    myorders = {};
    orders.forEach((order) {
      if (myorders.containsKey(order.orderNum)) {
        // change quantity...
        myorders.update(
          order.orderNum,
          (existingListOrders) {
            existingListOrders.add(order);
            return existingListOrders;
          },
        );
      } else {
        myorders.putIfAbsent(
          order.orderNum,
          () {
            List<Order> orders = [];
            orders.add(order);
            return orders;
          },
        );
      }
    });
    print(myorders.length);
  }

  Widget buildOrder(String num, List<Order> orders) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                ...orders.map((order) {
                  final food = foods.firstWhere(
                    (f) => f.id == order.foodId,
                  );
                  return OrderItem(
                    order: order,
                    food: food,
                  );
                }).toList(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#$num",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    orders.first.status,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> ordersWidget() {
    List<Widget> widgets = [];
    myorders.forEach((key, value) {
      widgets.add(buildOrder(key, value));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    orders = Provider.of<DataProvider>(context).allorders;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
          centerTitle: true,
          foregroundColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
                children: [
                  ...ordersWidget(),
                ],
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
