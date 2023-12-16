import 'package:flutter/material.dart';




class SixGame extends StatefulWidget {
  const SixGame({super.key});

  @override
  _SixGameState createState() => _SixGameState();
}

class _SixGameState extends State<SixGame> with SingleTickerProviderStateMixin {
List<String> arabicWords = ['كلمة1', 'كلمة2', 'كلمة3'];
  List<IconData> icons = [Icons.star, Icons.favorite, Icons.send];

  late List<int> shuffledIndices;
  late List<bool> selectedCircles;

  @override
  void initState() {
    super.initState();
    shuffledIndices = List.generate(6, (index) => index)..shuffle();
    selectedCircles = List.generate(6, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Кружки и слова'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.red],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: List.generate(6, (index) {
              return selectedCircles[index]
                  ? SizedBox.shrink()
                  : GestureDetector(
                      onTap: () {
                        _onCircleTap(index);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(
                            color: selectedCircles[index] ? Colors.blueAccent : Colors.transparent,
                            width: 3.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.transparent,
                          child: _buildCircleContent(index),
                        ),
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleContent(int index) {
    int originalIndex = shuffledIndices[index];
    if (originalIndex < 3) {
      return Text(
        arabicWords[originalIndex],
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Icon(
        icons[originalIndex - 3],
        color: Colors.white,
      );
    }
  }

  void _onCircleTap(int index) {
    setState(() {
      if (selectedCircles[index]) {
        return; // уже выбран
      }

      selectedCircles[index] = true;

      List<int> selectedIndices = selectedCircles.asMap().entries.where((entry) => entry.value).map((entry) => entry.key).toList();

      if (selectedIndices.length == 2) {
        int firstIndex = selectedIndices[0];
        int secondIndex = selectedIndices[1];

        int originalFirstIndex = shuffledIndices[firstIndex];
        int originalSecondIndex = shuffledIndices[secondIndex];

        if (originalFirstIndex ~/ 3 == originalSecondIndex ~/ 3) {
          // Matching pair found, hide the circles
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              selectedCircles[firstIndex] = true;
              selectedCircles[secondIndex] = true;
            });
          });
        } else {
          // No match, reset the selection
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              selectedCircles[firstIndex] = false;
              selectedCircles[secondIndex] = false;
            });
          });
        }
      }
    });
  }
}