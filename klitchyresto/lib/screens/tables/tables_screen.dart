import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/models/category.dart';
import 'package:klitchyresto/models/food.dart';
import 'package:klitchyresto/models/tableResto.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:klitchyresto/screens/category/add_category_screen.dart';
import 'package:klitchyresto/screens/foods/add_food.dart';
import 'package:klitchyresto/screens/tables/add_table.dart';
import 'package:klitchyresto/widgets/app_drawer.dart';
import 'package:klitchyresto/widgets/category_item.dart';
import 'package:klitchyresto/widgets/food_item.dart';
import 'package:klitchyresto/widgets/table_item.dart';
import 'package:provider/provider.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen({Key? key}) : super(key: key);

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  List<TableResto> tableRestos = [];

  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).getTables();
  }

  @override
  Widget build(BuildContext context) {
    tableRestos = Provider.of<DataProvider>(context).tableRestos;
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: AppConstants.primaryColorDark1,
      appBar: AppBar(
        title: Text("Tables"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => AddTableScreen(),
                  ),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: tableRestos.length,
        itemBuilder: (context, index) {
          return TableItem(
            table: tableRestos[index],
          );
        },
      ),
    );
  }
}
