import 'package:flutter/material.dart';
import 'package:myshop/providers/CartItem.dart';
import 'package:myshop/providers/product.dart';
import 'package:provider/provider.dart';

class ProductItemView extends StatelessWidget {
  // final String id;
  // final String imageUrl;
  // final String title;

  // ProductItemView(this.id, this.imageUrl, this.title);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('productsDetail', arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                icon: product.isFavorite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  product.isToggleFavorite();
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  cart.addCartItems(
                      product.id, product.title, product.price.toString());

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Product Added To Cart'),
                    duration: Duration(seconds: 3),
                    action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ));
                },
                color: Theme.of(context).accentColor)),
      ),
    );
  }
}
