import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/widget/card_widget.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:focusi/core/widget/state_widget.dart';
import 'package:focusi/core/widget/timer_widget.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:focusi/features/children_test/children_test_pages/game_test/model_veiw/card_model.dart';

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

  @override
  void initState() {
    super.initState();
    //startGame();
  }

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

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          deck.forEach((card) => card.flipped = false);
          showAllCardsTemporarily = false;
        });
      });

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          timeElapsed++;
          if (timeElapsed >= 120) {
            showGameOver = true;
            gameStarted = false;
            timer.cancel();
          }
        });
      });
    });
  }

  List<CardModel> shuffle(List<CardModel> cards) {
    cards.shuffle();
    return cards;
  }

  void flipCard(int index) {
    if (flippedCards.length >= 2 || deck[index].flipped || deck[index].matched) return;

    setState(() {
      deck[index].flipped = true;
      flippedCards.add(index);
      totalFlips++;

      if (flippedCards.length == 2) {
        Future.delayed(Duration(milliseconds: 800), checkMatch);
      }
    });
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

  void toggleSound() {
    setState(() {
      isSoundOn = !isSoundOn;
    });
  }

  void submitResult() {
    final result = {
      'matchedPairs': matchedPairs,
      'totalFlips': totalFlips,
      'timeElapsed': timeElapsed,
      'status': showCongrats ? 'completed' : 'timeout',
    };

    print("Submitting result: $result");

    showDialog(
  context: context,
  builder: (_) => AlertDialog(
    backgroundColor: Colors.white, // Set background to black
    title: Text(
      "Result Submitted",
      style: TextStyle(color: Colors.black), // Set title text color to white
    ),
    content: Text(
      "Thanks for playing!",
      style: TextStyle(color: Colors.black), // Set content text color to white
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        child: Text(
          "OK",
          style: TextStyle(color: Colors.black), // Set button text color to white
        ),
      )
    ],
  ),
);

  }

void toggleCamera(bool value) {
  setState(() {
    isCameraEnabled = value;
  });

  if (isCameraEnabled) {
    _initializeCamera().then((_) {
      startGame();
      print(value); // Start the game when the camera is ready
    });
  } else {
    _cameraController.dispose();
  }
}


  @override
  void dispose() {
    super.dispose();
    if (isCameraEnabled) {
      _cameraController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
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

              // if (isCameraEnabled && isCameraInitialized)
              //   FutureBuilder<void>(
              //     future: _initializeControllerFuture,
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.done) {
              //         return SizedBox(
              //           width: 200,
              //           height: 200,
              //           child: CameraPreview(_cameraController),
              //         );
              //       } else {
              //         return CustomLoading();
              //       }
              //     },
              //   ),
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
  }
}
