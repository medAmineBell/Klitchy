import 'package:flutter/material.dart';

class TableOrderItem extends StatelessWidget {
  final String qty;
  final String name;
  final String total;
  const TableOrderItem(
      {Key? key, required this.qty, required this.name, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.grey[700],
          fontSize: 14,
        ),
      ),
      title: Text(
        "X$qty",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
      ),
      trailing: Text(
        "$total DT",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
