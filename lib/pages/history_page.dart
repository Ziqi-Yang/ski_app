import 'package:flutter/material.dart';
import 'package:ski_app/dao/history_general_dao.dart';
import 'package:ski_app/model/history_general_model.dart';
import 'package:ski_app/widget/common_widget.dart';

class HistoryPage extends StatefulWidget {
  final bool showAppBar;
  final bool showBackButton;
  final String userId;
  final String customTitle;
  const HistoryPage({Key? key, this.showAppBar = true, this.showBackButton = false,
    this.userId = "null", this.customTitle = "历史记录"}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final ScrollController _controller = ScrollController();
  // HistoryGeneralModel? historyGeneralModel;
  bool shouldGetHistory = true;
  int historyNextPage = 1;

  // 应该实现一个双向列表
  List historyDates = [];
  List historyDatas = []; // 数据和 historyDates 对应

  Future<void> _getOlderData() async{
    // NOTICE 获取旧的数据，适合向下拉
    HistoryGeneralDao.fetch(widget.userId, historyNextPage).then((hisModel){
      if (shouldGetHistory){
        List tmpDates = hisModel.data.keys.toList();
        setState(() {
          historyDates.addAll(tmpDates);
          for (String date in tmpDates){
            print(date);
            historyDatas.add(hisModel.data[date]);
          }
        });

        if (hisModel.next != null){
          historyNextPage = hisModel.next!;
        } else {
          shouldGetHistory = false;
        }
      }
    }).catchError((e){
      print(e);
    });
  }


  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      int offset = _controller.position.pixels.toInt();
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print("滑动到底部");
        // FIXME 添加刷新列表操作
      }
    });
    _getOlderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: (){
          // FIXME 这里的函数应该是重新获取全部数据(因为最新数据在上面)
          return _getOlderData(); // must return a Future stuff, so return Future null or void
        },
        child: CustomScrollView(
          controller: _controller,
          physics: const AlwaysScrollableScrollPhysics(), // 任何时候都能刷新
          slivers: [
            widget.showAppBar ?
            SliverAppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: Text(widget.customTitle),
              leading: !widget.showBackButton ? null : IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Icons.arrow_back)),
              actions: [
                PopupMenuButton(itemBuilder: (context){
                  return [
                    const PopupMenuItem(
                      // TODO 添加 onTap功能
                      child: Text("刷新", style: TextStyle(fontWeight: FontWeight.bold),),
                    )
                  ];
                })
              ],
              floating: true,
            ): const SliverToBoxAdapter(child: SizedBox(height: 30,),),
            if (historyDates != [])
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => _expansionTileDay(context, historyDates[index], historyDatas[index]),
                  // childCount: historyGeneralModel!.data.length,
                  childCount: historyDates.length
                ),
              ),
          ],
        ),
      )
    );
  }

  _expansionTileDay(BuildContext context, String date, List<HistoryGeneralCommonItem> datas) {
    List<Widget> items = [];
    for (var data in datas){
      items.add(
          CommonWidget.gestureWrap(
              context: context,
            pageChild: Text("test"), // FIXME
            child: ListTile(
              leading: const Icon(Icons.double_arrow),
              title: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: "${data.score}", style: const TextStyle(color: Colors.orangeAccent)),
                    const TextSpan(text: " 分", style: TextStyle(fontSize: 18))
                  ]
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    const WidgetSpan(child: Icon(Icons.schedule)),
                    TextSpan(text: data.startTime),
                    const TextSpan(text: "   "),

                    const WidgetSpan(child: Icon(Icons.restore)),
                    TextSpan(text: data.lastTime),
                    const TextSpan(text: "   "),

                    const WidgetSpan(child: Icon(Icons.bolt)),
                    TextSpan(text: "${data.speed}"),
                    const TextSpan(text: "   "),
                  ]
                ),
              ),
            )
          ));
    }
    return ExpansionTile(
      title: Text(date, style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),),
      children: items,
    );
  }

}
