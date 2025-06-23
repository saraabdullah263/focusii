import 'package:flutter/material.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/features/home/model_veiw/vedio_cubit/video_question_cubit.dart';
import 'package:focusi/features/home/model_veiw/vedio_cubit/video_question_state.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoWithAudioQuestions extends StatefulWidget {
  const VideoWithAudioQuestions({super.key});

  @override
  State<VideoWithAudioQuestions> createState() => _VideoWithAudioQuestionsState();
}

class _VideoWithAudioQuestionsState extends State<VideoWithAudioQuestions> {
  VideoPlayerController? _videoController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool showQuestion = false;
  int currentQuestionIndex = 0;

  bool isVideoBuffering = true; 

  @override
  void initState() {
    super.initState();
    final token = CacheHelper.getData(key: 'userToken');
    context.read<VideoQuestionCubit>().fetchAllVideos(token);
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _audioPlayer.dispose();
    super.dispose();
   // _videoController?.removeListener(_videoListener);
  }

  bool didPlayQuestion = false;

Future<void> _initializeVideo(String url) async {
  _videoController = VideoPlayerController.network(url);
  await _videoController!.initialize();
  await _videoController!.play();
  setState(() => isVideoBuffering = false);

  _videoController!.addListener(_videoListener);
}

void _videoListener() async {
  if (_videoController == null) return;
  if (_videoController!.value.position >= const Duration(seconds: 26) && !didPlayQuestion) {
    didPlayQuestion = true;
    _videoController!.pause();
    print("🎯 Showing first question");

    final state = context.read<VideoQuestionCubit>().state;
    if (state is VideoQuestionSuccess) {
      final audios = state.videos.first.audiosUrl?.first;
      if (audios != null) {
        _showNextQuestion(audios);
      }
    }
  }
}
  void _showNextQuestion(audios) async {
    setState(() {
      showQuestion = true;
    });

    String? questionAudio;
    if (currentQuestionIndex == 0) questionAudio = audios.question1;
    if (currentQuestionIndex == 1) questionAudio = audios.question2;
    if (currentQuestionIndex == 2) questionAudio = audios.question3;

    if (questionAudio != null) {
      await _audioPlayer.setUrl(questionAudio);
      await _audioPlayer.play();
    }
  }

  void _handleAnswer(String answer, String? feedbackAudio, audios) async {
    setState(() {
      showQuestion = false;
    });

    if (feedbackAudio != null) {
      await _audioPlayer.setUrl(feedbackAudio);
      await _audioPlayer.play();
    }

    currentQuestionIndex++;

    if (currentQuestionIndex < 3) {
      await Future.delayed(const Duration(seconds: 1));
      _showNextQuestion(audios);
    } else {
      _videoController?.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade900,
      body: BlocBuilder<VideoQuestionCubit, VideoQuestionState>(
        builder: (context, state) {
          if (state is VideoQuestionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideoQuestionFailure) {
            return Center(child: Text("❌ ${state.message}"));
          } else if (state is VideoQuestionSuccess) {
            final videoModel = state.videos.first;
            final audios = videoModel.audiosUrl?.first;

            if (_videoController == null && videoModel.videoUrl != null) {
              _initializeVideo(videoModel.videoUrl!);
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                if (_videoController != null && _videoController!.value.isInitialized)
                  Center(
                    child: AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: VideoPlayer(_videoController!),
                    ),
                  ),
                  
                if (isVideoBuffering) 
                  const Center(child: CircularProgressIndicator(color: Colors.white)),

                if (showQuestion && audios != null)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "🎧 Listen and choose:",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),

                          _buildImageAnswer(
                            imageUrl: "assets/web/images/circle.png",
                            text: "Circle",
                            onTap: () => _handleAnswer("circle", _getFeedbackAudio(audios, true), audios),
                          ),
                          const SizedBox(height: 10),
                          _buildImageAnswer(
                            imageUrl: "assets/web/images/rectangle.png",
                            text: "Rectangle",
                            onTap: () => _handleAnswer("rectangle", _getFeedbackAudio(audios, false), audios),
                          ),
                        ],
                      ),
                    ),
                  ),

                Positioned(
                  top: 30,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => GoRouter.of(context).go(AppRoutes.khomeView),
                    child: const Text(
                      'Exit',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text("No video loaded."));
        },
      ),
    );
  }

  String? _getFeedbackAudio(audios, bool isCorrect) {
    if (currentQuestionIndex == 0) return isCorrect ? null : audios.wrong1;
    if (currentQuestionIndex == 1) return isCorrect ? null : audios.wrong2;
    if (currentQuestionIndex == 2) return isCorrect ? null : audios.wrong3;
    return null;
  }

  Widget _buildImageAnswer({
    required String imageUrl,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.red.shade800,
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              imageUrl,
              height: 100,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
