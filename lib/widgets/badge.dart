
import 'package:flutter/material.dart';

class Badge extends StatelessWidget{
  final Widget child;
  final String value;
  final Color col;

  Badge({required this.value,required this.col,required this.child}) ;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(right: 8,
        top: 8,
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: col!=null? col:Theme.of(context).primaryColor
          ),
          child: Text(value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,

          ),),
          constraints: BoxConstraints(
            maxHeight: 16,
            minWidth: 16,
          ),

        ),

        )

      ],
    );

  }

}