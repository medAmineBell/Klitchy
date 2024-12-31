import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/models/food.dart';

class POSFoodItem extends StatelessWidget {
  final Food food;

  const POSFoodItem({Key? key, required this.food}) : super(key: key);

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
                //width: 76,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.serverUrl + food.imgurl),
                    ),
                    borderRadius: BorderRadius.circular(16)),
              ),
              Text(food.name),
              Text(food.price.toString() + " DT"),
            ],
          ),
        ),
      ),
    );
  }
}
