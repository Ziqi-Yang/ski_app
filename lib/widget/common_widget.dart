import 'package:flutter/material.dart';

class CommonWidget{
  static gestureWrap({required BuildContext context, required Widget pageChild, required Widget child}){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => pageChild));
      },
      child: child,
    );
  }
}
