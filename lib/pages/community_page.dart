import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _customAppBar(context)
        ],
      ),
    );
  }

  _customAppBar(BuildContext context){
    return SliverAppBar(
      floating: true,
      leading: Icon(Icons.person, color: Colors.blue,), // FIXME change
      title: Icon(Icons.downhill_skiing, color: Colors.blue, size: 30,),
      centerTitle: true,
      backgroundColor: Colors.white,
      forceElevated: true,
      elevation: 1.5,
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.settings, color: Colors.blue,))
      ],
    );
  }
}
