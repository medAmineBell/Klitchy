import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:klitchyapp/models/food.dart';
import 'package:klitchyapp/models/order.dart';

class CartItem {
  final Food food;
  final int quantity;

  CartItem({
    required this.food,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  List<Order> orders = [];

  bool canOrder = false;

  int totalQty = 0;

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;

    _items.forEach((key, cartItem) {
      total += cartItem.food.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Food food, int qty) {
    if (_items.containsKey(food.id)) {
      // change quantity...
      _items.update(
        food.id,
        (existingCartItem) => CartItem(
          food: food,
          quantity: existingCartItem.quantity + qty,
        ),
      );
    } else {
      _items.putIfAbsent(
        food.id,
        () => CartItem(
          food: food,
          quantity: qty,
        ),
      );
    }
    canOrder = true;
    totalQty++;
    notifyListeners();
  }

  void addSingleItem(String foodId) {
    if (_items.containsKey(foodId)) {
      // change quantity...
      _items.update(
        foodId,
        (existingCartItem) => CartItem(
          food: existingCartItem.food,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    }
    totalQty++;
    notifyListeners();
  }

  void removeItem(String foodId) {
    _items.remove(foodId);
    totalQty--;
    notifyListeners();
  }

  void removeSingleItem(String foodId) {
    if (!_items.containsKey(foodId)) {
      return;
    }
    if (_items[foodId]!.quantity > 1) {
      _items.update(
          foodId,
          (existingCartItem) => CartItem(
                food: existingCartItem.food,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(foodId);
    }
    if (_items.isEmpty) canOrder = false;
    totalQty--;
    notifyListeners();
  }

  void clear() {
    _items = {};

    orders = [];
    canOrder = false;
    totalQty = 0;
    notifyListeners();
  }
}
