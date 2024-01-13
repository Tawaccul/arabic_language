import 'package:flutter/material.dart';
import 'package:flutter_quran_words/games/collect_word/home_page.dart';
import 'package:flutter_quran_words/games/match_game/match_game.dart';
import 'package:flutter_quran_words/games/missing_word/context_word.dart';

class GamesMainPage extends StatefulWidget {
  @override
  _GamesMainPageState createState() => _GamesMainPageState();
}

class _GamesMainPageState extends State<GamesMainPage>  implements GameChangeListener{
  GameProgressManager gameProgressManager = GameProgressManager();

  late List<Widget> games;
  int currentGameIndex = 0;
  int progress = 0;
  int totalSteps = 15;

  @override
  void initState() {
    super.initState();
   
   gameProgressManager.setGameChangeListener(this);
  
     games = [
    // Здесь добавьте ваши игры
    MissingWordGame(onGameCompleted: switchToNextGame,),
     MatchGame(onGameCompleted: switchToNextGame,),
     CollectWordGame(onGameCompleted: switchToNextGame,),
    // PuzzleGame(),
    // SwipeGame(),
    // MainQuestionsPage()
  ];

    switchToNextGame();
  }

   void switchToNextGame() {
    setState(() {
      if (currentGameIndex < totalSteps -1  ) {
        currentGameIndex++;
      } else {
        currentGameIndex = 0; // Loop back to the first game
      }
      
        if (progress < totalSteps) {
        // Check if the current game is CollectWordGame and subscribe to its completion
        if (games[currentGameIndex] is CollectWordGame) {
          (games[currentGameIndex] as CollectWordGame).onGameCompleted = switchToNextGame;
        }

      progress++;
    }});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Switcher'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child:
          games[currentGameIndex]),
          SizedBox(height: 20),
          LinearProgressIndicator(
            value: progress / totalSteps,
          ),
        ],
      ),
    );
  }
  

  @override
  void dispose() {
    // Remove this page as the listener when the widget is disposed
   gameProgressManager.setGameChangeListener(this);
    super.dispose();
  }

  @override
  void onGameChanged(int gameIndex) {
    // Switch to the next game based on the index
    setState(() {
      currentGameIndex = gameIndex;
    });
  }
  
  @override
  void onAllGamesCompleted() {
    // TODO: implement onAllGamesCompleted
  }
}


class GameProgressManager {
  static final GameProgressManager _instance = GameProgressManager._internal();

  factory GameProgressManager() {
    return _instance;
  }

  GameProgressManager._internal();

  int currentGameIndex = 0;
  int totalGames = 3;

  GameChangeListener? _gameChangeListener;

  void setGameChangeListener(GameChangeListener listener) {
    _gameChangeListener = listener;
  }

  void switchToNextGame() {
    currentGameIndex++;

    if (currentGameIndex < totalGames) {
      if (_gameChangeListener != null) {
        _gameChangeListener!.onGameChanged(currentGameIndex);
      } else {
        print("GameChangeListener is not set.");
      }
    } else {
      if (_gameChangeListener != null) {
        _gameChangeListener!.onAllGamesCompleted();
      } else {
        print("GameChangeListener is not set.");
      }
    }
  }
}

abstract class GameChangeListener {
  void onGameChanged(int gameIndex);
  void onAllGamesCompleted();
}
