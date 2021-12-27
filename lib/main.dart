import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/Screens/cart_screen.dart';
import 'package:shop1/Screens/edit_product_screen.dart';
import 'package:shop1/Screens/order_screen.dart';
import 'package:shop1/Screens/product_details_screen.dart';
import 'package:shop1/Screens/proudect_screen.dart';
import 'package:shop1/Screens/splash_screen.dart';
import 'package:shop1/Screens/user_product_screen.dart';
import 'package:shop1/provider/auth.dart';
import 'package:shop1/provider/cart.dart';
import 'package:shop1/provider/orders.dart';
import 'package:shop1/provider/product.dart';
import 'package:shop1/provider/products.dart';
import 'Screens/auth_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth,Products?>(
            create: (_)=>Products(),
            update: (bulidContext,authValue,previousProduct)=>previousProduct!..getData(authValue.token??'',
                authValue.userId??'', previousProduct==null?null!: previousProduct.items)
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth,Orders?>(
            create: (_)=>Orders(),
            update: (bulidContext,authValue,previousOrders)=>previousOrders!..getData(authValue.token??'',
                authValue.userId??'', previousOrders==null?null!: previousOrders.items)
        ),

      ],
      child: Consumer<Auth>(
    builder: (buildContext,auth,_)=>MaterialApp(
      debugShowCheckedModeBanner: false,
            title: 'Shop app',
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: Colors.orange
              ),


              primaryColor: Colors.orange,
            ),
          home: auth.isAuth==true?ProductScreen():FutureBuilder(
          future: auth.tryAutoLogin(),
          builder: (BuildContext context,AsyncSnapshot snapshot)=>snapshot.connectionState==ConnectionState.waiting?
          SplashScreen():AuthScreen()),
            routes: {
              AuthScreen.routeName:(buildContext)=>AuthScreen(),
              CartScreen.routeName:(buildContext)=>CartScreen(),
              EditProductScreen.routeName:(buildContext)=>EditProductScreen(),
              OrderScreen.routeName:(buildContext)=>OrderScreen(),
              ProductDetailsScreen.routeName:(buildContext)=>ProductDetailsScreen(),
              ProductScreen.routeName:(buildContext)=>ProductScreen(),
              UserProductScreen.routeName:(buildContext)=>UserProductScreen(),
            },

      ),
    )


    );
  }
}


