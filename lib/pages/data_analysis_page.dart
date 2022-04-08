import 'package:flutter/material.dart';
import 'package:ski_app/common.dart' show MyColors;

class DataAnalysisPage extends StatefulWidget {
  const DataAnalysisPage({Key? key}) : super(key: key);

  @override
  State<DataAnalysisPage> createState() => _DataAnalysisPageState();
}

class _DataAnalysisPageState extends State<DataAnalysisPage> {
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
                child:Icon(Icons.arrow_back, color: Colors.black87,)
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
            child:
            TabBarView(
              children: [
                _overViewTab(context),
                Text("World")
              ],
            ),
          ),
        )));
  }

  _overViewTab(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [

        ],
      ),
    );
  }
}
