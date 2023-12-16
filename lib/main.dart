import 'package:flutter/material.dart';
import 'package:flutter_quran_words/games/drag_and_drop_level.dart';
import 'package:flutter_quran_words/games/find_word.dart';
import 'package:flutter_quran_words/games/full_word_level.dart';
import 'package:flutter_quran_words/games/game_6.dart';
import 'package:flutter_quran_words/games/game_swipe.dart';
import 'package:flutter_quran_words/pages/homeScreen/home_screen.dart';
import 'package:flutter_quran_words/pages/home_page.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();

  
  runApp( MyApp());
}

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
        '/': (context) => MyHomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/firstgame': (context) => FirstTypeOfGame(),
        '/secondgame': (context) => const FullWord(),
        '/thirdgame': (context) => const SwipeGame(),
        '/sixsgame': (context) => const SixGame()
      },
    );
  }
}
