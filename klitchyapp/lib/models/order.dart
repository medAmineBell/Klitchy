class Order {
  String id;
  String name;
  String total;
  String paymentMethod;
  String status;
  String clientID;
  String restoID;
  String tableID;

  Order({
    required this.id,
    required this.name,
    required this.total,
    required this.paymentMethod,
    required this.status,
    required this.clientID,
    required this.restoID,
    required this.tableID,
  });
}
