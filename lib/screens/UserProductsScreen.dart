import 'package:flutter/material.dart';
import 'package:myshop/providers/products_provider.dart';
import 'package:myshop/widgets/UserProductsItem.dart';
import 'package:myshop/widgets/drawerApp.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('EditProductsScreen');
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: DrawerApp(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.loadedProductsValues.length,
          itemBuilder: (ctx, index) => Column(
            children: [
              UserProductItem(
                  productsData.loadedProductsValues[index].id,
                  productsData.loadedProductsValues[index].title,
                  productsData.loadedProductsValues[index].imageUrl),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
