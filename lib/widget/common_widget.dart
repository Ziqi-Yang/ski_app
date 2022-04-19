import 'package:flutter/material.dart';
import 'package:route_animation_helper/route_animation_helper.dart';

class CommonWidget {
  static ontapSlideRoute({required BuildContext context,
    required Widget pageChild, required Widget child, AnimType animTape = AnimType.slideStart}){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, RouteAnimationHelper.createRoute(buildContext: context,
            destination: pageChild, animType: animTape
        ));
      },
      child: child,
    );
  }
}
