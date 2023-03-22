import 'package:flutter/material.dart';
import 'package:klitchyresto/models/tableResto.dart';
import 'package:klitchyresto/screens/tables/view_table_screen.dart';

class TableItem extends StatelessWidget {
  final TableResto table;

  const TableItem({Key? key, required this.table}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => ViewTableScreen(
                table: table,
              ),
            ),
          );
        },
        title: Text(table.name),
        subtitle: Text(table.qrcode),
        trailing: Text(table.total.toString()),
      ),
    );
  }
}
