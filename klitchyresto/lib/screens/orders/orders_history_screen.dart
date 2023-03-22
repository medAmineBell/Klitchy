import 'package:flutter/material.dart';
import 'package:klitchyresto/models/food.dart';
import 'package:klitchyresto/models/order.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:klitchyresto/widgets/app_drawer.dart';
import 'package:klitchyresto/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersHistoryScreen extends StatefulWidget {
  const OrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
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
    orders = Provider.of<DataProvider>(context).completedOrders;

    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Orders History"),
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
