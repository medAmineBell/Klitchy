import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final int quantity;
  final String title;

  CustomHeader({
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 28.0),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 18.0),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: Icon(Icons.favorite, color: Colors.white, size: 32.0),
        ),
      ],
    );
  }
}
