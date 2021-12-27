import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/Screens/edit_product_screen.dart';
import 'package:shop1/provider/products.dart';
import 'package:shop1/widgets/app_drower.dart';
import 'package:shop1/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget  {
static const String routeName='userScreen';
Future<void>_refreshProduct(BuildContext context)async{
   Provider.of<Products>(context,listen: false).FetchAndSetProducts(true);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context,EditProductScreen.routeName);
          }, icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (context, snapshot) => snapshot.connectionState==ConnectionState.waiting?
        Center(child: CircularProgressIndicator(),):RefreshIndicator(child: Consumer<Products>(
          builder: (ctx,productData,_)=>Padding(padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: productData.items.length,
                itemBuilder: (buildContext,index){
                return Column(
                  children: [
                    UserProductItem(productData.items[index].id!,productData.items[index].title,
                        productData.items[index].imageUrl),
                    Divider()
                  ],
                );


                }),
          ),
        ),
            onRefresh: ()=>_refreshProduct(context)),
      ),
    );
  }
}
