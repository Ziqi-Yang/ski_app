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
  static const light = Color(0xffE3EEF8);
  static const lightGrey = Color(0xffD7DDEB);
  static const blueGrey = Color(0xffC8D6EA);
  static const lightBlue = Color(0xffC7E4FF);
  static const lightBlueAccent = Color(0xffA5BDE3);
  static const blueAccent = Color(0xff7196C3);
}
