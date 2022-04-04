import 'package:flutter/material.dart';
import 'package:ski_app/pages/community_page.dart';
import 'package:ski_app/pages/home_page.dart';
import 'package:ski_app/pages/me_page.dart';
import 'package:ski_app/pages/shopping_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: changeIndex,
        children: const [
          HomePage(),
          CommunityPage(),
          ShoppingPage(),
          MePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed, // 文字固定显示
        currentIndex: _currentIndex,
        onTap: changeIndex,
        unselectedItemColor: _defaultColor,
        selectedItemColor: _activeColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,),
            label: "动态",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt,),
            label: "商店",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,),
            label: "我的",
          ),
        ],
      )
    );
  }

  changeIndex(index){
    setState(() {
      _currentIndex = index;
    });
  }
}
