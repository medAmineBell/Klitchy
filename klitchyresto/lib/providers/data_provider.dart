import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:klitchyresto/models/category.dart';
import 'package:klitchyresto/models/event.dart';
import 'package:klitchyresto/models/food.dart';
import 'package:klitchyresto/models/order.dart';
import 'package:klitchyresto/models/resto.dart';
import 'package:klitchyresto/models/tableResto.dart';

class DataProvider with ChangeNotifier {
  final String serverUrl = "http://10.0.2.2:8081";
  late TableResto tableResto;

  List<Order> orders = [];
  List<Order> allorders = [];
  List<Order> completedOrders = [];

  late Resto resto;

  List<Category> categories = [];
  List<Food> foods = [];
  List<TableResto> tableRestos = [];
  List<Event> events = [];

  // void setTableResto(TableResto table) {
  //   tableResto = table;
  // }

  // void setClient(String name, String phone) {
  //   Client c = Client(name: name, phone: phone);
  //   client = c;
  // }

  //Resto

  Future<void> getRestoByID1(String id) async {
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

  Future<bool> loginResto(String username, String password) async {
    bool res = false;
    final url = serverUrl + '/api/restos/login';

    final response = await http.post(Uri.parse(url),
        body: {"username": username, "password": password});

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final restoData = extractedData['resto'];

      if (restoData != null) {
        resto = Resto.fromJson(restoData);
        res = true;
        await getCategories();
        await getFoods();
        await getTables();
        await getOrders();
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  //Category

  // Future<void> addCategoryAPI(String name) async {
  //   final url = serverUrl + '/api/categories';

  //   try {
  //     await http
  //         .post(Uri.parse(url), body: {"name": name, "restoId": resto.id});
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> addCategoryAPI(XFile image, String name) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(serverUrl + '/api/categories'));

    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    request.fields['restoId'] = resto.id;
    request.fields['name'] = name;
    request.headers['Content-Type'] = 'multipart/form-data';

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final bodyres = await response.stream.bytesToString();
      final extractedData = json.decode(bodyres) as Map<String, dynamic>;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> getCategories() async {
    final url = '$serverUrl/api/categories/resto/${resto.id}';

    final response = await http.get(
      Uri.parse(url),
    );

    print(response.body);

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

  Future<void> deleteFood(String foodId) async {
    final url = '$serverUrl/api/foods/$foodId';

    try {
      await http.delete(
        Uri.parse(url),
      );
    } catch (e) {
      print(e.toString());
    }
    await getFoods();
  }

  Future<void> updateFood(List<XFile> image, String name, String price,
      String catID, String foodId) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/foods/update/$foodId'));

    //request.files.add(await http.MultipartFile.fromPath('file', image.path));

    request.fields['categoryId'] = catID;
    request.fields['name'] = name;
    request.fields['price'] = price;
    request.headers['Content-Type'] = 'multipart/form-data';

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final bodyres = await response.stream.bytesToString();
      print(bodyres);
    } else {
      print(response.reasonPhrase);
    }
  }

  //Tables

  Future<void> getTables() async {
    final url = '$serverUrl/api/tableRestos/resto/${resto.id}';

    final response = await http.get(
      Uri.parse(url),
    );

    try {
      final tableData = json.decode(response.body) as List<dynamic>;

      if (tableData != null) {
        tableRestos = [];
        tableData.forEach((element) {
          final table = TableResto.fromJson(element);
          tableRestos.add(table);
        });
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> addTableAPI(String name) async {
    String qrcode = resto.id +
        tableRestos.length.toString() +
        DateTime.now().year.toString() +
        DateTime.now().month.toString() +
        DateTime.now().day.toString() +
        DateTime.now().hour.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().second.toString();
    final url = serverUrl + '/api/tableRestos';

    try {
      await http.post(Uri.parse(url),
          body: {"name": name, "qrcode": qrcode, "restoId": resto.id});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteTable(String tableId) async {
    final url = '$serverUrl/api/tableRestos/$tableId';

    try {
      await http.delete(
        Uri.parse(url),
      );
    } catch (e) {
      print(e.toString());
    }
    await getTables();
  }

  Future<void> updateTable(String name, String tableId) async {
    final url = serverUrl + '/api/tableRestos/$tableId';

    try {
      await http.put(Uri.parse(url), body: {"name": name});
    } catch (e) {
      print(e.toString());
    }
  }

  //Orders
  Future<void> getOrders() async {
    final url = '$serverUrl/api/orders/resto/${resto.id}';

    final response = await http.get(
      Uri.parse(url),
    );

    try {
      final orderData = json.decode(response.body) as List<dynamic>;

      if (orderData != null) {
        orders = [];
        allorders = [];
        completedOrders = [];
        orderData.forEach((element) {
          final order = Order.fromJson(element);
          allorders.add(order);

          if (order.status == "Completed") {
            completedOrders.add(order);
          } else {
            orders.add(order);
          }
        });
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
  //Events

  Future<void> getEvents() async {
    final url = '$serverUrl/api/events/resto/${resto.id}';

    final response = await http.get(
      Uri.parse(url),
    );

    try {
      final eventData = json.decode(response.body) as List<dynamic>;

      if (eventData != null) {
        events = [];
        eventData.forEach((element) {
          final food = Event.fromJson(element);
          events.add(food);
        });
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> addEvent(XFile image, String name, String description,
      String date, String price) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(serverUrl + '/api/events'));

    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    request.fields['restoId'] = resto.id;
    request.fields['name'] = name;
    request.fields['date'] = date;
    request.fields['price'] = price;
    request.fields['description'] = description;
    request.headers['Content-Type'] = 'multipart/form-data';

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final bodyres = await response.stream.bytesToString();
      final extractedData = json.decode(bodyres) as Map<String, dynamic>;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> updateEvent(XFile image, String name, String description,
      String date, String price, String eventId) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(serverUrl + '/api/events/update/$eventId'));

    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    request.fields['restoId'] = resto.id;
    request.fields['name'] = name;
    request.fields['date'] = date;
    request.fields['price'] = price;
    request.fields['description'] = description;
    request.headers['Content-Type'] = 'multipart/form-data';

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final bodyres = await response.stream.bytesToString();
      final extractedData = json.decode(bodyres) as Map<String, dynamic>;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> deleteEvent(String eventId) async {
    final url = '$serverUrl/api/events/$eventId';

    try {
      await http.delete(
        Uri.parse(url),
      );
    } catch (e) {
      print(e.toString());
    }
    await getFoods();
  }
}
