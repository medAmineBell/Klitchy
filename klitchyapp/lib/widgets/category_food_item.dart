import 'package:flutter/material.dart';
import 'package:klitchyapp/app_constants.dart';
import 'package:klitchyapp/models/food.dart';

class CategoryFoodItem extends StatelessWidget {
  final Food food;

  CategoryFoodItem({
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(17),
                child: Container(
                  height: 76.0,
                  width: 76,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              AppConstants.serverUrl + food.imgurl),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${food.price} DT',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, size: 15, color: Colors.orange),
                              Icon(Icons.star, size: 15, color: Colors.orange),
                              Icon(Icons.star, size: 15, color: Colors.orange),
                              Icon(Icons.star_border,
                                  size: 15, color: Colors.orange),
                              Icon(Icons.star_border,
                                  size: 15, color: Colors.orange),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
