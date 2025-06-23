class QuestionModel {
  final String question;
  final String audio;
  final String correctAudio;
  final String wrongAudio;
  final List<Choice> choices;

  QuestionModel({
    required this.question,
    required this.audio,
    required this.correctAudio,
    required this.wrongAudio,
    required this.choices,
  });
}

class Choice {
  final String image;
  final bool isCorrect;

  Choice({required this.image, required this.isCorrect});
}
