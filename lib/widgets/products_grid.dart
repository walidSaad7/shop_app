import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/provider/products.dart';
import 'package:shop1/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool ShowFavo;

  ProductsGrid( this.ShowFavo) ;

  @override
  Widget build(BuildContext context) {
    final productData= Provider.of<Products>(context);
    final products=ShowFavo?productData.Favitems:productData.items;
    return products.isEmpty?Center(child: Text('there is no products'),): GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount:products.length ,
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 3/2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10
    ), itemBuilder: (BuildContext context, int index) {
        return ChangeNotifierProvider.value(value: products[index],child: ProductItem(),);

    }, );
  }
}
