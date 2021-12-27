import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/Screens/cart_screen.dart';
import 'package:shop1/provider/auth.dart';
import 'package:shop1/provider/cart.dart';
import 'package:shop1/provider/products.dart';
import 'package:shop1/widgets/app_drower.dart';
import 'package:shop1/widgets/badge.dart';
import 'package:shop1/widgets/products_grid.dart';


enum FilterOption{
  Favorites,All
}

class ProductScreen extends StatefulWidget {
static const String routeName='productScreen';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var _isLoading=false;
  var _showOnlyFavorites=false;
  var _isInit=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading=true;
    Provider.of<Products>(context,listen: false).FetchAndSetProducts().then((_) =>
        setState(()=>_isLoading=false)).catchError((error)=>setState(()=>
    _isLoading=false));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        actions: [
          PopupMenuButton(
            onSelected:(FilterOption SelectedVal){
              setState(() {
                if (SelectedVal==FilterOption.Favorites){
                  _showOnlyFavorites=true;
                }else{
                  _showOnlyFavorites=false;
                }
              });
            },
              icon: Icon(Icons.more_vert),
              itemBuilder: (buildContext)=>[
                PopupMenuItem(child: Text('Only Favorite'),value: FilterOption.Favorites,),
                PopupMenuItem(child: Text('Show All'),value: FilterOption.All,),
        ],

    ),
          Consumer<Cart>(child:  IconButton(icon:Icon(Icons.shopping_cart), onPressed: () {
             Navigator.pushNamed(context, CartScreen.routeName);
    },),
            builder: (buildContext,Cart,ch)=>Badge(child: ch!,
              value: Cart.ItemCount.toString(), col: Colors.red,
                )
          )
     ]
      ),
      drawer: AppDrawer(),
      body:_isLoading?Center(child: CircularProgressIndicator(),):ProductsGrid(_showOnlyFavorites),


    );
  }
}
