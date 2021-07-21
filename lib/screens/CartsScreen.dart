import 'package:flutter/material.dart';
import 'package:myshop/providers/CartItem.dart';
import 'package:myshop/providers/orders.dart';
import 'package:myshop/widgets/CartProducts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryTextTheme.title.color),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\₹ ${cart.totalPrice}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addItems(
                            cart.loadedCartItems.values.toList(),
                            cart.totalPrice);
                        cart.clearCart();
                      },
                      child: Text(
                        'ORDER NOW',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, index) => cartProducts(
                cart.loadedCartItems.values.toList()[index].id,
                cart.loadedCartItems.keys.toList()[index],
                cart.loadedCartItems.values.toList()[index].price,
                cart.loadedCartItems.values.toList()[index].title,
                cart.loadedCartItems.values.toList()[index].quantity),
            itemCount: cart.totalItems,
          ))
        ],
      ),
    );
  }
}
