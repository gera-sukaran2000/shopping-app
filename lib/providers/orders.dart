import 'package:flutter/material.dart';
import 'package:myshop/providers/CartItem.dart';
import 'package:myshop/widgets/CartProducts.dart';

class orderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  orderItem(@required this.id, @required this.amount, @required this.products,
      @required this.date);
}

class Orders with ChangeNotifier {
  final List<orderItem> _orders = [];

  List<orderItem> get orderItems {
    return [..._orders];
  }

  void addItems(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        orderItem(
            DateTime.now().toString(), total, cartProducts, DateTime.now()));
    notifyListeners();
  }
}
