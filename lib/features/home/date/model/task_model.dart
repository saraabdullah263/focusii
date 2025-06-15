class TaskModel {
  final String name;
  final DateTime date; 
  final bool isDateAndTimeEnded;
  final bool isCompleted;

  TaskModel({
    required this.name,
    required this.date,
    required this.isDateAndTimeEnded,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      name: json['name'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(), 
      isDateAndTimeEnded: json['isDateAndTimeEnded'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toIso8601String(), // ✅ تحويل DateTime إلى String بصيغة ISO
      'isDateAndTimeEnded': isDateAndTimeEnded,
      'isCompleted': isCompleted,
    };
  }
}
