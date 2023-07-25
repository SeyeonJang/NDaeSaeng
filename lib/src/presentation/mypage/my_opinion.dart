import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyOpinion extends StatefulWidget {
  const MyOpinion({super.key});

  @override
  State<MyOpinion> createState() => _MyOpinionState();
}

class _MyOpinionState extends State<MyOpinion> {
  WebViewController _webViewController = WebViewController()..loadRequest(Uri.parse('https://tally.so/r/wzNV5E'));

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _webViewController);
  }
}
