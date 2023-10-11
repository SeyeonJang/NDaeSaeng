import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewFullScreen extends StatefulWidget {
  final String url;
  final String title;
  const WebViewFullScreen({Key? key, required this.url, this.title = ''}) : super(key: key);

  @override
  State<WebViewFullScreen> createState() => _WebViewFullScreenState();
}

class _WebViewFullScreenState extends State<WebViewFullScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: WebViewWidget(controller: _webViewController),
      ),
    );
  }
