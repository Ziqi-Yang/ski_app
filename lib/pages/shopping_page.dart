import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ski_app/common.dart' show MyColors;
import 'package:card_swiper/card_swiper.dart';
import 'package:ski_app/model/community/media.dart';
import 'package:ski_app/model/shop/shop_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ski_app/model/shop/shop_model.dart';
import 'package:ski_app/dao/shop_dao.dart';
import 'package:ski_app/widget/animated_shimmer.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage>
    with AutomaticKeepAliveClientMixin {
  ShopModel? _shopModel;

  final _swiperHeight = 160.0; // 不包括margin
  var rnd = Random();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    ShopDao.fetch().then((value) {
      setState(() {
        _shopModel = value;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    const _appbarHeight = 56.0;
    const _bottomNavHeight = 58.0;
    final _statusBarHeight = MediaQuery.of(context).padding.top;
    final _screenHeight = MediaQuery.of(context).size.height;
    final _itemListHeight = _screenHeight -
        _statusBarHeight -
        _appbarHeight -
        _swiperHeight -
        _bottomNavHeight -
        2 * 8.0; // 8.0 是 swiper的margin

    return Scaffold(
        // 对于MasonryGridView不能放在customscrollview中，放在NestedScrollView中效果似乎会出问题
        appBar: _appBar(context),
        body: SingleChildScrollView( // 防止shimmer溢出, 对原组件无影响
          child: Column(
            children: [
              _shopShimmer
              // _swiper(context),
              // Container(
              //   height: _itemListHeight,
              //   padding: const EdgeInsets.symmetric(horizontal: 14),
              //   color: MyColors.background,
              //   child: _itemLists(context),
              // )
            ],
          ))
        );
  }

  _appBar(BuildContext context) {
    return AppBar(
      title: const Text("雪具商店"),
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: .7,
    );
  }

  // FIXME 把swiper放在list里面
  _swiper(BuildContext context) {
    List<String> _swiperCovers = [
      "https://gw.alicdn.com/imgextra/i3/2212921989092/O1CN01BVEUtO2H2Bl6JnCBn_!!2212921989092.jpg_790x10000Q75.jpg_.webp",
      "https://gw.alicdn.com/imgextra/i2/2212921989092/O1CN01YFDOJh2H2Bl4g1ccJ_!!2212921989092.jpg_790x10000Q75.jpg_.webp",
      "https://gw.alicdn.com/imgextra/i2/2212921989092/O1CN01EcFW5w2H2BkvTxgY3_!!2212921989092.jpg_790x10000Q75.jpg_.webp"
    ]; // FIXME 默认图片需要改下

    List<String?> _links = [null, null, null]; // NOTICE 长度要和 _swiperCovers 长度一致

    if (_shopModel != null) {
      _swiperCovers = List<String>.from(_shopModel!.swiper.map((e) => e.cover));
      _links = List<String?>.from(_shopModel!.swiper.map((e) => e.link));
    }

    return Container(
        height: _swiperHeight,
        margin: const EdgeInsets.symmetric( vertical: 8),
        child: Swiper(
          itemCount: _swiperCovers.length,
          itemBuilder: (BuildContext context, int index) {
            return _links[index] != null
                ? GestureDetector(
                    onTap: () {
                      launch(_links[index]!);
                    },
                    child: _swiperImage(context, _swiperCovers[index]))
                : _swiperImage(context, _swiperCovers[index]);
          },
          pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              size: 8,
              activeSize: 10,
              color: Colors.white54,
              activeColor: Colors.white,
            ),
          ),
          indicatorLayout: PageIndicatorLayout.COLOR,
          autoplayDelay: 4000,
          autoplay: true,
        ));
  }

  _swiperImage(BuildContext context, imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fill,

          // FIXME 修改指示器和错误组件
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child: CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  _itemLists(BuildContext context) {
    // TODO 实现当数据还未加载时候的动画
    List<ShopItem> _items = [];

    if (_shopModel != null) {
      _items = _shopModel!.itemList;
    }

    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return _itemCard(context, _items[index]);
      },
    );
  }

  _itemCard(BuildContext context, ShopItem item) {
    return GestureDetector(
        onTap: () {
          launch(item.externalLink);
        },
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            padding: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), // 外部包裹处圆角
              color: Colors.white54,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14), // 图片上部分圆角
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: item.cover,
                        progressIndicatorBuilder: // TODO 更改加载动画
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        fit: BoxFit.cover,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.description,
                          style: const TextStyle(fontSize: 17),
                          softWrap: true,
                        ),
                        Text(
                          item.details ?? "",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            const Text(
                              "￥",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                            Text(
                              item.price.toString(),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget get _shopShimmer {
    double _innerWidth = MediaQuery.of(context).size.width - 2 * 14.0;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AnimatedShimmer(
                  width: _innerWidth,
                  height: _swiperHeight,
                  borderRadius: BorderRadius.circular(20),
                )),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Expanded(child: Column(children: _shimmerItemCards(3),)),
                  Expanded(child: Column(children: _shimmerItemCards(3),))
                ],
              )]
            )
          ],
        ));
  }

  _shimmerItemCards(int count){
    double _innerWidth = MediaQuery.of(context).size.width - 2 * 14.0; // 不优雅，但还是算了
    List<Widget> _singleItemList = [
      Padding(padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
      child: AnimatedShimmer(
          borderRadius: BorderRadius.circular(14),
          width: (_innerWidth - 2*3*2) / 2,
          height: (200 + rnd.nextInt(100)).toDouble()
      ),
    )];
    List<Widget> res = [];
    for (int i = 0; i < count; i++){
      res += _singleItemList;
    }
    return res;
  }
}
