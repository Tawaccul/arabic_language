import 'package:flutter/material.dart';
import 'package:flutter_quran_words/games/quiz/models/constants.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key, required this.question, required this.indexAction, required this.totalQuestions, });


  final String question;
  final int indexAction;
  final int totalQuestions;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Question ${indexAction+1}/$totalQuestions: $question',
         style: TextStyle(
         fontSize: 24, 
         color: neutral),
          ),
      
    );
  }
}