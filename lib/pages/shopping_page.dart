import 'package:flutter/material.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> with AutomaticKeepAliveClientMixin{
  final url = "https://shop.m.jd.com/?shopId=11659313&utm_user=plusmember&gx=RnEwyzYMYTfcntRP--sMBAX3ja-AigWkfoc&ad_od=share&utm_source=androidapp&utm_medium=appshare&utm_campaign=t_335139774&utm_term=CopyURL";

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(),
    );
  }

}
