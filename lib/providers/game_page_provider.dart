// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int maxQuestion = 10;

  List? questions;
  int _currentQuestionCount = 0;
  int _correctCount = 0;

  String difficultyLevel;

  BuildContext context;
  GamePageProvider({required this.context, required this.difficultyLevel}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromApi();
    print(difficultyLevel);
  }

  Future<void> _getQuestionsFromApi() async {
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': difficultyLevel,
      },
    );
    var _data = jsonDecode(
      _response.toString(),
    );
    questions = _data['results'];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]['question'];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]['correct_answer'] == _answer;
    _correctCount += isCorrect ? 1 : 0;
    _currentQuestionCount++;
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          icon: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      },
    );
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    Navigator.pop(context);
    if (_currentQuestionCount == maxQuestion) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "End of Game!",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          content: Text(
            "Scores: $_correctCount/$maxQuestion",
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        );
      },
    );

    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
