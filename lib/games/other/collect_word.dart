
import 'package:flutter/material.dart';
import 'package:flutter_quran_words/check_words.dart';
import 'package:flutter_quran_words/games/quiz/pages/main_questions_page.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter_quran_words/words/words_db.dart';





class CollectWord extends StatefulWidget {
  @override


  _CollectWord createState() => _CollectWord();
}

class _CollectWord extends State<CollectWord> {


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const MainQuestionsPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  const curve = Curves.ease;

  final tween = Tween(begin: begin, end: end);
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );

  return SlideTransition(
    position: tween.animate(curvedAnimation),
    child: child,
  );
    },
  );
}

   List<MatchWords> _wordList = [];
     
  List<String>? _currentWord;
  List<String?> container = [null, null, null];
  int nextIndex = 0;
  int _wordsIndex = 0;

  int _correctAnswers = 0;
  int _incorrectAnswers = 0;
  late Timer timer;
  int secondsRemaining = 60;
  List<List<Offset>> _wordCoordinates = [];

  @override
  void initState() {
    super.initState();
    startTimer();
    _wordList = Database().matchWords;
    _setupCurrentWord();
  }

  void _setupCurrentWord() {
  setState(() {
    // Retrieve a random word from the database
    String currentWord = _wordList[_wordsIndex].value.keys.first;
    _currentWord = currentWord.split('');
    container = List<String?>.filled(_currentWord!.length, null);
  });
}



  void _handleAnswer() {
    // Check if the collected letters form the correct word
    String collectedWord = container.join();
    
    if (collectedWord == _currentWord!.join()) {
      // Handle correct answer
    } else {
      // Handle incorrect answer
    }

    _generateRandomWord();
  }

 void _generateRandomWord() {
    setState(() {
      // Reset indices and prepare for the next word
      nextIndex = 0;
      _wordsIndex++;
      if (_wordsIndex < _wordList.length) {
        _setupCurrentWord();
      } else {
        // Handle end of the game
        _showResults();
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          // Таймер истек, сброс игры и таймера
          resetGame();
          timer.cancel();
          _showResults();
        }
      });
    });
  }

  
  void _showResults() {
    // Вывести результаты игры (например, через диалоговое окно)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Результаты игры'),
          content: Text('Правильных ответов: $_correctAnswers\n'
              'Неправильных ответов: $_incorrectAnswers'),
          actions: [
            TextButton(
              onPressed: () {
                // Закройте диалог и сбросьте состояние для новой игры
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  


  
  void resetGame() {
    // Сбросить состояние игры и таймера
    setState(() {
      container = [null, null, null];
      nextIndex = 0;
      secondsRemaining = 10;
    });
  }

 double _getRandomCoordinate(double max) {
    return Random().nextDouble() * max;
  }

   List<Offset> _generateRandomCoordinates() {
    return List.generate(
      _wordList[_wordsIndex].value.length,
      (index) => Offset(
        _getRandomCoordinate(200),
        _getRandomCoordinate(200),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Move Letters'),
      ),
       body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the letters of the current word
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _currentWord!.map((letter) {
              return Draggable<String>(
                data: letter,
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      letter,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                feedback: Material(
                  child: Container(
                    width: 30,
                    height: 30,
                    color: Colors.blue.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        letter,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(),
              );
            }).toList(),
          ),

          

       Container(
  height: 50,
  width: 400,
  color: Colors.grey,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(container.length, (index) {
      return DragTarget<String>(
        builder: (context, candidateData, rejectedData) {
          return Container(
            height: 30,
            width: 30,
            child: Center(
              child: Text(
                container[index] ?? '',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          );
        },
        onWillAccept: (data) => container[index] == null,
       onAccept: (data) {
  if (nextIndex < _currentWord!.length && data == _currentWord![nextIndex]) {
    setState(() {
      container[index] = data;
      nextIndex++;
      if (nextIndex == _currentWord!.length) {
        // All letters of the word are collected, proceed to the next word
        _wordsIndex++;
        nextIndex = 0;
        if (_wordsIndex < _wordList.length) {
          _setupCurrentWord();
        } else {
          // All words are completed
          _showResults();
        }
      }
    });
  }
},

      );
    }),
  ),
),
          Text(
            'Time remaining: $secondsRemaining seconds',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
