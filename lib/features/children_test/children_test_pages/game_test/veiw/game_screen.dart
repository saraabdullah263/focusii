import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/card_widget.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:focusi/core/widget/state_widget.dart';
import 'package:focusi/core/widget/timer_widget.dart';
import 'package:focusi/features/children_test/children_test_pages/game_test/model_veiw/card_model.dart';
import 'package:focusi/features/children_test/children_test_pages/vedio_test/model_veiw/cubit/camera_tracking_cubit.dart';
import 'package:focusi/features/children_test/children_test_pages/vedio_test/model_veiw/cubit/camera_tracking_state.dart';
import 'package:go_router/go_router.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key}); 

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<CardModel> deck = [];
  List<int> flippedCards = [];
  int matchedPairs = 0;
  int totalFlips = 0;
  int timeElapsed = 0;
  Timer? timer;
  bool gameStarted = false;
  bool showCongrats = false;
  bool showGameOver = false;
  bool isSoundOn = true;
  bool showAllCardsTemporarily = true;
  bool showGame = false;
  bool isCameraEnabled = false;

  final List<String> symbols = ['🍎', '🍌', '🍇', '🍓', '🍉'];

  late CameraController _cameraController;
  bool isCameraInitialized = false;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
    );

    await _cameraController.initialize();

    setState(() {
      isCameraInitialized = true;
    });
  }

  void startGame() {
    setState(() {
      matchedPairs = 0;
      totalFlips = 0;
      timeElapsed = 0;
      showCongrats = false;
      showGameOver = false;
      showGame = true;
      gameStarted = true;
      showAllCardsTemporarily = false;
      deck = shuffle([...symbols, ...symbols].map((value) => CardModel(value: value)).toList());

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          for (var card in deck) {
            card.flipped = false;
          }
        });
      });

      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          timeElapsed++;
          if (timeElapsed >= 120) {
            showGameOver = true;
            gameStarted = false;
            timer?.cancel();
          }
        });
      });
    });
  }

  List<CardModel> shuffle(List<CardModel> cards) {
    cards.shuffle();
    return cards;
  }

  void flipCard(int index) async {
    if (flippedCards.length >= 2 || deck[index].flipped || deck[index].matched) return;

    setState(() {
      deck[index].flipped = true;
      flippedCards.add(index);
      totalFlips++;
    });

    if (isCameraEnabled && isCameraInitialized) {
      final file = await _cameraController.takePicture();
      context.read<CameraTrackingCubit>().trackImage(File(file.path));
    }

    if (flippedCards.length == 2) {
      Future.delayed(const Duration(milliseconds: 800), checkMatch);
    }
  }

  void checkMatch() {
    final card1 = deck[flippedCards[0]];
    final card2 = deck[flippedCards[1]];

    if (card1.value == card2.value) {
      setState(() {
        card1.matched = true;
        card2.matched = true;
        matchedPairs++;
        if (matchedPairs == symbols.length) {
          gameStarted = false;
          showCongrats = true;
          timer?.cancel();
        }
      });
    } else {
      setState(() {
        card1.flipped = false;
        card2.flipped = false;
      });
    }

    flippedCards.clear();
  }

  void submitResult() {
  final cubit = context.read<CameraTrackingCubit>();
  final token = CacheHelper.getData(key: 'userToken');

  cubit.submitTrackingResult(
    token,
    truePhotos: cubit.getTruePhotos,
    totalPhotos: cubit.getTotalPhotos,
  );
}


  void toggleCamera(bool value) {
    setState(() {
      isCameraEnabled = value;
    });

    if (value) {
      _initializeCamera().then((_) {
        startGame();
      });
    } else {
      if (isCameraInitialized) {
        _cameraController.dispose();
      }
      setState(() {
        isCameraInitialized = false;
        showGame = false;
        gameStarted = false;
        deck.clear();
      });
    }
  }

  @override
  void dispose() {
    if (isCameraInitialized) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraTrackingCubit, CameraTrackingState>(
      listener: (context, state) {
        if (state is CameraTrackingSubmitSuccess) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Tracking Submitted"),
              content: const Text("Thanks for playing! you have submitted to your level"),
              actions: [
                TextButton(
                  onPressed: () => GoRouter.of(context).push(AppRoutes.kmainVeiw),
                  child: const Text("OK"),
                )
              ],
            ),
          );
        } else if (state is CameraTrackingFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.error}")),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(AppImages.logoWhite),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .06),
                  if (!isCameraEnabled)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Open Camera",
                            style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                          Switch(
                            value: isCameraEnabled,
                            onChanged: toggleCamera,
                            activeColor: Colors.white,
                            activeTrackColor: Colors.green,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  if (isCameraEnabled && isCameraInitialized)
                  if (gameStarted) TimerWidget(timeElapsed: timeElapsed),
                  SizedBox(height: MediaQuery.of(context).size.height * .04),
                  StatsWidget(matchedPairs: matchedPairs, totalFlips: totalFlips),
                  SizedBox(height: MediaQuery.of(context).size.height * .08),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .04,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: deck.length,
                      itemBuilder: (context, index) {
                        return CardWidget(card: deck[index], onTap: () => flipCard(index));
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .08),
                  if (showCongrats || showGameOver)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .08,
                      ),
                      child: CustomElvatedButton(
                        title: 'Submit',
                        onPressed: submitResult,
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
