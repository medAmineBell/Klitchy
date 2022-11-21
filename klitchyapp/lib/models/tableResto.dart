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
  TableResto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    listclients = json['listclients'];
    owner = json['owner'];
    qrcode = json['qrcode'];
    status = json['status'];
    total = json['total'];
    isSplit = json['isSplit'];
    restoId = json['restoId'];
  }

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
