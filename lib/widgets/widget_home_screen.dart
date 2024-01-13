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
  height: 200,
  child: Stack(
    children: [
      // Background Image
        Container( 
          child: 
            Image.network(
              '$_img' ?? 'https://default-image-url.jpg', // 'https://th.bing.com/th/id/OIP.6pZZtsXnN-X0b4d5wbueuQHaHW?rs=1&pid=ImgDetMain
                fit: BoxFit.cover,
       height: 200,
        width: 200,
          )
      ),
      // Content Container
      Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(width: 1, color: Color.fromRGBO(196, 252, 185, 1.0)),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              _title,
              style: TextStyle(fontSize: 25, color: Colors.black, ),
              key: Key('title_key'),
            ),
          ],
        ),
      ),
    ],
  ),
);

    
  }
}


