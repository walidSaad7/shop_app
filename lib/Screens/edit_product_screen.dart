import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop1/provider/product.dart';
import 'package:shop1/provider/products.dart';

class EditProductScreen extends StatefulWidget  {
  static const String routeName='editScreen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _priceFocusNode=FocusNode();
  final _desciptionFocusNode=FocusNode();
  final _imageUrlFocusNode=FocusNode();
  final _imageUrlControllar=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  var _editedProduct=Product(
      id: '',
      title: '',
      description: '',
      price: 0,
      imageUrl: 'imageUrl');
  var _initialValues={
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''

  };
  var _isLodsing=false;
  var _isInit=true;
  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_UpdateImageUrl);

    }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_isInit){

      final productId=ModalRoute.of(context)!.settings.arguments as String?;
      if(productId!=null){
        _editedProduct=Provider.of<Products>(context,listen: false).findById(productId);
        _initialValues={
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': ''

        };
        _imageUrlControllar.text=_editedProduct.imageUrl;
      }
    }
    _isInit=false;
  }
    @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_UpdateImageUrl);
    _priceFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlControllar.dispose();
    _desciptionFocusNode.dispose();
  }

  void _UpdateImageUrl() {
    if(_imageUrlFocusNode.hasFocus){
      if(!_imageUrlControllar.text.startsWith('http')
          &&!_imageUrlControllar.text.startsWith('https')
          &&(!_imageUrlControllar.text.endsWith('.png'))
              &&!_imageUrlControllar.text.endsWith('.jpg')&&
          !_imageUrlControllar.text.endsWith('jpeg')
      ){
        return;
      }
    }
    setState(() {

    });
  }
  Future<void>_saveForm()async{
    final isValid=_formKey.currentState!.validate();
    if(!isValid){
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLodsing=true;
    });
    if(_editedProduct.id!=null){
      await Provider.of<Products>(context,listen: false)
          .updateProduct(_editedProduct, _editedProduct.id!);

    }else{
      try{
        await Provider.of<Products>(context,listen: false)
            .addProduct(_editedProduct);

      }catch(e){
        await showDialog(context: context, builder: (buildContext)=>AlertDialog(
          title: Text('An error occurred'),
          content: Text('Something went wrong'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('ok'))
          ],

        ));


      }


    }
    setState(() {
      _isLodsing=false;

    });
    Navigator.of(context).pop();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ],
      ),
      body: _isLodsing?Center(child: CircularProgressIndicator(),):
      Padding(padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
      child: ListView(
        children: [
          TextFormField(

            initialValue:_initialValues['title'].toString(),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_priceFocusNode);
            },
            validator: (value){
              if(value!.isEmpty){
                return 'please Provide a value';
              }else{
                return null;
              }

            },
            onSaved: (value){
              _editedProduct=Product(id: _editedProduct.id,
                  title: value.toString(),
                  description: _editedProduct.description,
                  price: _editedProduct.price
                  , imageUrl: _editedProduct.imageUrl,
              isFavorite: _editedProduct.isFavorite);
            },
            decoration: InputDecoration(
              labelText: 'Title',

            ),

          ),
          TextFormField(

            focusNode: _priceFocusNode,
            keyboardType: TextInputType.phone,
            initialValue:_initialValues['price'].toString(),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_desciptionFocusNode);
            },
            validator: (value){
              if(value!.isEmpty){
                return 'please inter Price';
              }if(double.tryParse(value)!<=0){
                return 'please inter a number greater than zero';


              }if(double.tryParse(value)==null){
                return 'please inter a valid Price';


              }

                return null;


            },
            onSaved: (value){
              _editedProduct=Product(id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: _editedProduct.description,
                  price: _editedProduct.price
                  , imageUrl: _editedProduct.imageUrl,
              isFavorite: _editedProduct.isFavorite);
            },
            decoration: InputDecoration(
              labelText: 'price',

            ),
          ),
          TextFormField(
            initialValue:_initialValues['description']as String,
            textInputAction: TextInputAction.next,

            maxLines: 3,
            keyboardType: TextInputType.multiline,

            validator: (value){
              if(value!.isEmpty){
                return 'please inter description';
              }if(value.length<10){
                return 'should be at least 10 characters long';


              }

              return null;


            },
            focusNode: _desciptionFocusNode,
            onSaved: (value){
              _editedProduct=Product(id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: value.toString(),
                  price: _editedProduct.price
                  , imageUrl: _editedProduct.imageUrl,
                  isFavorite: _editedProduct.isFavorite);
            },
            decoration: InputDecoration(
              labelText: 'description',

            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 8,right: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.grey)
                ),
                child: _imageUrlControllar.text.isEmpty?Text('enter url'):FittedBox(
                  child: Image.network(_imageUrlControllar.text,fit: BoxFit.cover,),
                ),
              ),
              Expanded(child:
              TextFormField(

                controller: _imageUrlControllar,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.url,


                validator: (value){
                  if(value!.isEmpty){
                    return 'please enter a image url';
                  }if(!value.startsWith('http')&&!value.startsWith('https')){
                    return 'please enter a valid url';


                  }if(!value.endsWith('png')&&!value.endsWith('jpg')&&value.endsWith('jpeg')){
                    return 'please enter a valid url';

                  }

                  return null;


                },
                focusNode:_imageUrlFocusNode,
                onSaved: (value){
                  _editedProduct=Product(id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: _editedProduct.price
                      , imageUrl: value.toString(),
                      isFavorite: _editedProduct.isFavorite);
                },
                decoration: InputDecoration(
                  labelText: 'Image Url',

                ),
              ),

              )

            ],
          )
        ],
      ),)
        ,),
    );
  }

}
