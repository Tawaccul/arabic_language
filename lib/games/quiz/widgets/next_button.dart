import 'package:flutter/material.dart';
import 'package:flutter_quran_words/games/quiz/models/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     width: double.infinity,
     decoration: BoxDecoration(
      color: neutral,
      borderRadius: BorderRadius.circular(10.0),
     ),
     padding: const EdgeInsets.symmetric(vertical: 10),
     child: Text(
      'Next question',
      style: TextStyle(),
      textAlign: TextAlign.center,
     ),
    );
  }
}