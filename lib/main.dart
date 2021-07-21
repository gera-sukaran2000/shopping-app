import 'package:flutter/material.dart';
import 'package:myshop/providers/CartItem.dart';
import 'package:myshop/providers/orders.dart';
import 'package:myshop/providers/products_provider.dart';
import 'package:myshop/screens/CartsScreen.dart';
import 'package:myshop/screens/Product_details.dart';
import 'package:myshop/screens/UserProductsScreen.dart';
import 'package:myshop/screens/editProductScreen.dart';
import 'package:myshop/screens/orderScreen.dart';
import 'package:myshop/screens/productsOverview.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.deepOrange[400],
          fontFamily: 'Lato',
        ),
        home: ProductsOverViewScreen(),
        routes: {
          'productsDetail': (context) => productDetails(),
          'CartScreen': (context) => CartScreen(),
          'orderScreen': (context) => OrderScreen(),
          'UserProductsScreen': (context) => UserProductsScreen(),
          'EditProductsScreen': (context) => EditProductsScreen(),
        },
      ),
    );
  }
}
