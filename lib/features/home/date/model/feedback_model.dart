class FeedbackModel {
  final int q1Answer;
  final int q2Answer;
  final int q3Answer;
  final String q4Answer;
  final String q5Answer;
  final String q6Answer;
  final String q7Answer;
  final String suggestions;

  FeedbackModel({
    required this.q1Answer,
    required this.q2Answer,
    required this.q3Answer,
    required this.q4Answer,
    required this.q5Answer,
    required this.q6Answer,
    required this.q7Answer,
    required this.suggestions,
  });

  Map<String, dynamic> toJson() {
    return {
      'q1Answer': q1Answer,
      'q2Answer': q2Answer,
      'q3Answer': q3Answer,
      'q4Answer': q4Answer,
      'q5Answer': q5Answer,
      'q6Answer': q6Answer,
      'q7Answer': q7Answer,
      'suggestions': suggestions,
    };
  }
}
