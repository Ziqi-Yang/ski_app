import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const CATCH_URLS = ["m.jd.com"];

class WebViewWidget extends StatefulWidget {
  String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool block;

  WebViewWidget(
      {Key? key, this.url,
        this.statusBarColor,
        this.title,
        this.hideAppBar,
        this.block = false
      }) : super(key: key) {
    if (url != null && url!.contains('jd.com')) {
      //fix 携程H5 http://无法打开问题
      url = url!.replaceAll("http://", 'https://');
    }
  }

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  bool existing = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  _isToMain(String? url){
    bool contain = false;
    for (final value in CATCH_URLS){
      if (url?.endsWith(value) ?? false) {
        contain = true;
      }
    }
    return contain;
  }


  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? "ffffff";
    Color backbuttonColor;

    if (statusBarColorStr == "ffffff"){
      backbuttonColor = Colors.black;
    } else {
      backbuttonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: [
          _appbar(Color(int.parse("0xff" + statusBarColorStr)),backbuttonColor),
          Expanded(child:
          WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request){
                // 在这里可以阻止跳转到某网址等等
                if (_isToMain(request.url)){
                  print("blocking navigation to $request}");
                  if (widget.block){
                    Navigator.pop(context);
                  }
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              }
          )
          )
        ],
      ),
    );
  }

  _appbar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    color: backButtonColor,
                    size: 26,
                  ),
                )
            ),
            Positioned(
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.title ?? "",
                    style: TextStyle(color: backButtonColor,fontSize: 20),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
