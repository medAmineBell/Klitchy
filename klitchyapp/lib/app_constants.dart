import 'package:flutter/material.dart';

class AppConstants {
  static const List<Map<String, dynamic>> categories = [
    {
      "Pizza": Icon(
        Icons.local_pizza,
        color: Colors.white,
        size: 35,
      )
    },
    {
      "FastFood": Icon(
        Icons.fastfood,
        color: Colors.white,
        size: 35,
      )
    },
    {
      "Burger": Icon(
        Icons.lunch_dining_outlined,
        color: Colors.white,
        size: 35,
      )
    },
    {
      "Spagethi": Icon(
        Icons.dinner_dining,
        color: Colors.white,
        size: 35,
      )
    },
    {
      "Soup": Icon(
        Icons.soup_kitchen_outlined,
        color: Colors.white,
        size: 35,
      )
    },
    {
      "Breakfest": Icon(
        Icons.bakery_dining,
        color: Colors.white,
        size: 35,
      )
    },
  ];

  static const String serverUrl = "http://10.0.2.2:8081";
}
