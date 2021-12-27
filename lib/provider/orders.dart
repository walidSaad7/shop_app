import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'cart.dart';


class OrderItem{
  final String id;
  final double amount;
  final List<CartItem>Products;
  final DateTime dateTime;

  OrderItem(
      { required this.id,
        required this.amount,
        required this.dateTime,
        required this.Products
      });
}


class Orders extends ChangeNotifier{
  List<OrderItem>orders=[];
  String? authToken;
  String? userId;
  getData(String authToken,String UserId,List<OrderItem>Orders){
    authToken=authToken;
    userId=UserId;
    orders=Orders;
    notifyListeners();

  }
  List<OrderItem>get items{
    return[...orders];
  }
  Future<void>FetchAndSetOrders()async{
    final url=
        'https://shop-bf773-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    try{
      final res=await http.get(Uri.parse(url));
      final extractedData=json.decode(res.body)as Map<String,dynamic>;
      if(extractedData==null){
        return;
      }

      final List<OrderItem>loadedOrders=[];
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']) ,
            Products: orderData(['Products']as List<dynamic>).map((item)=>(CartItem(id: item['id'],
  title: item['title'],
  quantity: item['quntity'],
  price: item['price']
  ))).toList(),

        ));
        orders=loadedOrders.reversed.toList();
        notifyListeners();
      });

    }catch(e){

      throw e;

    }


  }
  Future<void>addOrders(List<CartItem> CartProduct,double total)async{
    final url='https://shop-bf773-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    try{
      final timestamp=DateTime.now();
      final res=await http.post(Uri.parse(url),body: json.encode({
        'amount':total,
        'dateTime':timestamp.toIso8601String(),
        'products':CartProduct.map((cp) => {
          'id':cp.id,
          'title':cp.title,
          'quantity':cp.quantity,
          'price':cp.price
         }).toList(),
      }));


      orders.insert(0, OrderItem(id: json.decode(res.body)['name'],
          amount: total,
          dateTime: timestamp,
          Products: CartProduct));
      notifyListeners();

    }catch(e){
      print(e);

    }


}
  }