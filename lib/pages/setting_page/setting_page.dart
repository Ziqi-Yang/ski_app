import 'package:flutter/material.dart';
import 'package:ski_app/common.dart' show MyColors, Api;
import 'package:ski_app/dao/setting/setting_dao.dart';
import 'package:ski_app/model/setting_model.dart';
import 'package:ski_app/pages/history_page.dart';
import 'package:ski_app/pages/setting_page/account_sheet.dart';
import 'package:ski_app/widget/common_widget.dart';
import 'package:ski_app/widget/floating_bottom_sheet.dart';
import 'package:ski_app/pages/setting_page/setting_card.dart';

import 'package:r_upgrade/r_upgrade.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

// 为了使得PageView可以缓存这个页面，添加 with AutoMaic..
class _SettingPageState extends State<SettingPage>
    with AutomaticKeepAliveClientMixin {
  final Color _profileFontColor = Colors.black; // 避免与背景冲突
  bool _isDownloading = false;
  double _upgradeDownloadPercent = 0.0;
  double _upgradeDownloadSpeed = 0.0;
  double _upgradeDownloadLeftTime = 0.0;
  int? _upgradeDownloadId;
  late String _curAppVersion;

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

  // 获取app信息
  _appInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _curAppVersion = packageInfo.version;
  }

  _fetchLatestAppVersion() async {
    var url = Uri.parse(Api.latestVersion);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder();
      return json.decode(utf8decoder.convert(response.bodyBytes));
    } else {
      throw Exception("Failed to fetch latest version.");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _appInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        color: Colors.white,
    ),
    child: SingleChildScrollView(
        child: Column(
          children: [
            _simpleProfile(settingModel),
            const SizedBox(height: 10,),
            _settings(context),
            const SizedBox(height: 20,)
          ],
        ),
      )
    ));
  }

  _simpleProfile(SettingModel? model) {
    // 上方头像和关注信息等等
    return FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          height: 355,
          decoration: const BoxDecoration(
              color: MyColors.blueAccent,
              image: DecorationImage(
                  opacity: .8,
                  image: AssetImage("assets/images/snow_1.png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _avatar,
              // const SizedBox(
              //   height: 20,
              // ),
              _information(model),
              // const SizedBox(height: 5,)
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

  // =================
  // Settings
  // =================

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
      CommonWidget.ontapSlideRoute(
          context: context,
          pageChild: const HistoryPage(),
          child: ListTile(
            leading: const Icon(Icons.history),
            title: Text(
              "历史数据",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ))
    ];
  }

  _generalSettings(BuildContext context) {
    return <Widget>[
      _tile(
          context,
          Icons.account_circle,
          "账户",
          () => showFloatingModalBottomSheet(
              context: context, builder: (context) => const AccountSheet())),
      _tile(context, Icons.light_mode, "主题", () {
        funcNotSupportDialog(context);
      }),
      _tile(context, Icons.language, "语言", () {
        funcNotSupportDialog(context);
      }),
      _tile(context, Icons.upgrade_rounded, "检查更新", () {
        _requestUpgrade();
      }),
    ];
  }

  _tile(BuildContext context, IconData iconData, String text,
      void Function()? func) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      onTap: func,
    );
  }

  void _requestUpgrade() async {
    // https://github.com/Baseflow/flutter-permission-handler/issues/751
    var status = Permission.requestInstallPackages.status;
    if (await status.isDenied) {
      requestPermission(context, "安装应用的权限", "用于软件升级", () {
        Permission.requestInstallPackages.request();
      });
    } else if (await status.isGranted) {
      Map<String, dynamic> latestApp = await _fetchLatestAppVersion();
      bool hasNewVersion = isUpdateVersion(latestApp["version"], _curAppVersion);
      _upgradeDialog(hasNewVersion, latestApp["version"], latestApp["url"]);
      // upgrade();
    }
  }


  _upgradeDialog(bool hasNewVersion, String newVersion, String upgradeUrl) async {
    if (!hasNewVersion){
      showDialog(context: context, builder: (context) => AlertDialog(
        // titlePadding: const EdgeInsets.all(0),
        title: const Text("当前版本已是最新"),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("关闭")),
        ],
      ));
    } else {
      showDialog(context: context,
          // NOTICE 必须要用StatefulBuilder来实现内部内部state更新, 否则会无法正常显示进度条
          // NOTICE 注意下面的setState参数, 原来的setState给传入给它了
          builder: (context) => StatefulBuilder(builder: (context, setState){
            return AlertDialog(
                title: const Text("发现新版本!", textAlign: TextAlign.center, style: TextStyle(fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
                // titlePadding: const EdgeInsets.all(0),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("当前版本: $_curAppVersion, 最新版本: $newVersion"),
                      if (_isDownloading)
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                child: LinearProgressIndicator(
                                  value: _upgradeDownloadPercent / 100,
                                )
                            ),
                            Text("${_upgradeDownloadSpeed.toStringAsFixed(0)} kb/s  剩余${_upgradeDownloadLeftTime.toStringAsFixed(0)} s")
                          ],
                        )
                    ]
                ),
                actions: [
                  TextButton(onPressed: () async {
                    setState((){
                      _isDownloading = false; // 为的是防止再次点击检查更新
                    });
                    if (_upgradeDownloadId != null){
                      await RUpgrade.cancel(_upgradeDownloadId!);
                    }
                    _upgradeDownloadId = null;
                    Navigator.of(context).pop();
                  }, child: const Text("取消")),
                  TextButton(onPressed: () async {
                    // 更新
                    int? id = await RUpgrade.upgrade(upgradeUrl,
                        fileName: 'ski_app.apk', isAutoRequestInstall: true,
                        notificationStyle: NotificationStyle.speechAndPlanTime);
                    setState(() {
                      _isDownloading = true;
                      _upgradeDownloadId = id;
                    });
                    RUpgrade.stream.listen((DownloadInfo info){
                      setState((){
                        //FIXME 这里出问题了, setState() Called After Dispose()

                        _upgradeDownloadPercent = info.percent ?? 0.0; // 0 - 100
                        _upgradeDownloadSpeed = info.speed ?? 0.0;
                        _upgradeDownloadLeftTime = info.planTime ?? 0.0;
                      });
                    });
                  }, child: const Text("下载"))
                ],
              );
          })
      );
    }
  }
}

bool isUpdateVersion(String newVersion, String old) {
  // 为什么不用split -> join -> int来比较， 因为.号码中间可能一个两位，一个一位
  int newVersionInt, oldVersion;
  var newList = newVersion.split('.');
  var oldList = old.split('.');
  for (int i = 0; i < newList.length; i++) {
    newVersionInt = int.parse(newList[i]);
    oldVersion = int.parse(oldList[i]);
    if (newVersionInt > oldVersion) {
      return true;
    }
  }
  return false;
}
