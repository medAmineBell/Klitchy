class Order {
  String id;
  String name;
  double total;
  String status;
  String foodID;
  String clientID;
  String restoID;
  String tableID;

  Order({
    required this.id,
    required this.name,
    required this.total,
    required this.status,
    required this.foodID,
    required this.clientID,
    required this.restoID,
    required this.tableID,
  });
}
