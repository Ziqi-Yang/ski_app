import 'package:flutter/material.dart';
import 'package:ski_app/model/community/tweet.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ski_app/pages/communiy_page/tweet_details.dart';
import 'package:ski_app/widget/common_widget.dart';

class TweetWidget extends StatelessWidget {
  final Tweet tweet;

  const TweetWidget({Key? key, required this.tweet}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CommonWidget.ontapSlideRoute(
      context: context,
      pageChild: TweetDetails(tweet: tweet),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5)
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                              _button(context: context, // reply
                                  svgIconPath: "assets/images/community_page/chatbubble-ellipses-outline.svg",
                                  num: tweet.replyNum),
                              _button(context: context, // retweet
                                  svgIconPath: _rtIconPath,
                                  num: tweet.retweet),
                              _button(context: context, // heart
                                  svgIconPath: _favIconPath,
                                  num: tweet.fav),
                              _button(context: context, // share
                                  svgIconPath: "assets/images/community_page/share-social-outline.svg",
                                  num: null),
                            ],
                          ),
                        )
                      ],
                    ))
            )
          ],
        )
      ),
    );
  }


  _button({required BuildContext context, required String svgIconPath, required int? num}){
    if (num != null){
      return Expanded(
        child: Row(
          children: [
            SvgPicture.asset(
              svgIconPath,
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$num"),
            )
          ],
        ),
      );
    } else {
      return Expanded(child: Align(
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(
            svgIconPath,
            height: 22,
          ),
        ),
      );
    }
  }

  get _favIconPath {
    return tweet.hasFav
        ? "assets/images/community_page/heart_colored.svg"
        : "assets/images/community_page/heart-outline.svg";
  }

  get _rtIconPath {
    return tweet.hasRt
        ? "assets/images/community_page/retweet_colored.svg"
        : "assets/images/community_page/retweet.svg";
  }

}
