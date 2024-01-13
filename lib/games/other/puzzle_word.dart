import 'package:flutter/material.dart';




class PuzzleGame extends StatefulWidget {
  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  List<List<String>> puzzle = [
    ['Л', 'О', 'В'],
    ['П', 'Т', 'Ж'],
    ['А', 'М', 'Ь'],
  ];

  List<List<bool>> selected = [
    [false, false, false],
    [false, false, false],
    [false, false, false],
  ];

  List<Offset> lineOffsets = [];

  String currentWord = '';
  List<String> collectedWords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Puzzle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Отображаем выбранные буквы наверху
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  return Row(
                    children: List.generate(3, (j) {
                      if (selected[i][j]) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(),
                            ),
                            child: Text(puzzle[i][j]),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                  );
                }),
              ),
            ),
            // Отображаем сетку пазла
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (j) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selected[i][j] = !selected[i][j];
                          if (selected[i][j]) {
                            lineOffsets.add(getCellCenter(i, j));
                            currentWord += puzzle[i][j];
                          } else {
                            lineOffsets.clear();
                            currentWord = '';
                          }
                          // Проверяем, собрано ли слово "ПЛОВ"
                          if (currentWord == 'ПЛОВ') {
                            // Показываем диалоговое окно
                            _showDialog();
                            // Сбрасываем состояние игры
                            _resetGame();
                          }
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected[i][j] ? Colors.blue : Colors.white,
                          border: Border.all(),
                        ),
                        child: Text(puzzle[i][j]),
                      ),
                    );
                  }),
                );
              }),
            ),
          ],
        ),
      ),
      // Рисуем линию с использованием CustomPaint
      bottomSheet: Container(
        height: 100,
        child: CustomPaint(
          painter: LinePainter(lineOffsets),
        ),
      ),
    );
  }

  Offset getCellCenter(int i, int j) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    double cellSize = 50;
    double x = renderBox.size.width / 2 + (j - 1) * cellSize;
    double y = renderBox.size.height / 2 + (i - 1) * cellSize;
    return Offset(x, y);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Правильный ответ!'),
          content: Text('Вы собрали слово "ПЛОВ"'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      selected = [
        [false, false, false],
        [false, false, false],
        [false, false, false],
      ];
      lineOffsets.clear();
      currentWord = '';
      collectedWords.add('ПЛОВ'); // Добавляем слово в список собранных слов
    });
  }
}

class LinePainter extends CustomPainter {
  final List<Offset> points;

  LinePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}