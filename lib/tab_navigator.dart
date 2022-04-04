import 'package:flutter/material.dart';
import 'package:ski_app/pages/community_page.dart';
import 'package:ski_app/pages/home_page.dart';
import 'package:ski_app/pages/me_page.dart';
import 'package:ski_app/pages/shopping_page.dart';
import 'package:ski_app/pages/test_page.dart';

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
        onPageChanged: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomePage(),
          CommunityPage(),
          ShoppingPage(),
          MePage(),
          TestPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed, // 文字固定显示
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            pageController.jumpToPage(index);
            _currentIndex = index;
          });
        },
        unselectedItemColor: _defaultColor,
        selectedItemColor: _activeColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,),
            label: "动态",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop,),
            label: "商店",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,),
            label: "我的",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.developer_mode,),
            label: "test",
          ),
        ],
      )
    );
  }

}
