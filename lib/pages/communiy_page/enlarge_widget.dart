import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class EnlargeWidget extends StatelessWidget{
  // FIXME 目前只支持图片

  final ImageProvider imageProvider;
  final String tag;

  const EnlargeWidget({Key? key, required this.imageProvider, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: [
            PhotoView(
              imageProvider: imageProvider,
              backgroundDecoration: const BoxDecoration(
                  color: Color(0xff35303A)
              ),
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.contained * 5,
              heroAttributes: PhotoViewHeroAttributes(tag: tag),
            ),
            _funcWidgets(context, 15, 772, 5720)
          ],
        )
    );
  }

  _funcWidgets(BuildContext context,int messageNum, int retweetNum, int favNum){
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              color: Colors.transparent,
              height: 56,
              padding: const EdgeInsets.only(top: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      // FIXME 用Material + InkWell 来模仿twitter动画效果
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: _buttonUI(Icons.arrow_back),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: _buttonUI(Icons.more_vert),
                    )
                  ],
                ),
              )
          ),

          Container(
            color: const Color(0xa835303a),
            height: MediaQuery.of(context).size.height * .18,
            child: Column(
              children: [
                Row(
                  // FIXME
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buttonUI(IconData iconData){
    return ClipRRect(
      borderRadius: BorderRadius.circular(200),
      child: Container(
        width: 36,
        height: 36,
        color: const Color(0xa835303a),
        child: Icon(iconData, color: Colors.white.withAlpha(220), size: 28,),
      ),
    );
  }

}
