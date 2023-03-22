import 'package:flutter/material.dart';
import 'package:klitchyresto/models/food.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:klitchyresto/screens/foods/add_food.dart';
import 'package:klitchyresto/widgets/app_drawer.dart';
import 'package:klitchyresto/widgets/food_item.dart';
import 'package:provider/provider.dart';

class FoodsScreen extends StatefulWidget {
  const FoodsScreen({Key? key}) : super(key: key);

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  List<Food> foods = [];

  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).getFoods();
  }

  @override
  Widget build(BuildContext context) {
    foods = Provider.of<DataProvider>(context).foods;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Foods"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => AddFoodScreen(),
                  ),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return FoodItem(
            food: foods[index],
          );
        },
      ),
    );
  }
}
