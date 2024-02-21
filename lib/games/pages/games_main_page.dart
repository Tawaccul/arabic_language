import 'package:flutter/material.dart';
import 'package:flutter_quran_words/components/progress_bar.dart';
import 'package:flutter_quran_words/games/collect_word/home_page.dart';
import 'package:flutter_quran_words/games/match_game/pages/match_game.dart';
import 'package:flutter_quran_words/games/missing_word/context_word.dart';
import 'package:flutter_quran_words/games/puzzle_word/gamewithcontainers.dart';

import '../collect_word/controller.dart';

class GamesMainPage extends StatefulWidget {
  @override
  GamesMainPageState createState() => GamesMainPageState();
}

class GamesMainPageState extends State<GamesMainPage>  {
  late List<Widget> games;
  int currentGameIndex = 0;
  int progress = 0;
  int totalSteps = 5;
  late Controller controller;

  late GameProvider gameProvider; // Add this line

  @override
  void initState() {
    super.initState();
    gameProvider = GameProvider(); // Initialize GameProvider
    games = [
      Container(),
      MissingWordGame(onGameCompleted: switchToNextGame),
      MatchGame(onGameCompleted: switchToNextGame),
      CollectWordGame( onGameCompleted: switchToNextGame),
      DrawPatternGame(onGameCompleted: switchToNextGame),
    ];

    switchToNextGame();
  }

  Future<void> switchToNextGame() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      if (currentGameIndex < totalSteps - 1) {
        currentGameIndex++;
      } else {
        currentGameIndex = 0; // Loop back to the first game
      }
      progress++;

      // Call switchToNextGame of GameProvider
      gameProvider.switchToNextGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 253, 241, 100),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(20), child: GlobalProgressBar(value: progress, steps: totalSteps)),
          Expanded(
              child: games.isNotEmpty ? games[currentGameIndex] : Text('пусто')) ,
          SizedBox(height: 20),
        ],
      ),
    );
  }
}



class GameProvider extends ChangeNotifier {
  int _currentGameIndex = -1;
  int _totalGames = 5;

  int get currentGameIndex => _currentGameIndex;

  void switchToNextGame() {
    _currentGameIndex++;

    if (_currentGameIndex < _totalGames) {
      notifyListeners(); // Notify listeners to trigger a rebuild
    } else {
      // All games completed, you can perform the appropriate actions
      print('All games completed');
    }
  }
}
