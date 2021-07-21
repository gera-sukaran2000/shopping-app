import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  @required
  final String id;
  @required
  final String title;
  @required
  final double price;
  @required
  final String description;
  @required
  final String imageUrl;
  bool isFavorite;

  Product(
      {this.price,
      this.id,
      this.title,
      this.description,
      this.imageUrl,
      this.isFavorite = false});

  void isToggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
// i move this because we set provider for every single product so we chang and render is Favorite propert on screen