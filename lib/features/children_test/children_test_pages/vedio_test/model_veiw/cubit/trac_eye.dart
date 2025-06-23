// import 'dart:async';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as p;

// class CameraTrackingScreen extends StatefulWidget {
//   const CameraTrackingScreen({super.key});

//   @override
//   State<CameraTrackingScreen> createState() => _CameraTrackingScreenState();
// }

// class _CameraTrackingScreenState extends State<CameraTrackingScreen> {
//   CameraController? _cameraController;
//   bool _isCameraInitialized = false;
//   Timer? _cameraTimer;

//   int totalPhotosSent = 0;
//   int truePhotoCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCameraAndTracking();
//   }

//   Future<void> _initializeCameraAndTracking() async {
//     final cameras = await availableCameras();
//     final frontCamera = cameras.firstWhere(
//       (camera) => camera.lensDirection == CameraLensDirection.front,
//       orElse: () => cameras.first,
//     );

//     _cameraController = CameraController(
//       frontCamera,
//       ResolutionPreset.medium,
//       enableAudio: false,
//     );

//     await _cameraController!.initialize();
//     setState(() {
//       _isCameraInitialized = true;
//     });

//     _startTrackingCamera();
//   }

//   void _startTrackingCamera() {
//     _cameraTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
//       try {
//         final imageFile = await _cameraController!.takePicture();
//         await _sendImageToApi(imageFile);
//       } catch (e) {
//         print("📷 Error taking or sending picture: $e");
//       }
//     });
//   }

//   Future<void> _sendImageToApi(XFile imageFile) async {
//     try {
//       final file = File(imageFile.path);
//       final formData = FormData.fromMap({
//         "image": await MultipartFile.fromFile(file.path, filename: p.basename(file.path)),
//       });

//       final dio = Dio();
//       final response = await dio.post(
//         "https://amira44-newfocus.hf.space/predict",
//         data: formData,
//       );

//       totalPhotosSent++;
//       if (response.data['isFocused'] == true) {
//         truePhotoCount++;
//       }

//       print("✅ Sent: $totalPhotosSent, Focused: $truePhotoCount");
//     } catch (e) {
//       print("❌ API Error: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _cameraTimer?.cancel();
//     _cameraController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Camera Tracking")),
//       body: Stack(
//         children: [
//           if (_isCameraInitialized)
//             Center(
//               child: CameraPreview(_cameraController!),
//             )
//           else
//             const Center(child: CircularProgressIndicator()),

//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Photos Sent: $totalPhotosSent", style: const TextStyle(color: Colors.white)),
//                 Text("True Focused: $truePhotoCount", style: const TextStyle(color: Colors.white)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }