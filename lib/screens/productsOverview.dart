import 'package:flutter/material.dart';
import 'package:myshop/providers/CartItem.dart';
import 'package:myshop/widgets/badge.dart';
import 'package:myshop/widgets/drawerApp.dart';
import 'package:myshop/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum OptionFilter {
  Favorites,
  All,
}

class ProductsOverViewScreen extends StatefulWidget {
  @override
  _ProductsOverViewScreenState createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerApp(),
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (OptionFilter selectedValue) {
              setState(() {
                if (selectedValue == OptionFilter.Favorites) {
                  _showFavorites = true;
                } else if (selectedValue == OptionFilter.Favorites) {
                  _showFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            // ignore: missing_return
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show Favorites'),
                value: OptionFilter.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: OptionFilter.All,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartObject, ch) => Badge(
              value: cartObject.totalItems.toString(),
              child: ch,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed('CartScreen');
              },
            ),
          )
        ],
      ),
      body: productGrid(_showFavorites),
    );
  }
}
