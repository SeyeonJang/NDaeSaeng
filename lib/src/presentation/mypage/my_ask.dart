import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyAsk extends StatefulWidget {
  const MyAsk({super.key});

  @override
  State<MyAsk> createState() => _MyAskState();
}

class _MyAskState extends State<MyAsk> {
  WebViewController _webViewController = WebViewController()..loadRequest(Uri.parse('https://tally.so/r/mYR270'));


  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _webViewController);
  }
}
