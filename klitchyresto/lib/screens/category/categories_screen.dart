import 'package:flutter/material.dart';
import 'package:klitchyresto/models/category.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:klitchyresto/screens/category/add_category_screen.dart';
import 'package:klitchyresto/widgets/app_drawer.dart';
import 'package:klitchyresto/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    categories = Provider.of<DataProvider>(context).categories;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => AddCategoryScreen(),
                  ),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryItem(
            category: categories[index],
          );
        },
      ),
    );
  }
}
