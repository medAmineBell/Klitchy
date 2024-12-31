import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:klitchyresto/models/food.dart';
import 'package:klitchyresto/providers/cart_provider.dart';
import 'package:klitchyresto/widgets/pos_food_item.dart';
import 'package:provider/provider.dart';

class SelectFoodAlert extends StatefulWidget {
  final Food food;

  const SelectFoodAlert({
    super.key,
    required this.food,
  });
  @override
  _SelectFoodAlertState createState() => _SelectFoodAlertState();
}

class _SelectFoodAlertState extends State<SelectFoodAlert> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: TextStyle(
          color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          child: Icon(
            Icons.close,
            size: 27,
            color: Colors.red,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      content: Container(
        height: 400,
        width: 500,
        child: Column(
          // shrinkWrap: true,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                height: 200, width: 250, child: POSFoodItem(food: widget.food)),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Quantity',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: 190,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 5),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity > 0) {
                                    quantity--;
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                        Card(
                          elevation: 4,
                          child: Container(
                            width: 60,
                            child: Center(
                                child: Text(
                              quantity.toString(),
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w800),
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 60),
              child: InkWell(
                onTap: () async {
                  Provider.of<CartProvider>(context, listen: false)
                      .addItem(widget.food, quantity);
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 400,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(68),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Add To Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${quantity * widget.food.price} TND",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
