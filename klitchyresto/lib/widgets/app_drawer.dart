import 'package:flutter/material.dart';
import 'package:klitchyresto/screens/category/categories_screen.dart';
import 'package:klitchyresto/screens/foods/foods_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      child: Column(
        children: [
          Container(
            width: 300,
            height: 100,
            color: Colors.blue,
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
        ],
      ),
    );
  }
}
