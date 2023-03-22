import 'package:klitchyapp/models/order.dart';

class UserItem {
  final String name;
  final List<Order> orders;
  final double total;

  UserItem({
    required this.name,
    required this.orders,
    required this.total,
  });
}
