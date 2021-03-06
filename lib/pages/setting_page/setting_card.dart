import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final double marginTop;
  List<Widget> childs;
  SettingCard({Key? key, required this.icon,required this.title, required this.childs,
    this.marginTop=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 3)]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          // direction: Axis.vertical,
          // spacing: 10,
          children: [
            _bar(context, icon, title),
            const Divider(height: 0,thickness: 1,),
            ...childs
          ],
        ),
      ),
    );
  }

  _bar(BuildContext context, IconData icon, String title){
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      height: 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(padding: EdgeInsets.only(right: 20),
              child: Icon(icon, size: 18,)),
          Padding(padding: EdgeInsets.only(top: 2),
          child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}
