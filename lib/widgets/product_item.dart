import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/Screens/product_details_screen.dart';
import 'package:shop1/provider/auth.dart';
import 'package:shop1/provider/cart.dart';
import 'package:shop1/provider/product.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen: false);
    final cart=Provider.of<Cart>(context,listen: false);
    final authData=Provider.of<Auth>(context,listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: ()=>Navigator.pushNamed(context, ProductDetailsScreen.routeName,arguments: product.id),
          child: Hero(tag:product.id! , child: FadeInImage(placeholder:
          AssetImage('assets/images/product-placeholder.png'),
          image: NetworkImage(product.imageUrl),
            fit: BoxFit.cover,

          ),
          ),

        ),
        footer: GridTileBar(
          backgroundColor: Colors.black,
          leading: Consumer<Product>(
            builder: (buildContext,product,_)=>IconButton(icon: Icon(product.isFavorite?Icons.favorite:
            Icons.favorite_border),
            color: Theme.of(context).primaryColor,
            onPressed: (){
              product.toggleFavoriteStatus(authData.token.toString(), authData.userId.toString());
            },),
          ),
          title:Text(product.title,textAlign: TextAlign.center,) ,
          trailing:IconButton(icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).primaryColor,

            onPressed: (){
            cart.addItem(product.id!, product.price, product.title);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Add to Cart'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: ()=>cart.removeSinleItem(product.id!),
                  ),)
                );

          },) ,
        ),
      ),
    );
  }
}
