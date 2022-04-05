import 'package:flutter/material.dart';
import 'common.dart' show MyColors;
import 'tab_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "闪动滑雪",
      theme: ThemeData(
        // 暂时只有一种主题
        brightness: Brightness.light,
        primaryColor: MyColors.light,

        // fontFamily: ""
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      home: TabNavigator(),
    );
  }
}

