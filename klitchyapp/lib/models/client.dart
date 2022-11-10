class Client {
  String id;
  String name;
  String phone;
  String tableID;

  Client({
    required this.id,
    required this.name,
    required this.phone,
    this.tableID = "",
  });
}
