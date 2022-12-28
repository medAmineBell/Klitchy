import 'package:flutter/material.dart';
import 'package:klitchyapp/app_constants.dart';
import 'package:klitchyapp/models/food.dart';
import 'package:klitchyapp/models/order.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final Food food;

  const OrderItem({
    Key? key,
    required this.order,
    required this.food,
  }) : super(key: key);

  String getCategoryName(BuildContext context) {
    final categories =
        Provider.of<DataProvider>(context, listen: false).categories;
    return categories
        .firstWhere((element) => element.id == food.categoryId)
        .name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Card(
        elevation: 0,
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
                        getCategoryName(context),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        food.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            food.price.toStringAsFixed(2) + ' DT',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "x" + order.qty.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          )
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
