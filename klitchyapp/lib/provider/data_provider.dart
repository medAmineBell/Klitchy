import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';

class DataProvider with ChangeNotifier {
  final String serverUrl = "http://10.0.2.2:8081";
  late TableResto tableResto;
  late Resto resto;
  late Client client;
  late Client owner;
  List<Category> categories = [];

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

  //Table

  Future<dynamic> getTableByQrCode(String code) async {
    dynamic result;
    final url = serverUrl + '/api/tableRestos/getTable';

    final response = await http.post(Uri.parse(url), body: {"qrcode": code});

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final tableRestoData = extractedData['tableResto'];

      if (tableRestoData != null) {
        tableResto = TableResto.fromJson(tableRestoData);
        result = tableResto;
        await getRestoByID(tableResto.restoId);
        await getClientByID(tableResto.owner);
      } else {
        result = null;
      }
    } catch (e) {
      print(e.toString());
    }

    return result;
  }

  Future<void> setOwner() async {
    final url = serverUrl + '/api/tableRestos/setOwner';

    await http.post(Uri.parse(url), body: {
      "id": tableResto.id,
      "owner": client.id,
      "listclients": client.id
    });
  }

  //Client

  Future<bool> getClientByPhone(String phone) async {
    bool isClientFound = false;
    final url = serverUrl + '/api/clients/getClientByPhone';

    final response = await http.post(Uri.parse(url), body: {"phone": phone});

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final clientData = extractedData['client'];

      if (clientData != null) {
        client = Client.fromJson(clientData);
        isClientFound = true;
      } else {
        isClientFound = false;
      }
    } catch (e) {
      print(e.toString());
    }

    return isClientFound;
  }

  Future<void> addClient(String phone, String name) async {
    bool isClientFound = await getClientByPhone(phone);
    if (!isClientFound) {
      final url = serverUrl + '/api/clients';

      final response =
          await http.post(Uri.parse(url), body: {"phone": phone, "name": name});

      try {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final clientData = extractedData['client'];

        if (clientData != null) {
          client = Client.fromJson(clientData);
        } else {}
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> getClientByID(String id) async {
    final url = serverUrl + '/api/clients/$id';

    final response = await http.get(Uri.parse(url));

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final clientData = extractedData['client'];

      if (clientData != null) {
        owner = Client.fromJson(clientData);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
