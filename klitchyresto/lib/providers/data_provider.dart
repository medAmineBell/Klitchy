import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:klitchyresto/models/category.dart';
import 'package:klitchyresto/models/client.dart';
import 'package:klitchyresto/models/food.dart';
import 'package:klitchyresto/models/resto.dart';
import 'package:klitchyresto/models/tableResto.dart';

class DataProvider with ChangeNotifier {
  final String serverUrl = "http://10.0.2.2:8081";
  late TableResto tableResto;

  Resto resto = Resto(
      id: "1",
      email: "mail",
      username: "username",
      password: "password",
      name: "Plan B",
      phone: "phone",
      imgurl: "imgurl",
      address: "address",
      canOrder: true,
      isActive: true,
      haveEvent: true);
  List<Category> categories = [];
  List<Food> foods = [];

  // void setTableResto(TableResto table) {
  //   tableResto = table;
  // }

  // void setClient(String name, String phone) {
  //   Client c = Client(name: name, phone: phone);
  //   client = c;
  // }

  //Resto

  Future<void> getRestoByID(String id) async {
    final url = serverUrl + '/api/restos/$id';

    final response = await http.get(
      Uri.parse(url),
    );

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final restoData = extractedData['resto'];

      if (restoData != null) {
        resto = Resto.fromJson(restoData);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Category

  Future<void> addCategoryAPI(String name) async {
    final url = serverUrl + '/api/categories';

    try {
      await http
          .post(Uri.parse(url), body: {"name": name, "restoId": resto.id});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getCategories() async {
    final url = '$serverUrl/api/categories/resto/${resto.id}';

    final response = await http.get(
      Uri.parse(url),
    );

    try {
      final categoryData = json.decode(response.body) as List<dynamic>;

      if (categoryData != null) {
        categories = [];
        categoryData.forEach((element) {
          final cat = Category.fromJson(element);
          categories.add(cat);
        });
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  //Food

  Future<void> addFood(
      XFile image, String name, String price, String catID) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(serverUrl + '/api/foods'));

    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    request.fields['restoId'] = resto.id;
    request.fields['categoryId'] = catID;
    request.fields['name'] = name;
    request.fields['price'] = price;
    request.headers['Content-Type'] = 'multipart/form-data';

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final bodyres = await response.stream.bytesToString();
      final extractedData = json.decode(bodyres) as Map<String, dynamic>;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> getFoods() async {
    final url = '$serverUrl/api/foods/resto/${resto.id}';

    final response = await http.get(
      Uri.parse(url),
    );

    try {
      final foodData = json.decode(response.body) as List<dynamic>;
      print(foodData);
      if (foodData != null) {
        foods = [];
        foodData.forEach((element) {
          final food = Food.fromJson(element);
          foods.add(food);
        });
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
