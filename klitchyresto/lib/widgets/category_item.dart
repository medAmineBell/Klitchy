import 'package:flutter/material.dart';
import 'package:klitchyresto/models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
    );
  }
}
