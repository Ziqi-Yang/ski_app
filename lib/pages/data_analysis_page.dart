import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ski_app/dao/single_data_dao.dart';
import 'package:ski_app/model/single_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class DataAnalysisPage extends StatefulWidget {
  final String userId;
  final String dataId;
  const DataAnalysisPage({Key? key, this.userId="null", this.dataId="1"}) : super(key: key);

  @override
  State<DataAnalysisPage> createState() => _DataAnalysisPageState();
}

class _DataAnalysisPageState extends State<DataAnalysisPage> {
  final TextStyle _columnTextStyle = const TextStyle(color: Colors.black, fontSize: 20);
  final TextStyle _timeTextStyle = const TextStyle(fontSize: 20);
  final TextStyle _pmtTextStyle = const TextStyle(color: Colors.black54, fontSize: 12,);
  final TextStyle _scoreStyle = const TextStyle(
      color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold,
      shadows: [Shadow(color:Colors.grey, blurRadius: 10)]);

  TooltipBehavior? _tooltipBehavior;
  SingleDataModle? _singleDataModle;

  // 视频播放
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;


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
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                return <Widget>[
                  _customAppBar(context),
                ];
              },
              body: Builder(builder: (BuildContext context){
                return FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                            // color: MyColors.lightGrey,
                          color: Colors.white,
                            child: _tabBarViweLoader(context)
                        ),
                      );
              },),
            )
        ));
  }

  _customAppBar(BuildContext context) {
    // sliver
    return SliverAppBar(
      floating: true,
      snap: false,
      pinned: true, // 把 TabBar 固定在顶部
      // backgroundColor: MyColors.lightGrey,
      backgroundColor: Colors.white,
      title: const Text("数据面板", style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),),
      centerTitle: true,
      // forceElevated: true,
      // elevation: 3,
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

    );
  }



  _tabBarViweLoader(BuildContext context){
    if (_singleDataModle != null){
      return TabBarView(
        children: [
          _overViewTab(context),
          _actionCompareTab(context)
        ],
      );
    }
    return Container();
  }


  /// ----------------------------------
  /// 数据概览页面 开始
  /// ----------------------------------

  _overViewTab(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                _circularIndicator(context),
                const SizedBox(height: 20,),
                _dataOverviewBoard(context)
              ],
            ),
          )
        )
      ],
    );
  }

  _circularIndicator(BuildContext context) {
    double _percent = 0.0;
    if (_singleDataModle != null){
      _percent = _singleDataModle!.score / 100;
    }

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
        percent: _percent,
        center: _circularIndicatorCenter(context),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: Colors.blue,
        backgroundColor: Colors.white,
      )
    );
  }


  _circularIndicatorCenter(BuildContext context){
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(130),
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)]
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
                    Text(_startTime, style: _timeTextStyle,),
                    Text("开始", style: _pmtTextStyle,)
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
                    Text(_endTime, style: _timeTextStyle,),
                    Text("结束", style: _pmtTextStyle,)
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 8,),
          Text(_score.toString(),style: _scoreStyle,),
          Text("分数", style: _pmtTextStyle,)
        ],
      ),
      );
  }

  _dataOverviewBoard(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _comprehensiveDatas(context),
                const SizedBox(height: 20,),
                _speedChart(context),
              ],
            )
        )
    );
  }

  _comprehensiveDatas(BuildContext context){
    double _averageSpeed = 0.0;
    double _maxSlope = 0.0;
    double _maxSwivel = 0.0;
    int _swivelNum = 5;

    if (_singleDataModle != null){
      _averageSpeed = _singleDataModle!.averageSpeed;
      _maxSlope = _singleDataModle!.maxSlope;
      _maxSwivel = _singleDataModle!.maxSwivel;
      _swivelNum = _singleDataModle!.swivelNum;
    }

    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("综合数据记录", style: _columnTextStyle),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _dataCrad(context, "平均速度", "$_averageSpeed m/s", Colors.blue),
            _dataCrad(context, "最大坡度", "$_maxSlope°", Colors.white),
            _dataCrad(context, "最大转体", "$_maxSwivel°", Colors.blue),
            _dataCrad(context, "转体次数", "$_swivelNum", Colors.white),
          ],
        )
      ],
    );
  }

  _dataCrad(BuildContext context, String title, String value, Color backgroundColor){
    TextStyle _dataCardTextStyle;
    if (backgroundColor == Colors.blue){
      _dataCardTextStyle = const TextStyle(color: Color(0xD4FFFFFF), fontSize: 14);
    } else {
      _dataCardTextStyle = const TextStyle(color: Colors.black87, fontSize: 14);
    }


    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: _dataCardTextStyle,),
          const SizedBox(height: 6,),
          Text(value, style: _dataCardTextStyle,)
        ],
      ),
    );
  }

  _speedChart(BuildContext context){
    List<SpeedData> _speedDatas = [];

    if (_singleDataModle != null){
      _speedDatas = _singleDataModle!.instantSpeed.speedData;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("全程速度分析", style: _columnTextStyle,),
        const SizedBox(height: 10,),
        Container(
          height: 250,
          child: SfCartesianChart(
            title: ChartTitle(
              text: "速度-路程变化图",
              textStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.bold
              )
            ),
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
            tooltipBehavior: _tooltipBehavior,
            series: <LineSeries<SpeedData, double>>[
              LineSeries<SpeedData, double>(
                name: "路程: 速度",
                dataSource: _speedDatas,
                xValueMapper: (SpeedData speedData, _) => speedData.distance,
                yValueMapper: (SpeedData speedData, _) => speedData.speed,
                animationDuration: 2500,
                enableTooltip: true,
                markerSettings: const MarkerSettings(isVisible: true),
                width: 2
              )
            ],
          ),
        )
      ],
    );
  }


  /// ----------------------------------
  /// 动作对比界面 开始
  /// ----------------------------------

  _actionCompareTab(BuildContext context){
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,20,20,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("动作分析", style: _columnTextStyle,),
                  _actionCompareBox(context),
                  Text("综合评价", style: _columnTextStyle,),
                ],
              ),
            )
        )
      ],
    );
  }

  _videoPlayerControllerInit() async {
    await _videoPlayerController!.initialize(); // NOTICE 这里加了确认不为空，看看
  }

  _actionCompareBox(BuildContext context) {
    if (_singleDataModle != null){
      _videoPlayerController = VideoPlayerController.network(_singleDataModle!.actionCompareVideoUrl);
      _videoPlayerControllerInit();
      _chewieController = ChewieController(videoPlayerController: _videoPlayerController!,
        autoInitialize: true,
        aspectRatio: (MediaQuery.of(context).size.width - 40) / 250, // 视频宽高比设置为Container的宽高比
        placeholder: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset("assets/images/background_0.jpg", fit: BoxFit.cover,),
        ),
        optionsTranslation: OptionsTranslation(playbackSpeedButtonText: "速度", cancelButtonText: "取消", )
      );

      return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
        height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Chewie(controller: _chewieController!,),
          )
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
    );
  }


  @override
  void dispose() {
    if (_singleDataModle != null){
      _videoPlayerController!.dispose();
      _chewieController!.dispose();
    }
    super.dispose();
  }


}

