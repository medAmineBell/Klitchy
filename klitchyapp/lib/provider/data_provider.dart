import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';

class DataProvider with ChangeNotifier {
  final String serverUrl = "http://10.0.2.2:8081";
  late TableResto tableResto;
  // late Resto resto;
  // late Client client;
  // late Client owner;

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
  Client client = Client(id: "1", name: "name", phone: "phone");
  Client owner = Client(id: "1", name: "name", phone: "phone");
  List<Category> categories = [];

  // void setTableResto(TableResto table) {
  //   tableResto = table;
  // }

  // void setClient(String name, String phone) {
  //   Client c = Client(name: name, phone: phone);
  //   client = c;
  // }

  bool isOwner() {
    return client.id == owner.id;
  }

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

    // result = TableResto(
    //     id: "1",
    //     name: "Plan B",
    //     listclients: "",
    //     owner: "1",
    //     qrcode: "1234",
    //     restoId: "1",
    //     total: 10,
    //     status: "open",
    //     isSplit: false);

    // tableResto = result;

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

  //Test
  // Future<void> addCategoryAPI(String name, XFile image) async {
  //   final imgurl = await uploadFileAPI(image);
  //   final url = serverUrl + '/api/categories';
  //   final response = await http.post(Uri.parse(url),
  //       body: {"restoId": resto.id, "name": name, "imgurl": imgurl});

  //   print(response.body);
  // }

  // Future<String> uploadFileAPI(XFile image) async {
  //   String imgurl = "";
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse(serverUrl + '/api/uploadFile/upload'));

  //   request.files.add(await http.MultipartFile.fromPath('file', image.path));

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     final bodyres = await response.stream.bytesToString();
  //     final extractedData = json.decode(bodyres) as Map<String, dynamic>;

  //     imgurl = extractedData['filename'];
  //   } else {
  //     print(response.reasonPhrase);
  //   }

  //   return imgurl;
  // }

  Future<void> addCategoryAPI(String name, XFile image) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(serverUrl + '/api/categories'));

    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    request.fields.addAll({
      'name': name,
      'restoId': "1",
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<String> uploadFileAPI(XFile image) async {
    String imgurl = "";
    var request = http.MultipartRequest(
        'POST', Uri.parse(serverUrl + '/api/uploadFile/upload'));

    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final bodyres = await response.stream.bytesToString();
      final extractedData = json.decode(bodyres) as Map<String, dynamic>;

      imgurl = extractedData['filename'];
    } else {
      print(response.reasonPhrase);
    }

    return imgurl;
  }
}
