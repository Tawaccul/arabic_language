import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyGame(),
    );
  }
}

class MyGame extends StatefulWidget {
  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  List<String> targetWord = ['П', 'р', 'а', 'в', 'д', 'а'];
  List<String> draggedLetters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTargetContainer(),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (String letter in targetWord)
                buildDraggable(letter),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTargetContainer() {
    return Container(
      width: 240,
      height: 50,
      color: Colors.grey,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (String letter in draggedLetters)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  letter,
                  style: TextStyle(fontSize: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDraggable(String letter) {
    return Draggable<String>(
      data: letter,
      child: Container(
        width: 40,
        height: 40,
        color: Colors.blue,
        child: Center(
          child: Text(
            letter,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      feedback: Container(
        width: 40,
        height: 40,
        color: Colors.blue.withOpacity(0.5),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      childWhenDragging: Container(),
      onDragCompleted: () {
        setState(() {
          draggedLetters.add(letter);
        });
      },
    );
  }
}
