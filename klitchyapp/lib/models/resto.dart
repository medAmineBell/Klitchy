class Resto {
  String id;
  String email;
  String username;
  String password;
  String name;
  String phone;
  String imgurl;
  String address;
  bool canOrder;
  bool isActive;
  bool haveEvent;

  Resto({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.imgurl,
    required this.address,
    required this.canOrder,
    required this.isActive,
    required this.haveEvent,
  });

  factory Resto.fromJson(Map<String, dynamic> json) => Resto(
        id: json["id"].toString(),
        email: json["email"].toString(),
        username: json["username"].toString(),
        password: json["password"].toString(),
        name: json["name"].toString(),
        phone: json["phone"].toString(),
        imgurl: json["imgurl"].toString(),
        address: json["address"].toString(),
        canOrder: json["canOrder"],
        isActive: json["isActive"],
        haveEvent: json["haveEvent"],
      );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = id;
  //   data['email'] = email;
  //   data['listclients'] = listclients;
  //   data['owner'] = owner;
  //   data['qrcode'] = qrcode;
  //   data['status'] = status;
  //   data['total'] = total;
  //   data['isSplit'] = isSplit;
  //   data['restoId'] = restoId;

  //   return data;
  // }
}
