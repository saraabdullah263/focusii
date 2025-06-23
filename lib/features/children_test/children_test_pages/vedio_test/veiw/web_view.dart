import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:go_router/go_router.dart';


class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool _showOverlay = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_showOverlay)
            Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Choose how to start:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => _showOverlay = false);
                          GoRouter.of(context).push(AppRoutes.kvideoWithQuestionsScreen, extra: false);
                        },
                        child: const Text('Start Without Camera'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() => _showOverlay = false);
                          // Navigate to camera, then video
                           GoRouter.of(context).push(AppRoutes.kvideoWithQuestionsScreen, extra: true); 
                        },
                        child: const Text('Start With Camera'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
