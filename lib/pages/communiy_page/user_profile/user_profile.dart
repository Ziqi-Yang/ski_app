import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  PersistentHeader({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class UserProfile extends StatefulWidget {

  final bool isMyProfile;
  const UserProfile({Key? key, required this.isMyProfile}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final ScrollController _controller = ScrollController();
  bool blurAppBar = false;

  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      print(_controller.offset); //打印滚动位置
      if (_controller.offset > 12){
        setState((){
          blurAppBar = true;
        });
      } else {
        setState((){
          blurAppBar = false;
        });
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  Widget get  _customAppBar{

    return SliverAppBar(
      pinned: true,
      stretch: true,
      elevation: 0,
      forceElevated: false,
      leading: Container(), // 去除返回按钮
      // title: BackdropFilter(
      //   filter: ImageFilter.blur(sigmaX: blurAppBar? 1.0 : 0.0,sigmaY: blurAppBar? 1.0: 0.0),
      //   child: Container(
      //     color: Colors.transparent,
      //   ),
      // ),
      // backgroundColor: Colors.red, // FIXME 根据图片主色调来调
      expandedHeight: 130, // 根据个人简介字数啥的来
      flexibleSpace: SafeArea(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: FlexibleSpaceBar(
            // titlePadding: EdgeInsetsDirectional.only(),
            // FIXME 更改滑到一定程度时候才渐变(是不是有范围，如果height很大，应该不会马上渐变，估计源码写死了)
            collapseMode: CollapseMode.pin, // act like scroll
            stretchModes: const [
              StretchMode.zoomBackground,
              // StretchMode.blurBackground,
            ],
            background: CachedNetworkImage(
                      imageUrl: "http://wx4.sinaimg.cn/mw2000/6db352e9ly1gvwkufofgnj20ku0kutce.jpg",
              fit: BoxFit.cover,
                    ),
          ),
        ),
      ),
    );
  }

  Widget get _tabbar{
    return SliverPersistentHeader(
      pinned: true,
      delegate: PersistentHeader(
        child: Container(
          color: Colors.red,
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 暂时不加像twitter那样的动画效果, 只要完成UI部分即可
      body: NestedScrollView(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            _customAppBar,
            SliverToBoxAdapter(
              child: Container(
                height: 100,
                color: Colors.purple,
                child: Text("Hello"),
              ),
            ),
            _tabbar
          ];
        },
        body: Container(
          color: Colors.yellowAccent,
        ),
      ),
    );
  }
}
