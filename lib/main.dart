import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'package:flutter/material.dart';
import 'package:flutter_quran_words/dragdrop.dart';
import 'package:flutter_quran_words/games/other/collect_word.dart';
import 'package:flutter_quran_words/games/collect_word/controller.dart';
import 'package:flutter_quran_words/games/collect_word/home_page.dart';
import 'package:flutter_quran_words/games/missing_word/context_word.dart';
import 'package:flutter_quran_words/games/other/find_word.dart';
import 'package:flutter_quran_words/games/puzzle_word/gamewithcontainers.dart';
import 'package:flutter_quran_words/games/pages/games_main_page.dart';
import 'package:flutter_quran_words/pages/homePage/Screens/homeScreen/home_screen.dart';
import 'package:flutter_quran_words/games/other/puzzle_word.dart';
import 'package:flutter_quran_words/pages/home_page.dart';
import 'package:flutter_quran_words/games/quiz/models/db_connects.dart';
import 'package:flutter_quran_words/games/quiz/models/question_models.dart';
import 'package:flutter_quran_words/games/quiz/pages/main_questions_page.dart';
import 'package:provider/provider.dart';
import 'auth/firebase_options.dart';
import 'package:flutter_quran_words/games/other/drag_and_drop_level.dart';
import 'package:flutter_quran_words/games/other/full_word_level.dart';
import 'package:flutter_quran_words/games/match_game/pages/match_game.dart';
import 'package:flutter_quran_words/games/swipe_game/game_swipe.dart';


void main()  async {
  var db = DBconnect();
  //db.addQuestion(
    // Questions(
    // id: '20', 
    // title: 'First Surah from Quran?', 
    // options: {
    //   'Fatiha': true,
    //   'Baqarah' : false,
    //   'Maryam' : false,
    //   'An-nisa' : false
    // })
    // 
    db.fetchQuestions();
    ;

  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
runApp(ChangeNotifierProvider(
      create: (_) => Controller(), child:  MyApp()));}

class MyApp extends StatelessWidget {
 

  // This widget is the root of your application.

  
  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => DrawPatternGame( onGameCompleted: (){},),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/firstgame': (context) => FirstTypeOfGame(),
        '/secondgame': (contewxt) => const FullWord(),
        '/thirdgame': (context) => const SwipeGame(),
        '/sixsgame': (context) =>  GamesMainPage()
      },
    );
  }
}
