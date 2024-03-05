import 'package:flutter/material.dart';
import 'package:flutter_quran_words/games/other/drag_and_drop_level.dart';
import 'package:flutter_quran_words/games/other/full_word_level.dart';
import 'package:flutter_quran_words/main.dart';

class WidgetsOnHomeScreen extends StatelessWidget {
  final String _title;
  final String _img;

  const WidgetsOnHomeScreen(this._title, this._img);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    child:   Row( 
        children: [
          SizedBox(width: 10,),
       Container( 
      child: Container (
   child: Stack(
    children: [
      // Background Image
        Container( 
          child: 
            Image.asset(
              'assets/images/Frame.png' ?? 'assets/images/Frame.png', // 'https://th.bing.com/th/id/OIP.6pZZtsXnN-X0b4d5wbueuQHaHW?rs=1&pid=ImgDetMain
                fit: BoxFit.cover,
       height: 120,
        width: 140,
          )
      ),
      // Content Container
      Container(
        height: 120,
        width: 140,

        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Container( 
              height: 100,
              child: Text(
              textAlign: TextAlign.left,
              _title,
              style: TextStyle(fontSize: 16, color: Color.fromRGBO(17, 51, 86, 1) ),
              key: Key('title_key'),
            )),
          ],
        ),
      ),
    ],
  ),
      ))]));

    
  }
}


