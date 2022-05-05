import 'package:flutter/material.dart';

class Api{
  static const home = "http://note.zps1.cn:3000/";

  // setting
  static const settingPrefix = home + "setting/";
  static const settingNullUser = settingPrefix + "null";

  static const history = "http://124.220.39.234:8080/test"; // FIXME

  static const fetchLatestData = home + "history/latest/";

  static const singleData = home + "data/";

  static const community = home + "community/";
  static const communityTweets = community + "tweets/";
  static const messageReply = community + "reply/";

  static const shop = home + "shop/";
  static const shopIndex = shop + "index";

  static const latestVersion = home + "app/version/latest";

}

class MyColors {
  // 数字类型或Color类型 如果有其他文件用这个的话都不会在gutter上显示颜色
  static const background = Color(0xffeceff1); // lightLightBlueGrey

  static const blueAccent = Color(0xff7196C3);
}
