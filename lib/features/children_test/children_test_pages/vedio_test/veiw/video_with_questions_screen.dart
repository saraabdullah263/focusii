import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_loading.dart';
import 'package:focusi/features/children_test/children_test_pages/vedio_test/model_veiw/cubit/camera_tracking_cubit.dart';
import 'package:focusi/features/children_test/children_test_pages/vedio_test/model_veiw/cubit/camera_tracking_state.dart';
import 'package:focusi/features/children_test/children_test_pages/vedio_test/model_veiw/qestion_video_model.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

class VideoWithQuestionsScreen extends StatefulWidget {
  final bool camera;
  const VideoWithQuestionsScreen({super.key, required this.camera});

  @override
  State<VideoWithQuestionsScreen> createState() => _VideoWithQuestionsScreenState();
}

class _VideoWithQuestionsScreenState extends State<VideoWithQuestionsScreen> {
  late VideoPlayerController _controller;
  final AudioPlayer _audioPlayer = AudioPlayer();
  CameraController? _cameraController;
  bool cameraInitialized = false;
  late CameraTrackingCubit _cameraTrackingCubit;

  bool showQuestion = false;
  bool showCongrats = false;
  int questionIndex = 0;
  int correctAnswers = 0;
  bool isVideoEnded = false;

  StreamSubscription? _videoProgressSubscription;

  final List<QuestionModel> questions = [
    QuestionModel(
      question: "Which shape is round like an egg?",
      audio: 'assets/web/audios/question1.mp3',
      correctAudio: 'assets/web/audios/correct.mp3',
      wrongAudio: 'assets/web/audios/wrong1.mp3',
      choices: [
        Choice(image: 'assets/web/images/circle.png', isCorrect: false),
        Choice(image: 'assets/web/images/oval.png', isCorrect: true),
      ],
    ),
    QuestionModel(
      question: "Which shape is perfectly round?",
      audio: 'assets/web/audios/question2.mp3',
      correctAudio: 'assets/web/audios/correct.mp3',
      wrongAudio: 'assets/web/audios/wrong2.mp3',
      choices: [
        Choice(image: 'assets/web/images/oval.png', isCorrect: false),
        Choice(image: 'assets/web/images/circle.png', isCorrect: true),
      ],
    ),
    QuestionModel(
      question: "Which shape has four equal sides?",
      audio: 'assets/web/audios/question3.mp3',
      correctAudio: 'assets/web/audios/correct.mp3',
      wrongAudio: 'assets/web/audios/wrong3.mp3',
      choices: [
        Choice(image: 'assets/web/images/rectangle.png', isCorrect: false),
        Choice(image: 'assets/web/images/square.png', isCorrect: true),
      ],
    ),
    QuestionModel(
      question: "Which shape is a line has four sides?",
      audio: 'assets/web/audios/question4.mp3',
      correctAudio: 'assets/web/audios/correct.mp3',
      wrongAudio: 'assets/web/audios/wrong4.mp3',
      choices: [
        Choice(image: 'assets/web/images/rectangle.png', isCorrect: true),
        Choice(image: 'assets/web/images/square.png', isCorrect: false),
      ],
    ),
    QuestionModel(
      question: "Which shape has five points?",
      audio: 'assets/web/audios/question5.mp3',
      correctAudio: 'assets/web/audios/correct.mp3',
      wrongAudio: 'assets/web/audios/wrong5.mp3',
      choices: [
        Choice(image: 'assets/web/images/star.png', isCorrect: true),
        Choice(image: 'assets/web/images/rectangle.png', isCorrect: false),
        Choice(image: 'assets/web/images/oval.png', isCorrect: false),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cameraTrackingCubit = CameraTrackingCubit();
    if (widget.camera) {
      _initializeCamera();
    }

    _controller = VideoPlayerController.asset('assets/web/shapesB1.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(false);
        _controller.seekTo(Duration.zero);
        _controller.play();
        _startVideoListeners();
        
      });

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration && !isVideoEnded) {
        isVideoEnded = true;
        Future.delayed(const Duration(seconds: 1), () {
          _startRemainingQuestions();
        });
      }
    });
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    await _cameraController!.initialize();
    setState(() => cameraInitialized = true);

    Timer.periodic(Duration(seconds: 5), (timer) async {
      if (!mounted || !cameraInitialized) {
      timer.cancel();
      return;}
      try {
        final image = await _cameraController!.takePicture();
        if (!mounted) return;
        context.read<CameraTrackingCubit>().trackImage(File(image.path));
      } catch (e) {}
    });
  }

  void _startVideoListeners() {
    const checkInterval = Duration(seconds: 1);
    _videoProgressSubscription =
        Stream.periodic(checkInterval, (_) => _controller.value.position).listen((position) {
      final seconds = position.inSeconds;
      if (!showQuestion && questionIndex == 0 && seconds >= 26) {
        _controller.pause();
        showQuestion = true;
        _playAudio(questions[questionIndex].audio);
        setState(() {});
      }
    });
  }

  void _showCongratsDialog() async {
  final cameraCubit = context.read<CameraTrackingCubit>();
  final totalPhotos = cameraCubit.getTotalPhotos;
  final truePhotos = cameraCubit.getTruePhotos;

  await submitVideoResult(
    correctAnswers: correctAnswers,
    questionsNum: questions.length,
    totalPhotos: totalPhotos,
    truePhotos: truePhotos,
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.7),
        title: const Text(
          "Result Submitted",
          style: TextStyle(color: Colors.white, fontSize: 24),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          "Thanks for answering questions and you have submitted to your level",
          style: TextStyle(color: Colors.white70, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => GoRouter.of(context).push(AppRoutes.kmainVeiw),
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

  void _startRemainingQuestions() {
    if (questionIndex < questions.length) {
      setState(() => showQuestion = true);
      _playAudio(questions[questionIndex].audio);
    }
  }

  Future<void> _playAudio(String path) async {
    await _audioPlayer.stop();
    await _audioPlayer.setAsset(path);
    await _audioPlayer.play();
  }

  void handleAnswer(bool isCorrect) async {
    final question = questions[questionIndex];
    await _audioPlayer.stop();

    if (isCorrect) {
      correctAnswers++;
      await _playAudio(question.correctAudio);
    } else {
      await _playAudio(question.wrongAudio);
    }

    Future.delayed(const Duration(seconds: 2), () {
      questionIndex++;
      if (questionIndex == 1) {
        _playAudio(questions[questionIndex].audio);
      } else if (questionIndex == 2) {
        showQuestion = false;
        _controller.play();
      } else if (questionIndex < questions.length) {
        _playAudio(questions[questionIndex].audio);
      } else {
        showQuestion = false;
        if (correctAnswers >= 3) _showCongratsDialog();
        // final cameraCubit = context.read<CameraTrackingCubit>();

// submitVideoResult(
//   correctAnswers: correctAnswers,
//   questionsNum: questions.length,
//   totalPhotos: cameraCubit.getTotalPhotos,
//   truePhotos: cameraCubit.getTruePhotos,
// );
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    _videoProgressSubscription?.cancel();
    _cameraController?.dispose();
     context.read<CameraTrackingCubit>().close();
    super.dispose();
    cameraInitialized = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cameraTrackingCubit,
      //create: (_) => CameraTrackingCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CustomLoading(),
            ),
            // if (widget.camera && cameraInitialized)
            //   Positioned(
            //     top: 20,
            //     right: 20,
            //     child: CameraPreview(_cameraController!),
            //   ),
            BlocConsumer<CameraTrackingCubit, CameraTrackingState>(
              listener: (context, state) {
                if (state is CameraTrackingFailure) {
                  debugPrint("Camera tracking failed: ${state.error}");
                }
              },
              builder: (context, state) {
                if (state is CameraTrackingLoading) {
                  return const Positioned(
                    top: 190,
                    right: 20,
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CameraTrackingSuccess) {
                  return Positioned(
                    top: 190,
                    right: 20,
                    child: Icon(
                      state.isFocused ? Icons.check_circle : Icons.cancel,
                      color: state.isFocused ? Colors.green : Colors.red,
                      size: 30,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            if (showQuestion)
              Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: QuestionOverlay(
                    question: questions[questionIndex],
                    onAnswer: handleAnswer,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class QuestionOverlay extends StatelessWidget {
  final QuestionModel question;
  final Function(bool) onAnswer;

  const QuestionOverlay({required this.question, required this.onAnswer, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(question.question, style: const TextStyle(color: Colors.white, fontSize: 22), textAlign: TextAlign.center),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          children: question.choices.map((choice) {
            return GestureDetector(
              onTap: () => onAnswer(choice.isCorrect),
              child: Image.asset(choice.image, width: 100),
            );
          }).toList(),
        ),
      ],
    );
  }
}

Future<void> submitVideoResult({
  required int correctAnswers,
  required int questionsNum,
  required int totalPhotos,
  required int truePhotos,
}) async {
  final dio = Dio();

  final body = {
    "correctAnswers": correctAnswers,
    "questionsNum": questionsNum,
    "totalPhotos": totalPhotos,
    "truePhotos": truePhotos,
  };
final token=CacheHelper.getData(key: 'userToken');
  try {
    final response = await dio.put(
      "https://focusi.runasp.net/api/Tests/videoTest",
      data: body,
      options: Options(
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token', 
        },
      ),
    );
    print("✅ Video result submitted: ${response.data}");
  } catch (e) {
    print("❌ Failed to submit video result: $e");
  }
}

