import 'package:flutter/material.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:klitchyresto/screens/category/categories_screen.dart';
import 'package:klitchyresto/screens/events/events_list_screen.dart';
import 'package:klitchyresto/screens/foods/foods_screen.dart';
import 'package:klitchyresto/screens/orders/orders_history_screen.dart';
import 'package:klitchyresto/screens/orders/orders_screen.dart';
import 'package:klitchyresto/screens/tables/tables_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resto = Provider.of<DataProvider>(context, listen: false).resto;
    return Drawer(
      width: 300,
      child: Column(
        children: [
          Container(
            width: 300,
            height: 100,
            color: Color.fromRGBO(0, 108, 129, 1),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => CategoriesScreen(),
                ),
              );
            },
            title: Text("Categories"),
            leading: Icon(Icons.category_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => FoodsScreen(),
                ),
              );
            },
            title: Text("Foods"),
            leading: Icon(Icons.category_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => TablesScreen(),
                ),
              );
            },
            title: Text("Tables"),
            leading: Icon(Icons.table_restaurant_outlined),
          ),
          Divider(),
          if (resto.canOrder) ...[
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => OrdersScreen(),
                  ),
                );
              },
              title: Text("Orders"),
              leading: Icon(Icons.list_alt_outlined),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => OrdersHistoryScreen(),
                  ),
                );
              },
              title: Text("Orders History"),
              leading: Icon(Icons.list_alt_outlined),
            ),
            Divider(),
          ],
          if (resto.haveEvent) ...[
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => EventsScreen(),
                  ),
                );
              },
              title: Text("Events"),
              leading: Icon(Icons.list_alt_outlined),
            ),
            Divider(),
          ],
        ],
      ),
    );
  }
}
