
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/provider/orders.dart';
import 'package:shop1/widgets/cart_item.dart';
import '../provider/cart.dart'show Cart;

class CartScreen extends StatelessWidget {
static const String routeName='cartScreen';
  @override
  Widget build(BuildContext context) {
    final  cart=Provider.of<Cart>(context,);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total',style: TextStyle(
                    fontSize: 20
                  ),),
                  Spacer(),
                  Chip(label: Text('\$${cart.TotalAmount.toStringAsFixed(2)}'),
                  backgroundColor: Theme.of(context).primaryColor,),
                  OrderButton(cart: cart,)


                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(child: ListView.builder(
            itemCount: cart.item.length,
              itemBuilder: (context,inedx)=>CartItem(id: cart.item.values.toList()[inedx].id,
                  productId: cart.item.keys.toList()[inedx], quantity: cart.item.values.toList()[inedx].quantity,
                  price: cart.item.values.toList()[inedx].price, title: cart.item.values.toList()[inedx].title)))
        ],
      ),

    );
  }
}

class OrderButton extends StatefulWidget {
final Cart cart;

  const OrderButton( {required this.cart}) ;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoding=false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoding?CircularProgressIndicator():
      Text('ORDER NOW'),
      onPressed:(widget.cart.TotalAmount<=0||_isLoding)?null: (){
      setState(() {
        _isLoding=true;
      });
       Provider.of<Orders>(context,listen: false).addOrders(widget.cart.item.values.toList(),
          widget.cart.TotalAmount);

      setState(() {
        _isLoding=false;
      });
      widget.cart.clear();

    },

    );
  }
}


