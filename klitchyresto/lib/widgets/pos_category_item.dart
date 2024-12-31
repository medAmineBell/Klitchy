import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/models/category.dart';

class POSCategoryItem extends StatelessWidget {
  final Category category;

  const POSCategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 76.0,
                width: 76,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          AppConstants.serverUrl + category.imgurl),
                    ),
                    borderRadius: BorderRadius.circular(16)),
              ),
              Text(category.name),
            ],
          ),
        ),
      ),
    );
  }
}
