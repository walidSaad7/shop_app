import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/Screens/edit_product_screen.dart';
import 'package:shop1/provider/products.dart';

class UserProductItem extends StatelessWidget {
final String id;
final String title;
final String imageUrl;
UserProductItem(this.id,this.title,this.imageUrl);

  Widget build(BuildContext context) {
  final scaffold=ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      trailing: Container(
        width: 100,
          child: Row(
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
              }, icon: Icon(Icons.edit)),
              IconButton(onPressed: ()async{
                try{
                  await Provider.of<Products>(context,listen: false).deleteProduct(id);
                  
                }catch(error){
                  scaffold.showSnackBar(SnackBar(content:
                  Text('Deleting failed',textAlign: TextAlign.center,)));
                  
                  
                }


                
              },
                  color: Theme.of(context).errorColor,
                  icon: Icon(Icons.delete)),

            ],
          ),
      ),
    );
  }
}
