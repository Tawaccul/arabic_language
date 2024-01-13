import 'package:flutter/material.dart';
import 'package:flutter_quran_words/games/quiz/models/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({super.key, required this.result, required this.questionLength, required this.OnPressed});

  final int result;
  final int questionLength;
  final VoidCallback OnPressed;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                const Text(
                  'Result', 
                   style: TextStyle(color: neutral, fontSize: 22),
                   ),
                   const SizedBox(height: 20,),
                   CircleAvatar( 
                    child: Text(
                      '$result/$questionLength',
                      style: TextStyle(fontSize: 22),
                      ),
                    radius: 70,
                    backgroundColor: result == questionLength/2 
                       ? Colors.amber 
                       : result < questionLength / 2 
                        ? incorrect 
                        : correct 
                   ),
                   SizedBox(height: 20,),
                   Text(result == questionLength/2 
                       ? 'Almost' 
                       : result < questionLength / 2 
                        ? 'Try again?' 
                        : 'Great!',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white
                        ),),
                        const SizedBox(height: 25,),
                        GestureDetector(
                          onTap: OnPressed,
                          child: const Text(
                          'Start Over', 
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.0)),)
        ],
      ),),
    );
  }
}