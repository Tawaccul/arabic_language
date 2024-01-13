import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_quran_words/games/collect_word/fly_in_animation.dart';
import 'package:flutter_quran_words/games/collect_word/progress_bar.dart';
import 'package:flutter_quran_words/games/pages/games_main_page.dart';
import 'package:provider/provider.dart';
import 'all_words.dart';
import 'controller.dart';
import 'drag.dart';
import 'drop.dart';



class CollectWordGame extends StatefulWidget {
   VoidCallback onGameCompleted;

  CollectWordGame({Key? key, required this.onGameCompleted}) : super(key: key);

  @override
  State<CollectWordGame> createState() => _CollectWordGameState();
  
  void onCurrentGameCompleted() {
    // Этот метод будет вызываться, когда текущая игра завершится
    _CollectWordGameState? state = _collectWordGameStateKey.currentState;
    state?.handleGameCompleted();
  }
}

GlobalKey<_CollectWordGameState> _collectWordGameStateKey = GlobalKey();


class _CollectWordGameState extends State<CollectWordGame> implements GameChangeListener {
  List<String> _words = allWords.toList();
  late String _word, _dropWord;
  late GameProgressManager _gameProgressManager;

   void handleGameCompleted() {
    // Вызовем метод, переданный в виджете, при завершении текущей игры
    widget.onGameCompleted();
  }

  _generateWord() {
    final r = Random().nextInt(_words.length);
    _word = _words[r];
    _dropWord = _word;
    _words.removeAt(r);
    final s = _word.characters.toList()..shuffle();
    _word = s.join();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setUp(total: _word.length);
      Provider.of<Controller>(context, listen: false)
          .requestWord(request: false);
    });
  }


  _animationCompleted() {
    Future.delayed(const Duration(milliseconds: 200), () {
      Provider.of<Controller>(context, listen: false)
          .updateLetterDropped(dropped: false);
    });


  } 


  @override
  Widget build(BuildContext context) {
    return Selector<Controller, bool>(
      selector: (_, controller) => controller.generateWord,
      builder: (_, generate, __) {
        if (generate) {
          if (_words.isNotEmpty) {
            _generateWord();
          }
        }
        return SafeArea(
          child: Stack(
            children: [
              Container(
                color: Colors.lightBlue,
              ),
              Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 195, 189, 170),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(18, 2, 2, 2),
                                  child: FittedBox(
                                    child: Text(
                                      'Spelling Bee',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Selector<Controller, bool>(
                                    selector: (_, controller) =>
                                        controller.letterDropped,
                                    builder: (_, dropped, __) => FlyInAnimation(
                                        removeScale: true,
                                        animate: dropped,
                                        animationCompleted:
                                            _animationCompleted(),
                                        child: Image.asset(
                                            'assets/images/Qaaba.jpg')),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))),
                  Expanded(
                      flex: 3,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _dropWord.characters
                              .map((e) => FlyInAnimation(
                                    animate: true,
                                    child: Drop(
                                      letter: e,
                                    ),
                                  ))
                              .toList())),
                  Expanded(
                      flex: 3,
                      child: FlyInAnimation(
                          animate: true,
                          child: Image.asset('assets/images/Qaaba.jpg'))),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _word.characters
                          .map(
                            (e) => FlyInAnimation(
                              animate: true,
                              child: Drag(
                                letter: e,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const Expanded(flex: 1, child: ProgressBar()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  
  @override
  void onAllGamesCompleted() {
    // TODO: implement onAllGamesCompleted
  }
  
  @override
  void onGameChanged(int gameIndex) {
    // TODO: implement onGameChanged
  }
}