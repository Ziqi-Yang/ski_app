import 'dart:async';
// import 'dart:io' show sleep;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:ski_app/common.dart' show MyColors;
import 'package:ski_app/model/history_general_model.dart' show HistoryGeneralCommonItem;
import 'package:ski_app/pages/data_analysis_page.dart';
import 'package:ski_app/widget/common_widget.dart';
import 'package:timelines/timelines.dart';
import 'package:ski_app/dao/fetch_latest_data_dao.dart';

class FetchingDataPage extends StatefulWidget {
  final String userId;
  const FetchingDataPage({Key? key, this.userId = "null"}) : super(key: key);

  @override
  State<FetchingDataPage> createState() => _FetchingDataPageState();
}

class _FetchingDataPageState extends State<FetchingDataPage> {
  late Timer _timer;
  List<HistoryGeneralCommonItem> _datas = [];
  List<String> _ids = [];
  bool _isLoading = true;
  List _reversedData = [];

  Future<void> _fetchData() async {
    FetchLatestDataDao.fetch(userId: widget.userId).then((results){
      String id = results[0];
      HistoryGeneralCommonItem value = results[1];

      setState(() {
        // TODO 只收集近一个小时的值, 不过这还要获取日期数据等等,还是之后再做吧
        if (_ids.isEmpty || id != _ids[_ids.length - 1]){
          _datas.add(value);
          _ids.add(id);
        }
      });
      _reversedData = _datas.reversed.toList();
    }).catchError((e){
      print(e);
    });
  }



  @override
  void initState() {
    super.initState();
    _fetchData();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      // 每隔10秒获取一次数据
      _fetchData();

      // FIXME 暂时就让加载动画一直显示
      // setState(() {
      //   _isLoading = true;
      // });
      //
      //
      // sleep(const Duration(seconds: 1)); // dart.io
      // setState(() {
      //   _isLoading = false;
      // });
    });

  }

  @override
  void dispose() {
    if (_timer.isActive) {  // 判断定时器是否是激活状态
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
          child: Container(
        color: MyColors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: RefreshIndicator(
            onRefresh: _fetchData,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                _Title,
                const Divider(height: 10,color: MyColors.light, thickness: 2,),
                FixedTimeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: .05,
                    connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                      thickness: 2.5,
                      // indent: 3,
                      space: 50
                    ),
                    indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                      size: 45,
                      position: 0.5,
                    ),
                  ),
                  builder: TimelineTileBuilder(
                    itemCount: _ids.length,
                    itemExtentBuilder: (_,index) => 80,
                    indicatorBuilder: (_,index) {
                      if (index == 0){
                        return Indicator.outlined(size: 30,borderWidth: 4,);
                      }
                      return Indicator.dot(size: 30,);
                    },
                    startConnectorBuilder: (_,index){
                      if (index == 0){
                        return null;
                      }
                      return Connector.dashedLine();
                    },
                    endConnectorBuilder: (_,index){
                      if (index == _ids.length - 1){
                        return null;
                      }
                      return Connector.dashedLine();
                    },
                    contentsBuilder: (context,index){
                      return CommonWidget.gestureWrap(
                        context: context,
                        pageChild: const DataAnalysisPage(),
                        child: SizedBox(
                            height: 70,
                            child: Card(
                              color: MyColors.light,
                              elevation: 2,
                              child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Column(
                                    children: [
                                      // const SizedBox(height: 5,),
                                      RichText(
                                        text: TextSpan(
                                            style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                            children: [
                                              TextSpan(text: "${_reversedData[index].score}", style: const TextStyle(color: Color(0xfffc8c23))),
                                              const TextSpan(text: " 分", style: TextStyle(fontSize: 18))
                                            ]
                                        ),
                                      ),
                                      const SizedBox(height: 4,),
                                      RichText(
                                        text: TextSpan(
                                            style: const TextStyle(color: Colors.grey),
                                            children: [
                                              const WidgetSpan(child: Icon(Icons.schedule, color: Colors.grey, size: 18,)),
                                              TextSpan(text: _reversedData[index].startTime),
                                              const TextSpan(text: "   "),

                                              const WidgetSpan(child: Icon(Icons.restore,color: Colors.grey, size: 18)),
                                              TextSpan(text: _reversedData[index].lastTime),
                                              const TextSpan(text: "   "),

                                              const WidgetSpan(child: Icon(Icons.bolt,color: Colors.grey, size: 18)),
                                              TextSpan(text: "${_reversedData[index].speed}"),
                                              const TextSpan(text: "   "),
                                            ]
                                        ),
                                      ),

                                    ],
                                  )
                              ),
                            )
                        )
                      );
                    },
                  ),
                )
              ],
            ),
          )
        )
      ))
    );
  }

  get _Title{
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "获取最新数据",
            style: TextStyle(fontSize: 40, color: Colors.black38, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Text("下拉手动刷新", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
          if (_isLoading)
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: const SpinKitCircle(
                  color: Colors.white,
                  size: 14,
            ))
        ],
      )
    );
  }
}
