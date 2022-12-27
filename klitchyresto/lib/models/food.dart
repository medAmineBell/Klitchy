class Food {
  late String id;
  late String name;
  late double price;
  late String imgurl;
  late String description;
  late String restoId;
  late String categoryId;

  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.imgurl,
    required this.description,
    required this.restoId,
    required this.categoryId,
  });

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    price = double.parse(json['price'].toString());
    imgurl = json['imgurl'];
    description = json['description'];
    restoId = json['restoId'].toString();
    categoryId = json['categoryId'].toString();
  }
}
