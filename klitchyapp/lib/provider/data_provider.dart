import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';

class DataProvider with ChangeNotifier {
  late TableResto tableResto;
  Resto resto = Resto(
    id: "1",
    email: "resto@gmail.com",
    username: "resto",
    password: "azerty",
    name: "Resto",
    phone: "99999999",
    imgurl: "dsjfkdskf",
    address: "Nabeul",
    canOrder: true,
    isActive: true,
    haveEvent: false,
  );
  late Client client;
  List<Category> categories = [];

  void setTableResto(TableResto table) {
    tableResto = table;
  }

  void setClient(String name, String phone) {
    Client c = Client(name: name, phone: phone);
    client = c;
  }
}
