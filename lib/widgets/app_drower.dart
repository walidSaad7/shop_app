import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/Screens/order_screen.dart';
import 'package:shop1/Screens/proudect_screen.dart';
import 'package:shop1/Screens/user_product_screen.dart';
import 'package:shop1/provider/auth.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Shop'),
          ),
          Divider(),
          ListTile(
            leading:Icon(Icons.shop) ,
            title: Text('Shop'),
            onTap: ()=>Navigator.pushReplacementNamed(context, ProductScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading:Icon(Icons.payment) ,
            title: Text('orders'),
            onTap: ()=>Navigator.pushReplacementNamed(context, OrderScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading:Icon(Icons.edit) ,
            title: Text('Manage product'),
            onTap: ()=>Navigator.pushReplacementNamed(context, UserProductScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading:Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: (){
              Navigator.pop(context);
              Provider.of<Auth>(context,listen: false).Logout();
            }
          ),
        ],
      ),
    );
  }
}
