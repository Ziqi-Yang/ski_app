import 'package:flutter/material.dart';
import 'package:ski_app/model/community/media.dart';
import 'package:ski_app/pages/communiy_page/enlarge_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MediaArea extends StatelessWidget {
  final String heroTag;
  final Media medias;
  const MediaArea({Key? key, required this.heroTag, required this.medias}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Stack(
          children: [
            Hero(
              tag: heroTag,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: medias.pictures !=
                        null
                        ? medias.pictures![0] // FIXME 如果没有图片则没有这个组件
                        : "https://wx2.sinaimg.cn/orj360/00337rRAly1gthleo3pyrj60j60j6aan02.jpg",
                    progressIndicatorBuilder: // TODO 更改加载动画 (微光)
                        (context, url,
                        downloadProgress) =>
                        Center(
                            child: CircularProgressIndicator(
                                value:
                                downloadProgress
                                    .progress)),
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned.fill(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.black26,
                      splashFactory: InkRipple.splashFactory, // 相对于默认的InkSplash.splashFactory 更快
                      borderRadius:
                      const BorderRadius.all(
                          Radius.circular(16)),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) {
                                  return EnlargeWidget(
                                      tag: heroTag,
                                      imageProvider:
                                      CachedNetworkImageProvider(
                                        medias.pictures !=
                                            null
                                            ? medias
                                            .pictures![0]
                                            : "https://wx2.sinaimg.cn/orj360/00337rRAly1gthleo3pyrj60j60j6aan02.jpg",
                                      ));
                                }));
                      },
                    )))
          ],
        ));
  }
}

