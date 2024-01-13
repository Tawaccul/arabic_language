import 'package:flutter/material.dart';
import 'package:flutter_quran_words/words/words_db.dart';

class MatchGame extends StatefulWidget {
  final VoidCallback onGameCompleted;

  MatchGame({required this.onGameCompleted});
  @override
  _MatchGameState createState() => _MatchGameState();
}
class _MatchGameState extends State<MatchGame> {
  List<ItemModel> items = [];
  bool _levelCompleted = false;

  late int score;
  late bool gameOver;
  var _matchGame = Database().matchWords;

  late ItemModel selectedArabicWord;
  late ItemModel selectedRussianWord;

  @override
  void initState() {
    super.initState();
    initGame();
  }

void initGame() {
  for (MatchWords matchWords in _matchGame) {
    if (matchWords.value.containsKey('firstLevel')) {
      List<Map<String, String>> firstLevelList = matchWords.value['firstLevel'] as List<Map<String, String>>;
      for (Map<String, String> wordMap in firstLevelList) {
        String arabicWord = wordMap['arabic'] ?? '';
        String russianWord = wordMap['russian'] ?? '';

        items.add(ItemModel(
          translation: russianWord,
          original: arabicWord,
        ));
        items.add(ItemModel(
          translation: arabicWord,
          original: russianWord,
        ));
      }
    }
  }

  items.shuffle();

  gameOver = false;

  score = 0;
  selectedArabicWord = ItemModel(original: '', translation: '', buttonColor: Colors.greenAccent);
  selectedRussianWord = ItemModel(original: '', translation: '', buttonColor: Colors.greenAccent);

  if (items.isEmpty) {
    gameOver = true;
    widget.onGameCompleted(); // Callback when the game is completed
  }
}


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Matching Game'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Text.rich(TextSpan(children: [
              TextSpan(text: "Score: "),
              TextSpan(
                text: "$score",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              )
            ])),
            if (!gameOver)
              Container(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: items
                      .map(
                        (item) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            foregroundColor: Colors.white,
                            backgroundColor: item == selectedArabicWord || item == selectedRussianWord
                                ? const Color.fromARGB(255, 168, 236, 203)
                                : Colors.greenAccent,
                            elevation: 5,
                            disabledBackgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: item == selectedArabicWord || item == selectedRussianWord
                                    ? Color.fromARGB(255, 33, 33, 33)
                                    : const Color.fromARGB(0, 105, 240, 175),
                              ),
                            ),
                          ),
                          onPressed: item.isMatched ? null : () {
                            _onWordClick(item);
                          },
                          child: Text(
                            item.original,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            if (gameOver)
              Text(
                "GameOver",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            if (gameOver)
              Center(
                child: ElevatedButton(
                  child: Text("New Game"),
                  onPressed: () {
                    initGame();
                    setState(() {});
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  void _onWordClick(ItemModel item) {
    if (!item.isSelected && !item.isMatched) {
      setState(() {
        if (selectedArabicWord.original.isEmpty) {
          selectedArabicWord = item;
        } else {
          selectedRussianWord = item;
        }

       if (selectedArabicWord.original.isNotEmpty && selectedRussianWord.original.isNotEmpty) {
        if (selectedArabicWord.translation == selectedRussianWord.original ||
            selectedRussianWord.translation == selectedArabicWord.original) {
          // Правильная пара
          score += 10;

          // Устанавливаем флаг isMatched для предотвращения дальнейшего выбора
          selectedArabicWord.isMatched = true;
          selectedRussianWord.isMatched = true;

          // Сброс выбора для следующей пары слов
          selectedArabicWord = ItemModel(original: '', translation: '', buttonColor: Colors.greenAccent, isSelected: false);
          selectedRussianWord = ItemModel(original: '', translation: '', buttonColor: Colors.greenAccent, isSelected: false);

          // Check if the game is completed after each correct match
          if (items.every((item) => item.isMatched)) {
            gameOver = true;
            widget.onGameCompleted(); // Callback when the game is completed
          } else {
            // Неправильная пара

            // Сброс выбора для всех слов при неверном выборе
            items.forEach((item) {
              item.buttonColor = Colors.greenAccent;
              item.isSelected = false;
            });

            // Сброс выбора для следующей пары слов
            selectedArabicWord = ItemModel(original: '', translation: '', buttonColor: Colors.greenAccent, isSelected: false);
            selectedRussianWord = ItemModel(original: '', translation: '', buttonColor: Colors.greenAccent, isSelected: false);
          }
        }
    }});
    }
  }
}

// Rest of your code remains the same

  class ItemModel {
    final String original;
    final String translation;
    Color buttonColor;
    bool isSelected;
    bool isMatched;

    ItemModel({
      required this.original,
      required this.translation,
      this.buttonColor = Colors.greenAccent,
      this.isSelected = false,
      this.isMatched = false,
    });
  }
