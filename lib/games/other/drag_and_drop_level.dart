import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quran_words/main.dart';

class FirstTypeOfGame extends StatefulWidget {
   FirstTypeOfGame({super.key});


GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
 @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<FirstTypeOfGame> {
  bool _isBlueDropped = false;
  bool _isRedDropped = false;
  bool _isYelloDropped = false;
  bool _isGreenDropped = false;
  String _blue = 'blue';
  String _red = 'red';
  String _yellow = 'yellow';
  String _green = 'green';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 20,
            ),
            Center(
              child: Container(
                height: 700,
                width: 360,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: DragTarget<String>(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Container(
                            height: 120,
                            width: 120,
                            child: Image.network(_isBlueDropped
                                ? 'https://th.bing.com/th/id/OIP.6pZZtsXnN-X0b4d5wbueuQHaHW?rs=1&pid=ImgDetMain'
                                : 'https://th.bing.com/th/id/OIP.6pZZtsXnN-X0b4d5wbueuQHaHW?rs=1&pid=ImgDetMain'),
                          );
                        },
                        onWillAccept: (data) {
                          return data == _blue;
                        },
                        onAccept: (data) {
                          setState(() {
                            _isBlueDropped = true;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: DragTarget<String>(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Container(
                            height: 120,
                            width: 120,
                            child: Image.network(_isRedDropped
                                ? 'https://th.bing.com/th/id/R.93eefdd2d797cd563c32a380fc16bf62?rik=kOV7UkSetIy9ew&riu=http%3a%2f%2fclipart-library.com%2fimages_k%2fmountain-clipart-transparent-background%2fmountain-clipart-transparent-background-3.png&ehk=uSU9qcU0R0w1tiSkLKiQjEYft0NtG6XP3DVlecvzDRg%3d&risl=&pid=ImgRaw&r=0'
                                : 'https://th.bing.com/th/id/R.93eefdd2d797cd563c32a380fc16bf62?rik=kOV7UkSetIy9ew&riu=http%3a%2f%2fclipart-library.com%2fimages_k%2fmountain-clipart-transparent-background%2fmountain-clipart-transparent-background-3.png&ehk=uSU9qcU0R0w1tiSkLKiQjEYft0NtG6XP3DVlecvzDRg%3d&risl=&pid=ImgRaw&r=0'),
                          );
                        },
                        onWillAccept: (data) {
                          return data == _red;
                        },
                        onAccept: (data) {
                          setState(() {
                            _isRedDropped = true;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: !_isRedDropped,
                      child: Center(child: Draggable<String>(
                        // Data is the value this Draggable stores.
                        data: _red,
                        child: Container(
                          height: 120.0,
                          width: 120.0,
                          child: Center(
                            child: Text('جبل'),
                          ),
                        ),
                        feedback: Container(
                          height: 165.0,
                          width: 165.0,
                          child: Center(
                            child: Text('جبل'),
                          ),
                        ),
                        childWhenDragging: Container(),
                      ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: DragTarget<String>(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Container(
                            height: 120,
                            width: 120,
                            child: Image.network(_isYelloDropped
                                ? 'https://th.bing.com/th/id/R.3e71e3579e81994295bf88f17db6e3b9?rik=am%2f6TKiWv%2fJQWQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2fpng-moon-moon-png-2400.png&ehk=SkqvYfjRGo4PpxwBHO1CnTPzopJ0z%2bQ0MJp%2fxCqbBnM%3d&risl=&pid=ImgRaw&r=0'
                                : 'https://th.bing.com/th/id/R.3e71e3579e81994295bf88f17db6e3b9?rik=am%2f6TKiWv%2fJQWQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2fpng-moon-moon-png-2400.png&ehk=SkqvYfjRGo4PpxwBHO1CnTPzopJ0z%2bQ0MJp%2fxCqbBnM%3d&risl=&pid=ImgRaw&r=0'),
                          );
                        },
                        onWillAccept: (data) {
                          return data == _yellow;
                        },
                        onAccept: (data) {
                          setState(() {
                            _isYelloDropped = true;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: DragTarget<String>(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Container(
                            height: 120,
                            width: 120,
                            child: Image.network(_isGreenDropped
                                ? 'https://th.bing.com/th/id/OIP.ASfH3sdYeU_24jEMWJgLRAHaHW?rs=1&pid=ImgDetMain'
                                : 'https://th.bing.com/th/id/OIP.ASfH3sdYeU_24jEMWJgLRAHaHW?rs=1&pid=ImgDetMain'),
                          );
                        },
                        onWillAccept: (data) {
                          return data == _green;
                        },
                        onAccept: (data) {
                          setState(() {
                            _isGreenDropped = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            Divider(
              thickness: 5,
              color: Colors.white,
            ),
            
          ],
        ),
      )),
    );
  }

  void showSnackBarGlobal(BuildContext context, String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      textScaleFactor: 2,
    )));
  }
}