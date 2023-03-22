class Event {
  late String id;
  late String name;
  late String date;
  late String price;
  late String imgurl;
  late String description;
  late String restoId;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.price,
    required this.imgurl,
    required this.description,
    required this.restoId,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    date = json['date'];
    price = json['price'];
    imgurl = json['imgurl'];
    description = json['description'];
    restoId = json['restoId'].toString();
  }
}
