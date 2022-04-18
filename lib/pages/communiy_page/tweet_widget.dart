import 'package:flutter/material.dart';
import 'package:ski_app/model/community/tweet.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TweetWidget extends StatelessWidget {
  final Tweet tweet;

  const TweetWidget({Key? key, required this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.network(
              tweet.avatar,
              width: 60,
            ),
          ),
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tweet.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("@${tweet.userId}"))
                      ],
                    ),
                    Html(data: tweet.message,),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        child: Image.network(
                          // FIXME 只实现了加载第一个图片,未能加载则加载百度(哭)
                          tweet.medias.pictures != null
                              ? tweet.medias.pictures![0]
                              : "https://wx2.sinaimg.cn/orj360/00337rRAly1gthleo3pyrj60j60j6aan02.jpg",
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          const Expanded(child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(FontAwesomeIcons.comment),
                          )),
                          Expanded(
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.retweet), // FIXME 我看还是不要用font_awesome_flutter了，直接用svg
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    child: Text(tweet.retweet.toString()),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    )

                  ],
                ))
        )
      ],
    );
  }
}
