import 'package:flutter/material.dart';
import 'package:ski_app/common.dart' show MyColors;
import 'package:ski_app/dao/setting_dao.dart';
import 'package:ski_app/model/setting_model.dart';
import 'package:ski_app/pages/history_page.dart';
import 'package:ski_app/pages/setting_page/account_sheet.dart';
import 'package:ski_app/widget/common_widget.dart';
import 'package:ski_app/widget/floating_bottom_sheet.dart';
import 'package:ski_app/pages/setting_page/setting_card.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

// 为了使得PageView可以缓存这个页面，添加 with AutoMaic..
class _SettingPageState extends State<SettingPage>
    with AutomaticKeepAliveClientMixin {
  final Color _profileFontColor = Colors.black; // 避免与背景冲突

  SettingModel? settingModel;

  @override
  bool get wantKeepAlive => true;

  _loadData() async {
    SettingDao.fetch().then((value) {
      setState(() {
        settingModel = value;
      });
    }).catchError((e) {
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
        color: MyColors.background,
      ),
      child: Column(
        children: [_simpleProfile(settingModel), _settings(context)],
      ),
    ));
  }

  _simpleProfile(SettingModel? model) {
    // 上方头像和关注信息等等
    return FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          height: 350,
          decoration: const BoxDecoration(
              color: MyColors.blueAccent,
              image: DecorationImage(
                  opacity: .8,
                  image: AssetImage("assets/images/setting_page/snow_1.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              _avatar,
              const SizedBox(
                height: 20,
              ),
              _information(model),
            ],
          ),
        ));
  }

  get _avatar {
    const double borderRadius = 70;
    bool hasError = settingModel != null ? settingModel!.errorCode != 0 : true;

    // hasError = true;
    return SafeArea(
        child: Column(
      children: [
        Container(
          width: borderRadius * 2,
          height: borderRadius * 2,
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 6),
              borderRadius: BorderRadius.circular(borderRadius)),
          child: PhysicalModel(
              color: Colors.transparent,
              shape: BoxShape.circle,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(borderRadius),
              child: hasError
                  ? const Icon(
                      Icons.person,
                      size: borderRadius,
                    )
                  : Image.network(
                      settingModel!.avatar!,
                      width: borderRadius * 2,
                      height: borderRadius * 2,
                    )),
        ),
        Text(
          hasError ? "游客" : settingModel!.username!,
          style: TextStyle(
              fontSize: 24,
              color: _profileFontColor,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          hasError ? "" : "@${settingModel!.userId!}",
          style: TextStyle(
              fontSize: 14,
              color: _profileFontColor,
              fontWeight: FontWeight.bold),
        )
      ],
    ));
  }

  _information(SettingModel? model) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          children: [
            Expanded(
                child: _basicInformItem(
                    "博文", model != null ? model.blog ?? 0 : 0, false)),
            Expanded(
                child: _basicInformItem(
                    "关注", model != null ? model.following ?? 0 : 0, true)),
            Expanded(
                child: _basicInformItem(
                    "粉丝", model != null ? model.followers ?? 0 : 0, false)),
          ],
        ));
  }

  _basicInformItem(String title, int num, bool centerItem) {
    BorderSide whiteBorderSide =
        BorderSide(width: 0.8, color: _profileFontColor);

    return Container(
      decoration: BoxDecoration(
        border: Border(
            left: centerItem ? whiteBorderSide : BorderSide.none,
            right: centerItem ? whiteBorderSide : BorderSide.none),
      ),
      child: Column(
        children: [
          Text(
            num.toString(), // NOTICE  前面已经对各组null情况讨论了，这里不需要对 has_error字段 讨论
            style: TextStyle(
                color: _profileFontColor,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
          Text(
            title.toString(),
            style: TextStyle(color: _profileFontColor, fontSize: 16),
          )
        ],
      ),
    );
  }

  _settings(
    BuildContext context,
  ) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            SettingCard(
              icon: Icons.downhill_skiing,
              title: "功能区",
              childs: _functionArea(context),
              marginTop: 4,
            ),
            SettingCard(
              icon: Icons.grid_view,
              title: "通用设置",
              childs: _generalSettings(context),
              marginTop: 10,
            )
          ],
        ));
  }

  _functionArea(BuildContext context) {
    return <Widget>[
      CommonWidget.ontapSlideRoute(context: context,
    pageChild: const HistoryPage(),
    child: ListTile(
        leading: const Icon(Icons.history),
        title: Text(
          "历史数据",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      )
    )];
  }

  _generalSettings(BuildContext context) {
    return <Widget>[
      _tile(context, Icons.account_circle, "账户",
              () => showFloatingModalBottomSheet(context: context,
    builder: (context) => const AccountSheet())
      ),
      _tile(context, Icons.light_mode, "主题",(){funcNotSupportDialog(context);}),
      _tile(context, Icons.language, "语言",(){funcNotSupportDialog(context);}),
    ];
  }

  _tile(BuildContext context, IconData iconData, String text, void Function()? func){
    return ListTile(
      leading: Icon(iconData),
      title: Text(
        text, style: Theme.of(context).textTheme.bodyText1,
      ),
      onTap: func,
    );
  }
}
