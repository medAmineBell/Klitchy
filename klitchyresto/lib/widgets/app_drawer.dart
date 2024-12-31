import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:klitchyresto/screens/category/categories_screen.dart';
import 'package:klitchyresto/screens/events/events_list_screen.dart';
import 'package:klitchyresto/screens/foods/foods_screen.dart';
import 'package:klitchyresto/screens/orders/orders_history_screen.dart';
import 'package:klitchyresto/screens/orders/orders_screen.dart';
import 'package:klitchyresto/screens/pos/pos_screen.dart';
import 'package:klitchyresto/screens/tables/tables_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resto = Provider.of<DataProvider>(context, listen: false).resto;
    return Drawer(
      width: 300,
      backgroundColor: AppConstants.mcgpalette0,
      child: Column(
        children: [
          Container(
            width: 300,
            height: 100,
            color: AppConstants.mcgpalette0,
            child: Center(
              child: Text(
                "Klitchy Admin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => CategoriesScreen(),
                ),
              );
            },
            title: Text(
              "Categories",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: Icon(
              Icons.category_outlined,
              color: Colors.white,
            ),
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
            title: Text(
              "Foods",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: Icon(
              Icons.category_outlined,
              color: Colors.white,
            ),
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
            title: Text(
              "Tables",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: Icon(
              Icons.table_restaurant_outlined,
              color: Colors.white,
            ),
          ),
          Divider(),
          if (resto.canOrder) ...[
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => POSScreen(),
                  ),
                );
              },
              title: Text(
                "POS",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => OrdersScreen(),
                  ),
                );
              },
              title: Text(
                "Orders",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: Icon(
                Icons.list_alt_outlined,
                color: Colors.white,
              ),
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
              title: Text(
                "Orders History",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: Icon(
                Icons.list_alt_outlined,
                color: Colors.white,
              ),
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
              title: Text(
                "Events",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: Icon(
                Icons.list_alt_outlined,
                color: Colors.white,
              ),
            ),
            Divider(),
          ],
        ],
      ),
    );
  }
}
