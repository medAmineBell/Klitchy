import 'package:flutter/material.dart';
import 'package:klitchyresto/models/food.dart';

class FoodItem extends StatelessWidget {
  final Food food;

  const FoodItem({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(food.name),
      subtitle: Text(food.description),
      trailing: Text(food.price.toString()),
    );
  }
}
