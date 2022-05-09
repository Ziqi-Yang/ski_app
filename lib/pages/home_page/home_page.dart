import 'package:flutter/material.dart';
import 'package:ski_app/pages/home_page/devices.dart';
import 'package:ski_app/pages/home_page/latest_data.dart';
import 'package:ski_app/widget/bubble_tab_indicator.dart';
import 'package:ski_app/widget/common_widget.dart';
import 'package:ski_app/widget/wave_border.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return [
                _customSliverAppBar
              ];
            },
            body: const TabBarView(
              children: [
                LatestData(),
                Devices()
              ],
            ),
          ),
        ));
  }

  Widget get _customSliverAppBar {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.25,
        titlePadding: EdgeInsets.zero,
        title: _tabBar,
        centerTitle: true,
        background: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/snow_1.png"),
              fit: BoxFit.cover
            )
          ),
          child: WaveBorder(
            width: 250,
            maxWidth: 300,
            borderColor: const Color(0xff56aaf7),
            child: GestureDetector(
              onTap: (){
                errorDialog(context, "蓝牙连接功能暂未实现\n运动数据将会时时展现在下方 最新数据 模块");
              },
              child: Container(
                color: const Color(0xc156aaf7),
                child: const Center(
                  child: Text(
                    "开始",
                    style: TextStyle(
                        fontSize: 60, color: Colors.white,
                        fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(3, 3),
                          blurRadius: 10.0,
                          color: Colors.grey
                        )
                      ]
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TabBar get _tabBar {
    return const TabBar(
      indicatorColor: Colors.blue,
      // padding: EdgeInsets.symmetric(horizontal: 30),
      isScrollable: true,
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BubbleTabIndicator(
        indicatorHeight: 35.0,
        indicatorColor: Colors.blue,
        tabBarIndicatorSize: TabBarIndicatorSize.tab,
      ),
      tabs: [
        Tab(child: Text("最新数据",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),),
        Tab(child: Text("连接设备",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
        ),
      ],
    );
  }
}


