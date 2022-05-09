import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:ski_app/model/community/media.dart';
import 'package:ski_app/model/community/tweet.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ski_app/dao/community/tweets_dao.dart';
import 'package:ski_app/pages/communiy_page/media_area.dart';
import 'package:ski_app/pages/communiy_page/tweet_widget.dart';

class TweetDetails extends StatefulWidget {
  final Tweet tweet;

  const TweetDetails({Key? key, required this.tweet}) : super(key: key);

  @override
  State<TweetDetails> createState() => _TweetDetailsState();
}

class _TweetDetailsState extends State<TweetDetails> {
  List<Tweet> _replys = [];
  bool _hasFetched = false;

  @override
  void initState() {
    super.initState();
    ReplyDao.fetch().then((value) {
      setState(() {
        _replys.addAll(value);
        _hasFetched = true;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 这里还是不用SliverAppBar吧，毕竟twitter里也没用
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: .3,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "   社区",
          style: TextStyle(fontSize: 23),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _replys.length + 1, // 开始还有一个 _tweet
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      // _tweet
                      if (_replys.isEmpty && _hasFetched == false){
                        return Column(
                          children: [
                            _tweet(context),
                            const CircularProgressIndicator(
                            )
                          ],
                        );
                      } else {
                        return _tweet(context);
                      }
                    } else if (index == 1) {
                      return TweetWidget(
                        tweet: _replys[index - 1],
                        showTopBorder: false,
                      );
                    } else {
                      return TweetWidget(tweet: _replys[index - 1]);
                    }
                  }),
            ),
            _bottomTextfield(context)
          ],
        ),
      ),
    );
  }

  _tweet(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.network(
                    widget.tweet.avatar,
                    width: 65,
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tweet.username,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                    Text(
                      "@${widget.tweet.userId}",
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Html(
                  data: widget.tweet.message,
                  style: {"body": Style(fontSize: const FontSize(20))},
                ),
                MediaArea(heroTag: "details_page_" + widget.tweet.id, medias: widget.tweet.medias), // messageId
                const Divider(),
                RichText(
                    text: TextSpan(
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        children: <TextSpan>[
                      TextSpan(
                          text: " ${widget.tweet.retweet}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: " 转发"),
                      TextSpan(
                          text: " ${widget.tweet.fav}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: " 喜欢"),
                    ])),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _button(
                        context: context, // reply
                        svgIconPath:
                            "assets/images/community_page/chatbubble-ellipses-outline.svg",
                      ),
                      _button(
                        context: context, // retweet
                        svgIconPath: _rtIconPath,
                      ),
                      LikeButton(
                        isLiked: widget.tweet.hasFav,
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            isLiked ? Icons.favorite: Icons.favorite_border,
                            color: isLiked ? Colors.redAccent: Colors.black54,
                            size: 24,
                          );
                        },
                      ),
                      _button(
                        context: context, // share
                        svgIconPath:
                            "assets/images/community_page/share-social-outline.svg",
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ))
      ],
    );
  }

  _button({required BuildContext context, required String svgIconPath}) {
    return SvgPicture.asset(
      svgIconPath,
      height: 24,
      color: Colors.black54,
    );
  }

  get _favIconPath {
    return widget.tweet.hasFav
        ? "assets/images/community_page/heart_colored.svg"
        : "assets/images/community_page/heart-outline.svg";
  }

  get _rtIconPath {
    return widget.tweet.hasRt
        ? "assets/images/community_page/retweet_colored.svg"
        : "assets/images/community_page/retweet.svg";
  }

  _bottomTextfield(BuildContext context) {
    return const SizedBox(
        width: double.infinity,
        height: 50.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
          child: TextField(
            decoration: InputDecoration(
                hintText: "发布回复消息",
                suffixIcon: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.blue,
                )),
          ),
        ));
  }
}
