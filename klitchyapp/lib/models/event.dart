class Event {
  late String id;
  late String name;
  late String date;
  late String imgurl;
  late String description;
  late String price;
  late String restoId;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.imgurl,
    required this.description,
    required this.price,
    required this.restoId,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    date = json['date'];
    imgurl = json['imgurl'];
    description = json['description'];
    price = json['price'];
    restoId = json['restoId'].toString();
  }
}
