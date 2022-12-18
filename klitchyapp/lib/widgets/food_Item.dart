import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  final Color primaryColor;
  final String productUrl,
      productName,
      productPrice,
      productRate,
      productClients;

  FoodItem({
    required this.primaryColor,
    required this.productUrl,
    required this.productName,
    required this.productPrice,
    required this.productRate,
    required this.productClients,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 210,
        height: 240,
        child: Column(
          children: <Widget>[
            // Container(
            //     //height: 140.0,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage(productUrl),
            //       ),
            //     ),
            //   ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/food.jpeg"),
                ),
              ),
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 15,
                left: 10,
              ),
              child: Row(
                children: [
                  Text(
                    productName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$productPrice DT',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF006C81),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, size: 15, color: Colors.orange),
                      Icon(Icons.star, size: 15, color: Colors.orange),
                      Icon(Icons.star, size: 15, color: Colors.orange),
                      Icon(Icons.star_border, size: 15, color: Colors.orange),
                      Icon(Icons.star_border, size: 15, color: Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
