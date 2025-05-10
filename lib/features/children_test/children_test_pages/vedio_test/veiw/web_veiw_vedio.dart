import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:camera/camera.dart';

class WebVeiwVedio extends StatefulWidget {
  const WebVeiwVedio({super.key});

  @override
  State<WebVeiwVedio> createState() => _WebVeiwVedioState();
}

class _WebVeiwVedioState extends State<WebVeiwVedio> {
  late final WebViewController _controller;
  late CameraController _cameraController;
  bool isCameraInitialized = false;
  List<CameraDescription> cameras = [];

  @override
  void initState() {
    super.initState();

    _initializeWebView();
    _initializeCamera();
  }

  Future<void> _initializeWebView() async {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/web/index.html');
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(frontCamera, ResolutionPreset.high);
    await _cameraController.initialize();

    setState(() {
      isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (isCameraInitialized)
            Expanded(
              child: WebViewWidget(controller: _controller),
            ),
          ],
        ),
      ),
    );
  }
}
