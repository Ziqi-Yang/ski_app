import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ski_app/model/community/tweet.dart';
import 'package:ski_app/common.dart' show Api;

class TweetDao{
  static Future<List<Tweet>> fetch({String userId = "test"}) async {
    List<Tweet> resultList = [];
    var url = Uri.parse(Api.communityTweets + userId);

    final response = await http.get(url);
    if (response.statusCode == 200){
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      for (var element in result){
        resultList.add(Tweet.fromJson(element));
      }
      return resultList;
    } else {
      throw Exception("Failed to load setting page json.");
    }
  }
}

class ReplyDao{
  static Future<List<Tweet>> fetch({String messageId = "test"}) async {
    List<Tweet> resultList = [];
    var url = Uri.parse(Api.messageReply + messageId);

    final response = await http.get(url);
    if (response.statusCode == 200){
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      for (var element in result){
        resultList.add(Tweet.fromJson(element));
      }
      return resultList;
    } else {
      throw Exception("Failed to load setting page json.");
    }
  }
}
