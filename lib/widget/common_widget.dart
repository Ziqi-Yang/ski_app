import 'package:flutter/material.dart';
import 'package:route_animation_helper/route_animation_helper.dart';

class CommonWidget {
  static ontapSlideRoute({required BuildContext context,
    required Widget pageChild, required Widget child, AnimType animTape = AnimType.slideStart}){
    return GestureDetector(
      onTap: (){
        onTapSlide(context: context, pageChild: pageChild, animTape: animTape);
      },
      child: child,
    );
  }

}

onTapSlide({required BuildContext context,
  required Widget pageChild, AnimType animTape = AnimType.slideStart}){
  Navigator.push(context, RouteAnimationHelper.createRoute(buildContext: context,
      destination: pageChild, animType: animTape
  ));
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


requestPermission(BuildContext context, String permissionName, String explanation,
    void Function() func){
  showDialog(context: context,
      builder: (context) => AlertDialog(
        title: const Text("权限申请", style: TextStyle(color: Colors.redAccent,
            fontSize: 22, fontWeight: FontWeight.bold
        ),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(permissionName, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
            Text(explanation),
          ],
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("取消")),
          TextButton(onPressed: (){
            func();
          }, child: const Text("允许"))
        ],
      )
  );
}

