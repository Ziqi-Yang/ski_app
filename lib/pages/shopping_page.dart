import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage>
    with AutomaticKeepAliveClientMixin {
  final rnd = Random();
  late List<int> extents;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    extents = List<int>.generate(10000, (int index) => rnd.nextInt(5) + 1);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      // body: NestedScrollView(
      //   headerSliverBuilder: ,
      // ),
    );
  }

  _itemLists(BuildContext context){
    return MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          return Container(
              color: Colors.blue,
              child: Column(
                children: [
                  Container(
                    child: CachedNetworkImage(
                      imageUrl: "https://himg.bdimg.com/sys/portraitn/item/dc35b2bbb0b2b5c4c6dfd0c7bffb3cd2",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                          CircularProgressIndicator(
                              value: downloadProgress.progress),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(index.toString())
                ],
              ));
        },
      );
  }

}


