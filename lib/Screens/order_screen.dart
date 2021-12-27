import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/provider/orders.dart';
import 'package:shop1/widgets/app_drower.dart';
import 'package:shop1/widgets/oreder_item.dart';

class OrderScreen extends StatelessWidget  {
static const String routeName='orderScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
    future: Provider.of<Orders>(context,listen: false).FetchAndSetOrders(),
    builder: (context, snapshot) =>
      snapshot.connectionState==ConnectionState.waiting?
        Center(child: CircularProgressIndicator()):snapshot.error!=null?
       Center(child: Text(snapshot.error.toString())):Consumer<Orders>(

      builder: (ctx,orderData,child)=>ListView.builder(
    itemCount: orderData.orders.length,
    itemBuilder: (buildContext,index)=>OrderWidget(orderData.orders[index])
    )
    )
    ));


      }



}

