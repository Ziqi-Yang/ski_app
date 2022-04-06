import 'package:flutter/material.dart';

class CommonWidget{
  static gestureWrap(BuildContext context, void Function()? onTapFunc, Widget child){
    return GestureDetector(
      onTap: onTapFunc,
      child: child,
    );
  }
}
