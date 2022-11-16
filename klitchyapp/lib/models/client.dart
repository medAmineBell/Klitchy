class Client {
  String id;
  String name;
  String phone;
  String tableId;

  Client({
    this.id = "",
    required this.name,
    required this.phone,
    this.tableId = "",
  });
}
