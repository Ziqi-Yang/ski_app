import 'package:flutter/material.dart';
import 'package:ski_app/model/community/tweet.dart';
import 'package:ski_app/pages/communiy_page/enlarge_widget.dart';
import 'package:ski_app/pages/communiy_page/tweet_details.dart';
import 'package:ski_app/widget/common_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TweetWidget extends StatefulWidget {
  final Tweet tweet;
  final bool showTopBorder;

  const TweetWidget({Key? key, required this.tweet, this.showTopBorder = true}) : super(key: key);

  @override
  State<TweetWidget> createState() => _TweetWidgetState();
}

class _TweetWidgetState extends State<TweetWidget> {

  @override
  Widget build(BuildContext context) {
    Tweet tweet = widget.tweet;
    bool showTopBorder = widget.showTopBorder;

    return CommonWidget.ontapSlideRoute(
      context: context,
      pageChild: TweetDetails(tweet: tweet),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: showTopBorder ? BorderSide(color: Colors.grey.shade400, width: 0.5) : BorderSide.none
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14,14,8,14),
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
                    padding: const EdgeInsets.fromLTRB(0, 8, 14, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              tweet.username,
                              style: const TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("@${tweet.userId}", style: const TextStyle(
                                  fontSize: 15
                                ), overflow: TextOverflow.ellipsis,),)
                          ],
                        ),
                        Html(
                          data: tweet.message,
                          style: {
                            "body": Style(
                                fontSize: const FontSize(16),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: EdgeInsets.zero,
                            ),
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: GestureDetector(
                            // FIXME 改为 Inkwell
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return EnlargeWidget(
                                  tag: tweet.userId,
                                    imageProvider: NetworkImage(
                                  tweet.medias.pictures != null
                                      ? tweet.medias.pictures![0]
                                      : "https://wx2.sinaimg.cn/orj360/00337rRAly1gthleo3pyrj60j60j6aan02.jpg",
                                ));
                              }));
                            },
                            child: Hero(
                              tag: tweet.userId,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                  child: CachedNetworkImage(
                                    imageUrl: tweet.medias.pictures != null
                                        ? tweet.medias.pictures![0]
                                        : "https://wx2.sinaimg.cn/orj360/00337rRAly1gthleo3pyrj60j60j6aan02.jpg",
                                    progressIndicatorBuilder: // TODO 更改加载动画
                                        (context, url, downloadProgress) => Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress)),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            )
                          )
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
    Tweet tweet = widget.tweet;
    return tweet.hasFav
        ? "assets/images/community_page/heart_colored.svg"
        : "assets/images/community_page/heart-outline.svg";
  }

  get _rtIconPath {
    Tweet tweet = widget.tweet;
    return tweet.hasRt
        ? "assets/images/community_page/retweet_colored.svg"
        : "assets/images/community_page/retweet.svg";
  }

}
