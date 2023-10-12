import 'package:dart_flutter/res/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

@Deprecated("WebViewFullScreen Widget으로 대체")
class MyAsk extends StatefulWidget {
  const MyAsk({super.key});

  @override
  State<MyAsk> createState() => _MyAskState();
}

class _MyAskState extends State<MyAsk> {
  final WebViewController _webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadRequest(Uri.parse('https://tally.so/r/wzNV5E'));


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
