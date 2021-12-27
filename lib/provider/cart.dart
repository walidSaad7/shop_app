import 'package:flutter/material.dart';

class CartItem{
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      { required this.id,
        required this.title,
        required this.quantity,
        required this.price,
       });
}

class Cart extends ChangeNotifier{
  Map<String, CartItem>_items={};
  Map<String,CartItem>get item{
    return{
      ..._items
    };

  }
  int get ItemCount {
    return _items.length;
  }
  double get TotalAmount{
    var total=0.0;
    _items.forEach((key, CartItem) {
      total+=CartItem.price * CartItem.quantity;

    });
    return total;
  }
  void addItem(String ProductId,double price,String title){
    if(_items.containsKey(ProductId)){
      _items.update(ProductId, (existingCartItem) => CartItem
        (id: existingCartItem.id,
        title: existingCartItem.title
          , quantity: existingCartItem.quantity+1,
          price: existingCartItem.price));

    }else{
      _items.putIfAbsent(ProductId, () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price));

    }
    notifyListeners();
  }
  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }
  void clear(){
    _items={

    };
    notifyListeners();
  }
  void removeSinleItem(String productId){
    if(!_items.containsKey(productId)){
      return;

    }
    if(_items[productId]!.quantity>1){
      _items.update(productId, (existingCartItem) => CartItem
        (id: existingCartItem.id,
          title: existingCartItem.title
          , quantity: existingCartItem.quantity-1,
          price: existingCartItem.price));

    }else{
      _items.remove(productId);
    }
    notifyListeners();

  }

}