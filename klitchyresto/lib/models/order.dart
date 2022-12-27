class Order {
  late String id;
  late String orderNum;
  late int qty;
  late double total;
  late String status;
  late String foodId;
  late String clientId;
  late String restoId;
  late String tableId;

  Order({
    required this.id,
    required this.orderNum,
    required this.qty,
    required this.total,
    required this.status,
    required this.foodId,
    required this.clientId,
    required this.restoId,
    required this.tableId,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json["id"].toString();
    orderNum = json["orderNum"].toString();
    qty = int.parse(json['qty'].toString());
    total = double.parse(json['total'].toString());
    status = json["status"].toString();
    foodId = json["foodId"].toString();
    clientId = json["clientId"].toString();
    restoId = json["restoId"].toString();
    tableId = json["tableId"].toString();
  }
}
