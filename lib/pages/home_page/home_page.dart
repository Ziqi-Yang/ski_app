import 'package:flutter/material.dart';
import 'package:ski_app/pages/home_page/fetching_data_page.dart';
import 'package:ski_app/pages/history_page.dart';
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
            body: TabBarView(
              children: [
                const FetchingDataPage(showHeader: false,),
                Container(color: Colors.blue)
              ],
            ),
          ),
        ));
  }

  Widget get _customSliverAppBar {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
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
                funcNotSupportDialog(context);
              },
              child: Container(
                color: const Color(0xff56aaf7),
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


