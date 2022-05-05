import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ski_app/model/latest_data_model.dart';
import 'package:ski_app/pages/data_analysis_page.dart';
import 'package:ski_app/widget/common_widget.dart';
import 'package:timelines/timelines.dart';
import 'package:ski_app/dao/latest_data_dao.dart';
import 'package:route_animation_helper/route_animation_helper.dart' show AnimType;

class LatestData extends StatefulWidget {
  final String userId;
  const LatestData({Key? key, this.userId = "null"}) : super(key: key);

  @override
  State<LatestData> createState() => _LatestDataState();
}

class _LatestDataState extends State<LatestData> {
  late Timer _timer;
  List<LatestDataModel> _datas = [];
  List<String> _ids = [];
  bool _isLoading = true;
  List<LatestDataModel> _reversedData = [];

  Future<void> _fetchData() async {
    FetchLatestDataDao.fetch(userId: widget.userId).then((results){
      String id = results[0];
      LatestDataModel value = results[1];

      setState(() {
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
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/home_page/background.jpg",),
                opacity: .5,
                fit: BoxFit.cover
            )
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                _dataBoard(context)
              ],
            )
        )
    );
  }

  _dataBoard(BuildContext context){
    return FixedTimeline.tileBuilder(
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
          return CommonWidget.ontapSlideRoute(
              context: context,
              animTape: AnimType.slideBottom,
              pageChild: const DataAnalysisPage(),
              child: SizedBox(
                  height: 70,
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    child: _showCard(context, index),
                  )
              )
          );
        },
      ),
    );
  }

  _showCard(BuildContext context, int index){
    return Padding(
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
                    TextSpan(text: "${_reversedData[index].averageSpeed}"),
                    const TextSpan(text: "   "),
                  ]
              ),
            ),

          ],
        )
    );
  }
}
