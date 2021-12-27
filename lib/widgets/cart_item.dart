import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/Screens/edit_product_screen.dart';
import 'package:shop1/provider/cart.dart';

class CartItem extends StatelessWidget {
final String id;
final String productId;
final int quantity;
final double price;
final String title;

  const CartItem({required this.id, required this.productId,
    required this.quantity,required this.price, required this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
        confirmDismiss: (direction){
        return showDialog(context: context, builder: (buildContext)=>AlertDialog(
          title: Text('Are you sure'),
          content: Text('Do you want to remove from cart?'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('No')),
            TextButton(onPressed: (){
              Navigator.of(context).pop(true);
            }, child: Text('Yes'))
          ],
        )
        );

    },
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete,
        color: Colors.white,
        size: 40,),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
        padding: EdgeInsets.only(right: 20),
      ),
        onDismissed: (diraction){
        Provider.of<Cart>(context,listen: false).removeItem(productId);
        },
        key: ValueKey(id), child: Card(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          title: Text(title),
          subtitle: Text('Total\$ ${price*quantity}'),
          trailing: Text('$quantity x'),
          leading: CircleAvatar(child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(child: Text('\$ $price'),),
          ),),
        ),
      ),
    ));
  }
}
