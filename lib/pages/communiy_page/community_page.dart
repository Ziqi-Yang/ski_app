import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ski_app/pages/communiy_page/Community_drawer.dart';
import 'package:ski_app/model/community/tweet.dart';
import 'package:ski_app/dao/community/tweets_dao.dart';
import 'package:ski_app/pages/communiy_page/tweet_widget.dart';
import 'package:ski_app/widget/animated_shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with AutomaticKeepAliveClientMixin {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loadDone = false;
  bool _loadError = false;
  List<Tweet> _tweets = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    TweetDao.fetch().then((value) {
      setState(() {
        _tweets.addAll(value);
        _loadDone = true;
      });
    }).catchError((e) {
      setState(() {
        _loadError = true;
      });
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

    // final double _screenHeight = MediaQuery.of(context).size.height;
    // final double _statusBarHeight = MediaQuery.of(context).padding.top;
    // const double _sliverAppBarHeight = 56.0;
    // const double _bottomNavigationBarHeight = 58.0;

    return Scaffold(
      key: _scaffoldKey,
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[_customAppBar(context, innerBoxIsScrolled)];
          },
          // body: _MessagesList(context, Colors.blue),
          body: _loadDone ? _MessagesList(context) : _shimmerList,
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
    Widget avatar = _loadDone
        ? GestureDetector(
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
          )
        : Padding(
            padding: const EdgeInsets.all(12),
            child: AnimatedShimmer.round(size: 32));

    return SliverAppBar(
      floating: true,
      leading: Builder(builder: (BuildContext context) {
        return avatar;
      }),
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
        itemBuilder: (BuildContext context, int index) {
          return TweetWidget(tweet: _tweets[index]);
        });
  }


  Widget get _shimmerList {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
                  child: AnimatedShimmer.round(size: 60)),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 14, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedShimmer(height: 20, width: 100, borderRadius: BorderRadius.circular(12),),
                            const SizedBox(width: 10,),
                            AnimatedShimmer(height: 17, width: 80, borderRadius: BorderRadius.circular(12),)
                          ],
                        ),
                        const SizedBox(height: 7,),
                        AnimatedShimmer(height: 14, borderRadius: BorderRadius.circular(12),),
                        const SizedBox(height: 7,),
                        AnimatedShimmer(height: 14, borderRadius: BorderRadius.circular(12),),
                        const SizedBox(height: 7,),
                        AnimatedShimmer(height: 14, borderRadius: BorderRadius.circular(12),),
                        const SizedBox(height: 7,),
                        AnimatedShimmer(height: 14, borderRadius: BorderRadius.circular(12),),
                        const SizedBox(height: 7,),
                        AnimatedShimmer(height: 14, width: 200, borderRadius: BorderRadius.circular(12),),
                        Padding(padding: const EdgeInsets.only(top: 8),
                            child: AnimatedShimmer(height: 200,
                              borderRadius: BorderRadius.circular(12),
                            )
                        )
                      ],
                    ),
              ))
            ],
          );
        });
  }
}
