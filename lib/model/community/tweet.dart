import 'media.dart';

class Tweet{
  final String username;
  final String userId;
  final String avatar;
  final String message;
  final Media medias;
  final int retweet;
  final int fav;
  final int replyNum;
  final bool verified;
  final bool hasRt;
  final bool hasFav;

  Tweet({required this.username, required this.userId, required this.avatar, required this.message, required this.medias,
      required this.retweet, required this.fav, required this.replyNum, required this.verified,
    required this.hasRt, required this.hasFav
  });
  
  factory Tweet.fromJson(Map<String, dynamic> json){
    return Tweet(
      username: json["username"],
      userId: json["userId"],
      avatar: json["avatar"],
      message: json["message"],
      medias: Media.fromJson(json["medias"]), // FIXME
      retweet: json["retweet"],
      fav: json["fav"],
      replyNum: json["replyNum"],
      verified: json["verified"],
      hasRt: json["hasRt"],
      hasFav: json["hasFav"],
    );
  }
}