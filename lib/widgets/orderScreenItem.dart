import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myshop/providers/orders.dart';

class orderScreenItems extends StatefulWidget {
  final orderItem orderItems;

  orderScreenItems(this.orderItems);

  @override
  _orderScreenItemsState createState() => _orderScreenItemsState();
}

class _orderScreenItemsState extends State<orderScreenItems> {
  @override
  var _expanded = false;
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(children: [
          ListTile(
            title: Text('\₹ ${widget.orderItems.amount}'),
            subtitle: Text(
                DateFormat("dd MM yyyy hh:mm").format(widget.orderItems.date)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.orderItems.products.length * 20.0 + 10.0, 100),
              child: ListView(
                children: widget.orderItems.products
                    .map((prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prod.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('${prod.quantity} * \$ ${prod.price}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                )),
                          ],
                        ))
                    .toList(),
              ),
            )
        ]));
  }
}
