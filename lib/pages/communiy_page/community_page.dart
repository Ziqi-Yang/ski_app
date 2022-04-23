import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ski_app/pages/communiy_page/Community_drawer.dart';
import 'package:ski_app/model/community/tweet.dart';
import 'package:ski_app/dao/community/tweets_dao.dart';
import 'package:ski_app/pages/communiy_page/tweet_widget.dart';


class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}


class _CommunityPageState extends State<CommunityPage>
    with AutomaticKeepAliveClientMixin {

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  List<Tweet> _tweets = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    TweetDao.fetch().then((value){
      setState(() {
        _tweets.addAll(value);
      });
    }).catchError((e){
      print(e);
    });
  }

  void scrollTo(int index) => _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
      alignment: 0.5); // 跳转后元素在中间显示

  @override
  Widget build(BuildContext context) {
    super.build(context); // 缓存页面必须

    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _statusBarHeight = MediaQuery.of(context).padding.top;
    const double _sliverAppBarHeight = 56.0;
    const double _bottomNavigationBarHeight = 58.0;

    return Scaffold(
      body:
          NestedScrollView(
              floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return <Widget>[
                _customAppBar(context, innerBoxIsScrolled)
              ];
            },
            // body: _MessagesList(context, Colors.blue),
            body: _MessagesList(context)
          ),
      // CustomScrollView(
      //   slivers: [
      //     _customAppBar(context),
      //     SliverToBoxAdapter(
      //         child: SizedBox(
      //             height: _screenHeight - (_statusBarHeight + _sliverAppBarHeight + _bottomNavigationBarHeight),
      //             child: _MessagesList(context, Colors.blue)
      //         )
      //     )
      //   ],
      // ),
      drawer: CommunityDrawer(),
    );
  }

  _customAppBar(BuildContext context, bool innerBoxIsScrolled) {
    return SliverAppBar(
      floating: true,
      leading: Builder(
        builder: (BuildContext context){
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(200)),
                child: Image.network(
                  "https://img3.sycdn.imooc.com/61c58ca10001966a09600960-140-140.jpg", // FIXME
                ),
              ),
            ),
          );
        }
      ),
      // FIXME change
      title: const Icon(
        Icons.downhill_skiing,
        color: Colors.blue,
        size: 30,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      forceElevated: innerBoxIsScrolled,
      elevation: .6,
    );
  }

  _MessagesList(BuildContext context) {
    return ScrollablePositionedList.builder(
        // itemPositionsListener: ,
        itemScrollController: _itemScrollController,
        itemPositionsListener: _itemPositionsListener,
        reverse: true,
        itemCount: _tweets.length,
        itemBuilder: (BuildContext context, int index){
          return TweetWidget(tweet: _tweets[index]);
        }
    );
  }
}
