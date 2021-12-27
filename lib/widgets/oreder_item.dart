import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop1/provider/orders.dart';

class OrderWidget extends StatelessWidget {
  final OrderItem order;
  OrderWidget( this.order);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8),
    child: ExpansionTile(
      title: Text('\$${order.amount}'),
      subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime)),
      children: order.Products.map((prod) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(prod.title,style: TextStyle(fontSize: 18,
          fontWeight: FontWeight.bold),),
          Text('${prod.quantity}x \$${prod.price}',style: TextStyle(fontSize: 18,
          color: Colors.grey),),
        ],
      )).toList(),
    )
      ,);
  }
}
