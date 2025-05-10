import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebVeiwVedio extends StatefulWidget {
  const WebVeiwVedio({super.key});

  @override
  State<WebVeiwVedio> createState() => _WebVeiwVedioState();
}

class _WebVeiwVedioState extends State<WebVeiwVedio> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/web/index.html');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  } 
  }
