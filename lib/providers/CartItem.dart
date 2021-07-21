import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items =
      {}; //string here is the id of product which is different from id of cartitem

  Map<String, CartItem> get loadedCartItems {
    return {..._items};
  }

  int get totalItems {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, eachItem) {
      total += eachItem.price * eachItem.quantity;
    });
    return total;
  }

  void addCartItems(String productId, String title, String price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: double.parse(price),
              quantity:
                  1)); //if this product id is missing execute this function
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return; //if it would not be present it would reutn and function would not go down so no need to check below for presence of ke
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existing) => CartItem(
              id: existing.id,
              title: existing.title,
              price: existing.price,
              quantity: existing.quantity - 1));
    } else {
      //if not greater than 1 then value must be 1 so simply remove it
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
