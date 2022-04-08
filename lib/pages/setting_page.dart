import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ski_app/common.dart' show MyColors;
import 'package:ski_app/dao/setting_dao.dart';
import 'package:ski_app/model/setting_model.dart';
import 'package:ski_app/pages/history_page.dart';
import 'package:ski_app/widget/setting_card.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}
// 为了使得PageView可以缓存这个页面，添加 with AutoMaic..
class _SettingPageState extends State<SettingPage> with AutomaticKeepAliveClientMixin {
  SettingModel? settingModel;

  @override
  bool get wantKeepAlive => true;

  _loadData() async {
    SettingDao.fetch().then((value){
      setState(() {
        settingModel = value;
      });
    }).catchError((e){
      print(e);
    });
  }


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: MyColors.lightGrey,
          ),
          child: Column(
            children: [
              _simpleProfile(settingModel),
              _Settings(context)
            ],
          ),
        )
      );
  }

  _simpleProfile(SettingModel? model){
    // 上方头像和关注信息等等
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 350,
        decoration: const BoxDecoration(
            color: MyColors.blueAccent
        ),
        child: Column(
          children: [
            _avatar,
            const SizedBox(height: 20,),
            _information(model),
          ],
        ),
      )
    );
  }

  get _avatar{
    const double borderRadius = 70;
    bool hasError = settingModel != null ? settingModel!.errorCode != 0 : true;

    // hasError = true;
    return Column(
      children: [
        Container(
          width: borderRadius * 2, height: borderRadius * 2,
          margin: const EdgeInsets.fromLTRB(0, 40, 0, 20), // 考虑到状态栏
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 6),
            borderRadius: BorderRadius.circular(borderRadius)
          ),
          child: PhysicalModel(
            color: Colors.transparent,
            shape: BoxShape.circle,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(borderRadius),
            child: hasError ? const Icon(Icons.person, size: borderRadius,)
                : Image.network(settingModel!.avatar!, width: borderRadius * 2, height: borderRadius * 2,)
          ),
        ),
        Text(
          hasError ? "游客": settingModel!.username!,
          style: const TextStyle(fontSize: 24,color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          hasError ? "": "@${settingModel!.userId!}",
          style: const TextStyle(fontSize: 14,color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  _information(SettingModel? model){
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Expanded(child: _basicInformItem("博文", model != null ? model.blog ?? 0 : 0 , false)),
          Expanded(child: _basicInformItem("关注", model != null ? model.following ?? 0 : 0 , true)),
          Expanded(child: _basicInformItem("粉丝", model != null ? model.followers ?? 0 : 0 , false)),
        ],
      )
    );
  }

  _basicInformItem(String title, int num, bool centerItem) {
    BorderSide whiteBorderSide = const BorderSide(width: 0.8, color: Colors.white);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: centerItem ? whiteBorderSide : BorderSide.none,
          right: centerItem ? whiteBorderSide : BorderSide.none
        ),
      ),
      child: Column(
        children: [
          Text(
            num.toString(), // NOTICE  前面已经对各组null情况讨论了，这里不需要对 has_error字段 讨论
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Text(
            title.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }


  _Settings(BuildContext context, ){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SettingCard(icon: Icons.downhill_skiing, title: "通用", childs: _general(context))
    );
  }

  _general(BuildContext context) {
    return <Widget>[
      ListTile(
        leading: const Icon(Icons.history),
        title: Text("历史数据", style: Theme.of(context).textTheme.bodyText1,),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const HistoryPage(showBackButton: true,);
          }));
        },
      )
    ];
  }

}
