class Client {
  late String id;
  late String name;
  late String phone;

  Client({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"].toString(),
        name: json["name"].toString(),
        phone: json["phone"].toString(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
