import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran_words/words/words_db.dart';

class MatchGame extends StatefulWidget {
  final VoidCallback onGameCompleted;

  MatchGame({required this.onGameCompleted});
  @override
  _MatchGameState createState() => _MatchGameState();
}
class _MatchGameState extends State<MatchGame> with TickerProviderStateMixin {
  List<ItemModel> items = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  
  bool _isPairBeingChecked = false;
  LinearGradient _backgroundGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
        Color.fromRGBO(241, 253, 241, 100),
        Color.fromRGBO(241, 253, 241, 100),
    ],
  );

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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isPairBeingChecked = false;
        });
      }
    });

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.addListener(() {
      setState(() {}); // Redraw on each animation frame
    });
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: _backgroundGradient,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * _animation.value,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color.fromRGBO(175, 210, 164, 1),
                    const Color.fromRGBO(195, 252, 186, 1),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(

         child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              Container(
  child: Expanded( 
    child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Количество столбцов
      crossAxisSpacing: 8.0, // Расстояние между столбцами
      mainAxisSpacing: 8.0, // Расстояние между строками
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
      ItemModel item = items[index];

      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: const Color.fromARGB(0, 105, 240, 175),
          foregroundColor: const Color.fromRGBO(17, 51, 86, 0.8),
          backgroundColor: item == selectedArabicWord || item == selectedRussianWord
          
              ? const Color.fromRGBO(195, 252, 186, 1)
              : const Color.fromRGBO(195, 252, 186, 0.4),
          elevation: 1,
          disabledBackgroundColor: const Color.fromRGBO(195, 252, 186, 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(
              width: 2,
              color: item == selectedArabicWord || item == selectedRussianWord
                  ? const Color.fromRGBO(158, 255, 158, 100)
                  : const Color.fromARGB(158, 158, 255, 100),
            ),
          ),
        ),
        onPressed: item.isMatched ? null : () {
          _onWordClick(item);
        },
        child: Text(
          item.original,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      );
    },
  ),
)),
            
          ],
        ),
      )),
    ]));
  }
void _onWordClick(ItemModel item) {
  setState(() {
    if (item.isMatched || item.isSelected) {
      // Если слово уже совпало или выбрано, игнорируем
      return;
    }

    if (selectedArabicWord.original.isEmpty) {
      // Первый выбор
      selectedArabicWord = item;
      selectedArabicWord.isSelected = true;
    } else {
      // Второй выбор
      selectedRussianWord = item;
      selectedRussianWord.isSelected = true;

      // Проверка на соответствие перевода
      if (selectedArabicWord.translation == selectedRussianWord.original &&
          selectedRussianWord.translation == selectedArabicWord.original) {
        // Правильная пара
        score += 10;

        selectedArabicWord.isMatched = true;
        selectedRussianWord.isMatched = true;

        if (items.every((item) => item.isMatched)) {
          _controller.forward();
          gameOver = true;
          widget.onGameCompleted();
        }
      } else {
        // Неправильная пара
        // Отнимаем очки только если выбранные пары - это переводы
        if (selectedArabicWord.original.isNotEmpty &&
            selectedRussianWord.original.isNotEmpty &&
            item.original == item.translation) {
          score -= 5;
        }

        // Сбрасываем выбранные слова
        selectedArabicWord.isSelected = false;
        selectedRussianWord.isSelected = false;
      }

      // Сбрасываем выбранные слова
      selectedArabicWord = ItemModel(original: '', translation: '', buttonColor: Colors.greenAccent, isSelected: false);
      selectedRussianWord = ItemModel(original: '', translation: '', buttonColor: Colors.greenAccent, isSelected: false);
    }
  });
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
