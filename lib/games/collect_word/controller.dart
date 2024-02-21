import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran_words/games/collect_word/home_page.dart';
import 'package:flutter_quran_words/games/pages/games_main_page.dart';

import 'all_words.dart';
import 'message_box.dart';




class Controller extends ChangeNotifier {
  int totalLetters = 0, lettersAnswered = 0, wordsAnswered = 0;
  bool generateWord = true, sessionCompleted = false, letterDropped = false;
  double percentCompleted = 0;

  setUp({required int total}) {
    lettersAnswered = 0;
    totalLetters = total;
    notifyListeners();
  }

  incrementLetters({required BuildContext context}) {
    lettersAnswered++;
    updateLetterDropped(dropped: true);
    if (lettersAnswered == totalLetters) {
      wordsAnswered++;
      percentCompleted = wordsAnswered / allWords.length;
      if (wordsAnswered == allWords.length) {
        sessionCompleted = true;
       GameProvider().switchToNextGame();
        print('FINISH');
        notifyListeners();
      }
    }
    notifyListeners();
  }

  requestWord({required bool request}) {
    generateWord = request;
    notifyListeners();
  }

  updateLetterDropped({required bool dropped}) {
    letterDropped = dropped;
    notifyListeners();
  }

  reset() {
    sessionCompleted = false;
    wordsAnswered = 0;
    generateWord = true;
    percentCompleted = 0;
  }
}
