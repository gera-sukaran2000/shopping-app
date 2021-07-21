import 'package:flutter/material.dart';
import 'package:myshop/providers/CartItem.dart';
import 'package:provider/provider.dart';

class cartProducts extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final String title;
  final int quantity;

  const cartProducts(
      this.id, this.productId, this.price, this.title, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red[300],
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Are You Sure ?'),
                content: Text(
                    'Are You Sure You Want To Remove This Item From Cart ?'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No')),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Yes')),
                ],
              );
            });
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  '$price',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text(
            'total : ${(price * quantity)}',
            style: TextStyle(color: Colors.grey[400]),
          ), //gives total of that specific item
          trailing: Text('$quantity  x'),
        ),
      ),
    );
  }
}
