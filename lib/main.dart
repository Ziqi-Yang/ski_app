import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart'; // 为syncfushion的图表和日历添加中文支持
import 'tab_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('zh'),
      ],
      title: "闪动滑雪",
      theme: ThemeData(
        // 暂时只有一种主题
        brightness: Brightness.light,
        primaryColor: Colors.white,

        // fontFamily: ""
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          headline2: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),

          bodyText1: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      home: TabNavigator(),
    );
  }
}

