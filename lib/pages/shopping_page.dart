import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ski_app/common.dart' show MyColors;
import 'package:card_swiper/card_swiper.dart';
import 'package:ski_app/model/shop/shop_item.dart';
import 'package:ski_app/widget/common_widget.dart';
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
  bool _loadModelDone = false;

  final _swiperHeight = 160.0; // 不包括margin
  var rnd = Random();

  @override
  bool get wantKeepAlive => true;

  void _launchApp(String url) async {
    if ( await canLaunch(url)){
      await launch(url);
    } else {
      errorDialog(context, "请先安装淘宝App"); // FIXME 可以在dialog里加个打开商店的button
    }
  }

  @override
  void initState() {
    super.initState();

    ShopDao.fetch().then((value) {
      setState(() {
        _shopModel = value;
        _loadModelDone = true;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        // 对于MasonryGridView不能放在customscrollview中，放在NestedScrollView中效果似乎会出问题
        body: CustomScrollView( // 防止shimmer溢出, 对原组件无影响
            slivers: [
              const SliverAppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                title: Text("滑雪商店"),
                centerTitle: true,
                floating: true,
              ),
              if (!_loadModelDone)
                SliverToBoxAdapter(
                  child: _shopShimmer,
                ),
              if (_loadModelDone)
                SliverToBoxAdapter(
                  child: _swiper(context),
                ),
              if (_loadModelDone)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  sliver: _itemLists(context)
                )
            ],
          )
        );
  }


  // FIXME 把swiper放在list里面
  _swiper(BuildContext context) {
    List<String> _swiperCovers = [];

    List<String?> _links = []; // NOTICE 长度要和 _swiperCovers 长度一致

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
                      _launchApp(_links[index]!);
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
          placeholder: (BuildContext context, String url) => const AnimatedShimmer(),
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

    return SliverMasonryGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      childCount: _items.length,
      itemBuilder: (context, index) {
        return _itemCard(context, _items[index]);
      },
    );
  }

  _itemCard(BuildContext context, ShopItem item) {
    return GestureDetector(
        onTap: () {
          _launchApp(item.externalLink);
        },
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            padding: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), // 外部包裹处圆角
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: .5)],
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14), // 图片上部分圆角
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: item.cover,
                        placeholder: (BuildContext context, String url) => const AnimatedShimmer(
                          height: 200,
                        ),
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
