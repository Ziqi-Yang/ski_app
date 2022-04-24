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

funcNotSupportDialog(BuildContext context){
  showDialog(context: context,
      builder: (context) => AlertDialog(
        title: const Text("错误", style: TextStyle(color: Colors.redAccent,
            fontSize: 22, fontWeight: FontWeight.bold
        ),),
        content: const Text("该功能暂未实现"),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("关闭"))
        ],
      )
  );
}
