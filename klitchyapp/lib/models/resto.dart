class Resto {
  late String id;
  late String email;
  late String username;
  late String password;
  late String name;
  late String phone;
  late String imgurl;
  late String coverimgurl;
  late String address;
  late bool canOrder;
  late bool isActive;
  late bool haveEvent;

  Resto({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.imgurl,
    required this.coverimgurl,
    required this.address,
    required this.canOrder,
    required this.isActive,
    required this.haveEvent,
  });

  Resto.fromJson(Map<String, dynamic> json) {
    id = json["id"].toString();
    email = json["email"].toString();
    username = json["username"].toString();
    password = json["password"].toString();
    name = json["name"].toString();
    phone = json["phone"].toString();
    imgurl = json["imgurl"].toString();
    coverimgurl = json["coverimgurl"].toString();
    address = json["address"].toString();
    canOrder = json["canOrder"];
    isActive = json["isActive"];
    haveEvent = json["haveEvent"];
  }

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
