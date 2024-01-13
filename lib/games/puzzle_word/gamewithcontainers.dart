import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';


class DrawPatternGame extends StatefulWidget {
  const DrawPatternGame({Key? key}) : super(key: key);

  @override
  State<DrawPatternGame> createState() => _DrawPatternGameState();
}

class _DrawPatternGameState extends State<DrawPatternGame> {
  List<String> stringList = ["E", "L", "A", "K", "İ", "N", "U", "G"];
  List<String> selectedLetter = [];

  double radius = 80;
  List<Offset> endLineOffsetList = [];
  List<Offset> letterOffsetList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text("Draw Game"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 300,
            child: Center(
                child: Container(
              padding: selectedLetter.isNotEmpty
                  ? EdgeInsets.fromLTRB(8, 8, 8, 0)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(32)),
              child: Text(
                selectedLetter.toSet().join(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 8,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
          ),
          Center(
            child: GestureDetector(
              onPanStart: (details) {
                Offset correctedOffset = Offset(details.localPosition.dx - 104,
                    details.localPosition.dy - 104);
                for (var i = 0; i < letterOffsetList.length; i++) {
                  if ((correctedOffset - (letterOffsetList[i])).distance < 24 &&
                      !selectedLetter.contains(stringList[i])) {
                    selectedLetter.add(stringList[i]);
                    print(stringList[i]);

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
                      selectedLetter.add(stringList[i]);
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
                  showDialog(context: context, builder: (context) => AlertDialog(
                    title: Text("Sonuç"),
                    content: Text(finalWord),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: Text("Tamam"))
                    ],
                  ));
    selectedLetter = [];
     endLineOffsetList = [];
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: radius + 32,
                  ),
                  CustomPaint(
                    painter: LinePainter(endLineOffsetList: endLineOffsetList),
                  ),
                  ...List.generate(
                    stringList.length,
                    (i) {
                      letterOffsetList.add(Offset(
                          radius *
                              math.cos(2 * i * math.pi / stringList.length),
                          radius *
                              math.sin(2 * i * math.pi / stringList.length)));
                      return Transform.translate(
                        offset: letterOffsetList[i],
                        child: CircleAvatar(
                          backgroundColor:
                              selectedLetter.contains(stringList[i])
                                  ? Colors.pink
                                  : null,
                          child: Container(
                            width: 40,
                            height: 402,
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
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final List<Offset>? endLineOffsetList;
  LinePainter({this.endLineOffsetList});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.pink
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