import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';

class DataProvider with ChangeNotifier {
  final String serverUrl = "http://10.0.2.2:8081";
  TableResto tableResto = TableResto(
      id: "1",
      name: "20",
      listclients: "amine,kissa",
      owner: "amine",
      qrcode: "dskgdsjgdjsgkkdsgh",
      status: "reserved",
      total: 22.50,
      isSplit: false,
      restoId: "1");
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

  Future<void> getTableByQrCode(String code) async {
    final url = serverUrl + '/api/tableRestos/getTable';

    final response = await http.post(Uri.parse(url), body: {"qrcode": code});

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      //final userData = extractedData['user'];
      print(extractedData);
      if (extractedData != null) {
        // user.id = userData["id"].toString();
        // user.fname = userData["first_name"];
        // user.lname = userData["last_name"];
        // user.email = userData["email"];
        // user.role = userData["role"];
        // user.phone = userData["phone_number"];
        // user.avatar = userData["avatar"];
        // user.emailVerifiedAt = userData["email_verified_at"];
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
