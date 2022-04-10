import 'package:flutter/material.dart';
import '../widgets/plantas_item.dart';
import 'package:provider/provider.dart';
import '../providers/plantas.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavoritos;
  ProductsGrid(this.showFavoritos);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Plantas>(context);
    final products =
        showFavoritos ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 16 / 9,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
