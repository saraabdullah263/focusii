class AdviceModel {
  final List<String> advice;

  AdviceModel({required this.advice});

  factory AdviceModel.fromJson(List<dynamic> json) {
    return AdviceModel(
      advice: json.map((e) => e.toString()).toList(),
    );
  }
}