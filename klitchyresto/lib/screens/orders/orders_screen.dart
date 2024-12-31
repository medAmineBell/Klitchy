import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/models/food.dart';
import 'package:klitchyresto/models/order.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:klitchyresto/widgets/app_drawer.dart';
import 'package:klitchyresto/widgets/order_item.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders = [];
  Map<String, List<Order>> myorders = {};
  List<Food> foods = [];
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    foods = Provider.of<DataProvider>(context, listen: false).foods;
    socket = Provider.of<DataProvider>(context, listen: false).socket;
    Provider.of<DataProvider>(context, listen: false).getOrders().then(
      (value) {
        setState(() {
          getMyOrders(orders);
        });
      },
    );
    // socket.on('orderTable', (data) {
    //   final restoId =
    //       Provider.of<DataProvider>(context, listen: false).resto.id;
    //   final socketRestoId = data["restoId"];
    //   print(restoId);
    //   print(socketRestoId);

    //   if (restoId.toString() == socketRestoId.toString()) {
    //     print("inside socket");
    //     Provider.of<DataProvider>(context, listen: false).getOrders().then(
    //       (value) {
    //         setState(() {
    //           getMyOrders();
    //         });
    //       },
    //     );
    //   }
    // });
  }

  void getMyOrders(List<Order> orders) {
    myorders = {};
    for (var order in orders) {
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
    }
  }

  Widget buildOrder(String num, List<Order> orders) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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

  List<Widget> ordersWidget(List<Order> orders) {
    List<Widget> widgets = [];
    getMyOrders(orders);
    myorders.forEach((key, value) {
      widgets.add(buildOrder(key, value));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    orders = Provider.of<DataProvider>(context).orders;

    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        backgroundColor: AppConstants.primaryColorDark1,
        appBar: AppBar(
          title: Text("Orders"),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
                children: [
                  ...ordersWidget(orders),
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
