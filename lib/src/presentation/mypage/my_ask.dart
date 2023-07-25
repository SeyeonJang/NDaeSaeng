import 'package:dart_flutter/res/size_config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyAsk extends StatefulWidget {
  const MyAsk({super.key});

  @override
  State<MyAsk> createState() => _MyAskState();
}

class _MyAskState extends State<MyAsk> {
  WebViewController _webViewController = WebViewController()..loadRequest(Uri.parse('https://tally.so/r/wzNV5E'));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 3),
        child: WebViewWidget(controller: _webViewController),
      )),
    );
  }
}
