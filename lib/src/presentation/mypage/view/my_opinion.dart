import 'package:dart_flutter/res/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyOpinion extends StatefulWidget {
  const MyOpinion({super.key});

  @override
  State<MyOpinion> createState() => _MyOpinionState();
}

class _MyOpinionState extends State<MyOpinion> {
  WebViewController _webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadRequest(Uri.parse('https://tally.so/r/mYR270'));

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
