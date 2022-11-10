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
}
