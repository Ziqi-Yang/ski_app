import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ski_app/model/community/tweet.dart';
import 'package:ski_app/pages/communiy_page/media_area.dart';
import 'package:ski_app/pages/communiy_page/tweet_details.dart';
import 'package:ski_app/widget/animated_shimmer.dart';
import 'package:ski_app/widget/common_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TweetWidget extends StatefulWidget {
  final Tweet tweet;
  final bool showTopBorder;

  const TweetWidget({Key? key, required this.tweet, this.showTopBorder = true})
      : super(key: key);

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
                  top: showTopBorder
                      ? BorderSide(color: Colors.grey.shade400, width: 0.5)
                      : BorderSide.none)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: CachedNetworkImage(
                    imageUrl: tweet.avatar,
                    width: 60,
                    placeholder: (BuildContext context, String url){
                      return AnimatedShimmer.round(
                        size: 60,
                      );
                    },
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
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "@${tweet.userId}",
                                  style: const TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
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
                          MediaArea(heroTag: tweet.id, medias: tweet.medias),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                _button(
                                    context: context, // reply
                                    svgIconPath:
                                        "assets/images/community_page/chatbubble-ellipses-outline.svg",
                                    num: tweet.replyNum),
                                _button(
                                    context: context, // retweet
                                    svgIconPath: _rtIconPath,
                                    num: tweet.retweet),
                                _button(
                                    context: context, // heart
                                    svgIconPath: _favIconPath,
                                    num: tweet.fav),
                                _button(
                                    context: context, // share
                                    svgIconPath:
                                        "assets/images/community_page/share-social-outline.svg",
                                    num: null),
                              ],
                            ),
                          )
                        ],
                      )))
            ],
          )),
    );
  }

  _button(
      {required BuildContext context,
      required String svgIconPath,
      required int? num}) {
    if (num != null) {
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
      return Expanded(
        child: Align(
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
