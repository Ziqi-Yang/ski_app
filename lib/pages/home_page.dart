import 'package:flutter/material.dart';
import 'package:ski_app/pages/fetching_data_page.dart';
import 'package:ski_app/pages/history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // body: HistoryPage(customTitle: "历史滑雪",),
      body: FetchingDataPage(),
    );
  }

}
