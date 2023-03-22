import 'package:flutter/material.dart';
import 'package:klitchyapp/app_constants.dart';
import 'package:klitchyapp/models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(AppConstants.serverUrl + category.imgurl),
                ),
                borderRadius: BorderRadius.circular(16)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(category.name),
        ],
      ),
    );
  }
}
