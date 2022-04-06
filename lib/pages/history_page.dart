import 'package:flutter/material.dart';
import 'package:ski_app/common.dart' show MyColors;
import 'package:ski_app/dao/history_general_dao.dart';
import 'package:ski_app/model/history_general_model.dart';

class HistoryPage extends StatefulWidget {
  final bool showAppBar;
  final bool showBackButton;
  const HistoryPage({Key? key, this.showAppBar = true, this.showBackButton = false}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ScrollController _controller = ScrollController();
  HistoryGeneralModel? historyGeneralModel;


  Future<void> _RefreshData() async{
    HistoryGeneralDao.fetch().then((value){
      setState(() {
        historyGeneralModel = value;
      });
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
    _RefreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: (){
          // FIXME 添加刷新列表操作
          print(" on refresh!");
          return Future.value(1);
        },
        child: CustomScrollView(
          controller: _controller,
          physics: const ScrollPhysics(),
          slivers: [
            widget.showAppBar ?
            SliverAppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: Text("历史记录"),
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
            ): const SliverAppBar(backgroundColor: Colors.transparent,),
            if (historyGeneralModel != null)
              SliverToBoxAdapter(
                child: Container(
                  child: Text(historyGeneralModel!.next.toString()),
                )
              ),
            SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                    (context, index) => ListTile(title: Text('Item #$index')),
                // Builds 100 ListTiles
                childCount: 100,
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<void> _onRefresh() async {
  }
}
