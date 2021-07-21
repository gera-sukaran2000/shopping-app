import 'package:flutter/material.dart';
import 'package:myshop/providers/products_provider.dart';
import 'package:myshop/widgets/Productsitem.dart';
import 'package:provider/provider.dart';

class productGrid extends StatelessWidget {
  final _showFavorites;

  productGrid(this._showFavorites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(
        context); //object of Product sent by provider ends up here and any change in this will cause this to rebuild
    final productsList = _showFavorites
        ? productsData.loadedFavoriteProductsValues
        : productsData.loadedProductsValues;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: productsList[index],
        child: ProductItemView(
            //productsList[index].id,  productsList[index].imageUrl, productsList[index].title),
            ),
      ),
      itemCount: productsList.length,
    );
  }
}
