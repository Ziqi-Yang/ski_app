import 'package:flutter/material.dart';
import 'package:ski_app/model/community/tweet.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TweetDetails extends StatefulWidget {
  final Tweet tweet;
  const TweetDetails({Key? key, required this.tweet}) : super(key: key);

  @override
  State<TweetDetails> createState() => _TweetDetailsState();
}

class _TweetDetailsState extends State<TweetDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 这里还是不用SliverAppBar吧，毕竟twitter里也没用
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: .3,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("   社区", style: TextStyle(fontSize: 23),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: _tweet(context)
              ),
            ),
            _bottomTextfield(context)
          ],
        ),
      ),
    );
  }

  _tweet(BuildContext context){
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
              const SizedBox(width: 18,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tweet.username,
                    style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                  Text("@${widget.tweet.userId}", style: const TextStyle(fontSize: 16),)
                ],
              ),
            ],
          )
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Html(data: widget.tweet.message,
                  style: {
                    "body": Style(
                      fontSize: const FontSize(20)
                    )
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: Image.network(
                      // FIXME 只实现了加载第一个图片,未能加载则加载百度(哭)
                      widget.tweet.medias.pictures != null
                          ? widget.tweet.medias.pictures![0]
                          : "https://wx2.sinaimg.cn/orj360/00337rRAly1gthleo3pyrj60j60j6aan02.jpg",
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Divider(),
                RichText(text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: " ${widget.tweet.retweet}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: " 转发"),
                    TextSpan(text: " ${widget.tweet.fav}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: " 喜欢"),
                  ]
                )),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _button(context: context, // reply
                        svgIconPath: "assets/images/community_page/chatbubble-ellipses-outline.svg",),
                    _button(context: context, // retweet
                        svgIconPath: _rtIconPath,),
                    _button(context: context, // heart
                        svgIconPath: _favIconPath,),
                    _button(context: context, // share
                        svgIconPath: "assets/images/community_page/share-social-outline.svg",),
                  ],
                )
              ],
            ))
      ],
    );
  }


  _button({required BuildContext context, required String svgIconPath}){
      return SvgPicture.asset(
        svgIconPath,
        height: 24,
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

  _bottomTextfield(BuildContext context){
    return const SizedBox(
      width: double.infinity,
      height: 50.0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
        child:TextField(
          decoration: InputDecoration(hintText: "Tweet your response",
              suffixIcon: Icon(Icons.camera_alt_outlined,
                color: Colors.blue,
              )
          ),
        ),
      )
    );
  }

}
