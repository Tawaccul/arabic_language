import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_quran_words/games/collect_word/fly_in_animation.dart';
import 'package:flutter_quran_words/games/collect_word/progress_bar.dart';
import 'package:flutter_quran_words/games/pages/games_main_page.dart';
import 'package:provider/provider.dart';
import 'all_words.dart';
import 'controller.dart';
import 'drag.dart';
import 'drop.dart';



class CollectWordGame extends StatefulWidget {
  final VoidCallback onGameCompleted;
  CollectWordGame({Key? key, required this.onGameCompleted}) : super(key: key);

  @override
  State<CollectWordGame> createState() => CollectWordGameState();

}

GlobalKey<CollectWordGameState> _collectWordGameStateKey = GlobalKey();

  bool _isGameCompleted = false;

class CollectWordGameState extends State<CollectWordGame>  {
  List<String> _words = allWords.toList();
  late String _word, _dropWord;



@override
  void initState() {
    super.initState();
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
      builder: (_, generate, controller) {
        if (generate && _words.isNotEmpty) {
        _generateWord();
        }
        
        return SafeArea(
          child: Stack(
            children: [
              Container(
                color: const Color.fromARGB(255, 241, 255, 241),
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
                            color: Color.fromARGB(255, 255, 253, 246),
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
                                        child: Text('d')),
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
                          child: Text('f'))),
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
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}