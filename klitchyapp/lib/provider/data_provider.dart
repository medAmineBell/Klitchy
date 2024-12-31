import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klitchyapp/app_constants.dart';
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/event.dart';
import 'package:klitchyapp/models/food.dart';
import 'package:klitchyapp/models/order.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/models/userItem.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DataProvider with ChangeNotifier {
  final String serverUrl = AppConstants.serverUrl;
  late IO.Socket socket;
  late TableResto tableResto;
  late Resto resto;
  late Client client;
  late Client owner;

  List<Category> categories = [];
  List<Food> foods = [];
  List<Order> orders = [];
  List<Order> allorders = [];
  List<Event> events = [];

  bool isOwner() {
    return client.id == owner.id;
  }

  DataProvider() {
    connectToSocket();
  }

  void requestJoinTable() {
    if (socket.disconnected) {
      connectToSocket();
    }
    socket
        .emit('JoinTable', {"user": client.toJson(), "tableId": tableResto.id});
  }

  void orderTable() {
    if (socket.disconnected) {
      connectToSocket();
    }
    socket.emit('orderTable', {"restoId": resto.id});
  }

  void responseJoinTable(Client c, bool isAllowed) {
    if (socket.disconnected) {
      connectToSocket();
    }
    socket.emit('JoinTable_response',
        {"user": c.toJson(), "tableId": tableResto.id, "isAllowed": isAllowed});
  }

  void connectToSocket() {
    try {
      // Configure socket transports must be sepecified
      socket = IO.io(AppConstants.socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('connect_error', (e) => print(e));
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
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

    // List<String> listClients = [];
    // listClients.add(client.id);

    await http.post(Uri.parse(url), body: {
      "id": tableResto.id,
      "owner": client.id,
      "listclients": client.id,
      "statuts": "owned"
    });
    owner = client;
  }

  Future<void> addClientToTable() async {
    final url = serverUrl + '/api/tableRestos/setOwner';

    // List<String> listClients = [];
    // listClients.add(client.id);
    String listc = "";
    for (var element in tableResto.listclients) {
      listc += element + ",";
    }
    listc += client.id;
//
    await http.post(Uri.parse(url), body: {
      "id": tableResto.id,
      "listclients": listc,
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

  //Foods

  Future<void> getFoods() async {
    final url = '$serverUrl/api/foods/resto/${resto.id}';

    final response = await http.get(
      Uri.parse(url),
    );

    try {
      final foodData = json.decode(response.body) as List<dynamic>;

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

//Categories
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

  //Order
  Future<void> addOrder(
      double total, String orderNum, int qty, String foodId) async {
    final url = serverUrl + '/api/orders';
    print(resto.id);

    try {
      await http.post(Uri.parse(url), body: {
        "total": total.toStringAsFixed(2),
        "orderNum": orderNum,
        "qty": qty.toString(),
        "foodId": foodId,
        "tableRestoId": tableResto.id,
        "clientId": client.id,
        "restoId": resto.id,
        "paymentMethod": "",
      });
    } catch (e) {
      print(e.toString());
    }
  }

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

        orderData.forEach((element) {
          final order = Order.fromJson(element);
          allorders.add(order);
          if (tableResto.id == order.tableId && order.status != "Completed") {
            if (order.clientId == client.id) {
              orders.add(order);
            }
          }
        });
      }
    } catch (e) {
      print(e.toString());
    }
    //await getListTableUsers();
    notifyListeners();
  }

  Future<void> payOrder(String orderId, String paymentMethod) async {
    final url = serverUrl + '/api/orders/$orderId';

    try {
      await http.put(Uri.parse(url), body: {
        "status": "Completed",
        "paymentMethod": paymentMethod,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, UserItem>> getListTableUsers(List<Order> orders) async {
    Map<String, UserItem> listTableUsers = {};

    for (var order in orders) {
      var name = await getClientName(order.clientId);

      listTableUsers.update(order.clientId, (existingUserItem) {
        existingUserItem.orders.add(order);

        return UserItem(
          name: existingUserItem.name,
          orders: existingUserItem.orders,
          total: existingUserItem.total + order.total,
        );
      }, ifAbsent: () {
        List<Order> emptyOrders = [];

        return UserItem(
          name: name,
          orders: emptyOrders,
          total: order.total,
        );
      });
    }

    // orders.forEach((order) async {
    //   //final name = await getClientName(order.clientId);

    //   listTableUsers.update(order.clientId, (existingUserItem) {
    //     existingUserItem.orders.add(order);

    //     return UserItem(
    //       name: existingUserItem.name,
    //       orders: existingUserItem.orders,
    //       total: existingUserItem.total + order.total,
    //     );
    //   }, ifAbsent: () {
    //     List<Order> emptyOrders = [];

    //     return UserItem(
    //       name: "name",
    //       orders: emptyOrders,
    //       total: order.total,
    //     );
    //   });
    // });

    return listTableUsers;
    //notifyListeners();
  }

  Future<String> getClientName(String id) async {
    String name = "";
    final url = serverUrl + '/api/clients/$id';

    final response = await http.get(Uri.parse(url));

    try {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final clientData = extractedData['client'];

      if (clientData != null) {
        final cc = Client.fromJson(clientData);
        name = cc.name;
      }
    } catch (e) {
      print(e.toString());
    }
    return name;
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
}
