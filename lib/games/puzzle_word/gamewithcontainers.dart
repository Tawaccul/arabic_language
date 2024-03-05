import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vibration/vibration.dart';
import 'package:flutter/services.dart';


class DrawPatternGame extends StatefulWidget {
  final VoidCallback onGameCompleted;
  const DrawPatternGame({required this.onGameCompleted});
  @override
  State<DrawPatternGame> createState() => _DrawPatternGameState();
}

class _DrawPatternGameState extends State<DrawPatternGame> {
  List<String> stringList = ["E", "L", "A", "K", "İ", "N", "U", "G", "D"];
  List<String> selectedLetter = [];
  String finalWordFromBase = 'LAN';
  double radius = 80;
  List<Offset> endLineOffsetList = [];
  List<Offset> letterOffsetList = [];

  LinearGradient _backgroundGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
        Color.fromRGBO(241, 253, 241, 100),
        Color.fromRGBO(241, 253, 241, 100),
    ],
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
 decoration: BoxDecoration(
              gradient: _backgroundGradient,
            ),        child:
      Column(
        
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 400,
            child: Center(
                child: Container(
              padding: selectedLetter.isNotEmpty
                  ? EdgeInsets.fromLTRB(8, 8, 8, 0)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(195, 252, 186, 1), borderRadius: BorderRadius.circular(0)),
              child: Text(
                selectedLetter.toSet().join(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 10,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
          ),
          Container(
            
            child: GestureDetector(
              
              onPanStart: (details) {

                Offset correctedOffset = Offset(details.localPosition.dx - 104,
                    details.localPosition.dy - 104);
                for (var i = 0; i < letterOffsetList.length; i++) {
                  if ((correctedOffset - (letterOffsetList[i])).distance < 24 &&
                      !selectedLetter.contains(stringList[i])) {
                    selectedLetter.add(stringList[i]);
                                      Vibration.vibrate(duration: 50); // 50 миллисекунд вибрации, можно изменить по вашему усмотрению

                    print(stringList[i]);
int? bar;
 bool? foo;
 print(bar != foo);
                    endLineOffsetList
                      ..add(letterOffsetList[i])
                      ..add(letterOffsetList[i]);
                    setState(() {});
                    letterOffsetList = [];
                    break;
                  }
                }
              },
              onPanUpdate: (details) {

                if (endLineOffsetList.isNotEmpty &&
                    selectedLetter.length < stringList.length) {
                  Offset correctedOffset = Offset(
                      details.localPosition.dx - 104,
                      details.localPosition.dy - 104);
                  endLineOffsetList[endLineOffsetList.length - 1] =
                      correctedOffset;
                  for (var i = 0; i < letterOffsetList.length; i++) {
                    if ((correctedOffset - (letterOffsetList[i])).distance <
                            24 &&
                        !selectedLetter.contains(stringList[i])) {
                      endLineOffsetList[endLineOffsetList.length - 1] =
                          letterOffsetList[i];
                      selectedLetter.add(stringList[i]);                  Vibration.vibrate(duration: 50); // 50 миллисекунд вибрации, можно изменить по вашему усмотрению

                      endLineOffsetList.add(letterOffsetList[i]);
                      print(stringList[i]);
                      Feedback.forTap(context);

                      break;
                    }
                  }
                  setState(() {});
                  letterOffsetList = [];
                }
              },
              onPanEnd: (details) {
               

                setState(() {
                
                  String finalWord = selectedLetter.join();
                  print(finalWord);

                  if(finalWord == finalWordFromBase){
                    widget.onGameCompleted();
                  }
                  
    selectedLetter = [];
     endLineOffsetList = [];
                });
              },
              child:
              Container(
                child:  Stack(
                alignment: Alignment.center,
                
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(241, 253, 241, 0.341),
                    radius: radius + 42,
                  ),
                  CustomPaint(
                    painter: LinePainter(endLineOffsetList: endLineOffsetList),
                  ),
                  ...List.generate(
                    stringList.length,
                    (i) {
                      double xOffset;
    double yOffset;
    if (i < 3) {
      // Левый столбец
      xOffset = -radius;
      yOffset = radius - i * (2 * radius / 2);
    } else if (i < 6) {
      // Средний столбец
      xOffset = 0;
      yOffset = radius - (i - 3) * (2 * radius / 2);
    } else {
      // Правый столбец
      xOffset = radius;
      yOffset = radius - (i - 6) * (2 * radius / 2);
    }

    letterOffsetList.add(Offset(xOffset, yOffset));
                      return Transform.translate(
                        offset: letterOffsetList[i],
                        child: CircleAvatar(
                          backgroundColor:
                              selectedLetter.contains(stringList[i])
                                  ? const Color.fromRGBO(195, 252, 186, 1)
                                  : Color.fromARGB(104, 218, 218, 218),
                          child: Container(
                            width: 42,
                            height: 42,
                            child: Container ( 
                              child: Text(
                              stringList[i],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ),
                      );
                    },
                  )
                ],
              )),
            ),
          )
        ],
      ),
    ));
  }
}

class LinePainter extends CustomPainter {
  final List<Offset>? endLineOffsetList;
  LinePainter({this.endLineOffsetList});
  @override
  void paint(Canvas canvas, Size size) {
  
    var paint = Paint()
      ..color = Color.fromARGB(255, 28, 213, 0)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    if (endLineOffsetList != null && endLineOffsetList!.length >= 2) {
      for (var i = 0; i < endLineOffsetList!.length - 1; ++i) {
        canvas.drawLine(
            endLineOffsetList![i], endLineOffsetList![i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(LinePainter oldDelegate) => true;
}