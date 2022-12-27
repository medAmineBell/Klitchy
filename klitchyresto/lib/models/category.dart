class Category {
  late String id;
  late String name;
  late String restoId;

  Category({
    required this.id,
    required this.name,
    required this.restoId,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    restoId = json['restoId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['restoId'] = restoId;

    return data;
  }
}
