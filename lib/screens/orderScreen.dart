import 'package:flutter/material.dart';
import 'package:myshop/providers/orders.dart';
import 'package:myshop/widgets/drawerApp.dart';
import 'package:myshop/widgets/orderScreenItem.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Your Orders')),
        drawer: DrawerApp(),
        body: ListView.builder(
          itemCount: items.orderItems.length,
          itemBuilder: (ctx, index) =>
              orderScreenItems(items.orderItems[index]),
        ));
  }
}
