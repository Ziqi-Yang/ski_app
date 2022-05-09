import 'package:flutter/material.dart';

class Devices extends StatelessWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/home_page/background.jpg",),
              opacity: .5,
              fit: BoxFit.cover
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text("App暂未支持蓝牙功能", style: TextStyle(fontSize: 25),),
            )
          ],
        ),
      ),
    );
  }
}
