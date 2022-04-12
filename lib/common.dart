import 'package:flutter/material.dart';

class Api{
  static const home = "http://note.zps1.cn:3000/";

  // setting
  static const settingPrefix = home + "setting/";
  static const settingNullUser = settingPrefix + "null";

  static const historyGeneral = home + "history/general/";
  static const historyGeneralNullUser = historyGeneral + "null/1";

  static const fetchLatestData = home + "history/latest/";

  static const singleData = home + "data/";
}

class MyColors {
  // 数字类型或Color类型 如果有其他文件用这个的话都不会在gutter上显示颜色
  static const background = Color(0xffeceff1); // lightLightBlueGrey

  static const blueAccent = Color(0xff7196C3);
}
