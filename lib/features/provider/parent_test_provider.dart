import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ParentTestProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _questions = [];
  int _currentIndex = 0;
  Map<int, String> selectedAnswers = {};
  bool _isLoading = true;

  List<Map<String, dynamic>> get questions => _questions;
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;

  Future<void> loadQuestions() async {
    try {
      final String response =
          await rootBundle.loadString('assets/questions.json');
      final List<dynamic> data = json.decode(response);
      _questions = List<Map<String, dynamic>>.from(data);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error loading questions: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void setSelectedAnswer(int index, String value) {
    selectedAnswers[index] = value;
    notifyListeners();
  }

  String? getSelectedAnswer(int index) {
    return selectedAnswers[index];
  }

  void clearAnswer(int index) {
    selectedAnswers.remove(index);
    notifyListeners();
  }
}
