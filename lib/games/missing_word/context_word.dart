import 'package:flutter/material.dart';
import 'package:flutter_quran_words/components/progress_bar.dart';

class MissingWordGame extends StatefulWidget {
  final VoidCallback onGameCompleted;

  MissingWordGame({required this.onGameCompleted});

  @override
  _MissingWordGameState createState() => _MissingWordGameState();
}

int currentWord = 0;
int currentStep = 0;

class _MissingWordGameState extends State<MissingWordGame> {
  late List<String> _gameWords;
  // final GameController gameController = GameController();

  bool _levelCompleted = false;
  late String _russianSentence;
  late String _translateSentence;
  late List<String> _highlightedWords;
  late String _missingWord;

  int maxSteps = 15;

  late String _currentWord; // Текущее слово для перевода
  late String _displayedPart; // Отображаемая часть предложения

  List<String> getRandomWords(int count) {
    List<String> allWords = [
      'хотел', 'кушать', 'сделать', 'но', 'будет', 'дерево', 'здесь', 'а', 'чтобы', 'не'
    ];
    allWords.shuffle();
    return allWords.take(count).toList();
  }

  @override
  void initState() {
    super.initState();
    _gameWords = [];

    _initGame(); // Инициализация игры
  }

  void _initGame() {
    _russianSentence = "я хотел кушать, но не смог этого сделать";
    _translateSentence = 'I wanted to eat, but I couldnt do it.';
    _highlightedWords = ['wanted', 'but', 'do']; // Изменено, чтобы изначально выделить слова wanted

    _nextStep();
  }

  Widget _highlightWord(String text, List<String> wordsToHighlight) {
    final List<TextSpan> children = [];
    final List<String> words = text.split(' ');

    for (int i = 0; i < words.length; i++) {
      final String word = words[i];
      final bool shouldHighlight = wordsToHighlight.isNotEmpty && wordsToHighlight.first == word;

      children.add(
        TextSpan(
          text: '$word ',
          style: TextStyle(
            fontSize: 24,
            color: shouldHighlight ? Colors.greenAccent : Colors.black,
            fontWeight: shouldHighlight ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: children,
      ),
    );
  }

  void _nextStep() {
    setState(() {
      _gameWords = getRandomWords(10);
      _currentWord = _gameWords[currentWord];
      _missingWord = ['хотел', 'но', 'сделать'][currentWord];
      currentWord++;

      _displayedPart = _russianSentence.split(_missingWord)[0] + '...';
    });

    if (currentWord == 4) {
      currentStep++;

      // Notify the parent widget that the game is completed
      widget.onGameCompleted();
    }
  }
void _checkAnswer(String selectedOption) {
  if (_missingWord.isNotEmpty && selectedOption == _missingWord) {
    setState(() {
      _highlightedWords.removeAt(0);

      if (_highlightedWords.isNotEmpty) {
        _displayedPart = _highlightedWords.join(' ');
      } else {
        // All words are revealed
        _displayedPart = _translateSentence;
        _levelCompleted = true; // Уровень завершен
      }

      if (!_levelCompleted) {
        _nextStep(); // Переход к следующему шагу
      } else {
        // Only switch to the next game if the current step is completed
        widget.onGameCompleted();
      }
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 253, 241, 100),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Directionality(
              textDirection: TextDirection.ltr,
              child: _highlightWord(_translateSentence, _highlightedWords),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Text(
                  _displayedPart,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _gameWords
                  .map(
                    (word) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    if (!_highlightedWords.isEmpty) {
                      _checkAnswer(word);
                    }
                  },
                  child: Text(word),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
