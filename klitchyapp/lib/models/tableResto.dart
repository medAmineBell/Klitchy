class TableResto {
  late String id;
  late String name;
  late String listclients;
  late String owner;
  late String qrcode;
  late String status;
  late double total;
  late String restoId;
  late bool isSplit;

  TableResto({
    required this.id,
    required this.name,
    required this.listclients,
    required this.owner,
    required this.qrcode,
    required this.status,
    required this.total,
    required this.isSplit,
    required this.restoId,
  });
  factory TableResto.fromJson(Map<String, dynamic> json) => TableResto(
        id: json["id"].toString(),
        name: json["name"].toString(),
        listclients: json["listclients"].toString(),
        owner: json["owner"].toString(),
        qrcode: json["qrcode"].toString(),
        total: double.parse(json["total"].toString()),
        status: json["status"].toString(),
        isSplit: json["isSplit"],
        restoId: json["restoId"].toString(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['listclients'] = listclients;
    data['owner'] = owner;
    data['qrcode'] = qrcode;
    data['status'] = status;
    data['total'] = total;
    data['isSplit'] = isSplit;
    data['restoId'] = restoId;

    return data;
  }
}
