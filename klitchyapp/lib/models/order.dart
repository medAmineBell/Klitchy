class Order {
  String id;
  int qty;
  double total;
  String status;
  String foodId;
  String clientId;
  String restoId;
  String tableId;

  Order({
    required this.id,
    required this.qty,
    required this.total,
    required this.status,
    required this.foodId,
    required this.clientId,
    required this.restoId,
    required this.tableId,
  });
}
