import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ski_app/common.dart' show MyColors;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ski_app/dao/single_data_dao.dart';
import 'package:ski_app/model/single_data_model.dart';

class DataAnalysisPage extends StatefulWidget {
  final String userId;
  final String dataId;
  const DataAnalysisPage({Key? key, this.userId="null", this.dataId="1"}) : super(key: key);

  @override
  State<DataAnalysisPage> createState() => _DataAnalysisPageState();
}

class _DataAnalysisPageState extends State<DataAnalysisPage> {
  SingleDataModle? _singleDataModle;

  Future<void> _loadData() async {
    SingleDataDao.fetch(widget.userId, widget.dataId).then((value){
      setState(() {
        _singleDataModle = value;
      });
    });
    //     .catchError((e){
    //   print(e);
    // });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.lightGrey,
            elevation: 0,
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
                child: const Icon(Icons.arrow_back, color: Colors.black87,)
            ),
            bottom: const TabBar(
              indicatorColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 30),
                tabs: [
                  Tab(child: Text("数据概览", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),),
                  Tab(child: Text("动作对比", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),),
                ],
            ),
          ),
            body: FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            color: MyColors.lightGrey,
            child: _tabBarViweLoader(context)
          ),
        )));
  }

  _tabBarViweLoader(BuildContext context){
    if (_singleDataModle != null){
      return TabBarView(
        children: [
          _overViewTab(context),
          Text("World")
        ],
      );
    }
    return Container();
  }

  _overViewTab(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          _circularIndicator(context)
        ],
      ),
    );
  }

  _circularIndicator(BuildContext context) {
    // FIXME add module
    return Container(
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 20.0)],
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(130),
        ),
      child: CircularPercentIndicator(
        startAngle: 180,
        radius: 130,
        lineWidth: 20,
        animation: true,
        animationDuration: 1000,
        percent: 0.7,
        center: _circularIndicatorCenter(context),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: Colors.blue,
      )
    );
  }


  _circularIndicatorCenter(BuildContext context){
    TextStyle timeTextStyle = const TextStyle(fontSize: 20);
    TextStyle pmtTextStyle = const TextStyle(color: Colors.black54, fontSize: 12,);
    TextStyle scoreStyle = const TextStyle(color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold);

    String _startTime = "00:00";
    String _endTime = "00:00";
    int _score = 0;

    if (_singleDataModle != null) {
      _startTime = _singleDataModle!.startTime;
      _endTime = _singleDataModle!.endTime;
      _score = _singleDataModle!.score;
    }

    return Container(
        height: 110 * 2,
        width: 110 * 2,
        decoration: BoxDecoration(
            color: MyColors.lightGrey,
            borderRadius: BorderRadius.circular(130),
        ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 45,),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(_startTime, style: timeTextStyle,),
                    Text("开始", style: pmtTextStyle,)
                  ],
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  width: 24,
                  thickness: 1,
                  indent: 6,
                  endIndent: 6,
                ),
                Column(
                  children: [
                    Text(_endTime, style: timeTextStyle,),
                    Text("结束", style: pmtTextStyle,)
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 8,),
          Text(_score.toString(),style: scoreStyle,),
          Text("分数", style: pmtTextStyle,)
        ],
      ),
      );
  }

}
