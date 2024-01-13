import 'package:flutter/material.dart';
import 'package:flutter_quran_words/components/dropsown.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreen();
}

class _DictionaryScreen extends State<DictionaryScreen> {
  bool isDropdownOpen = false;
  final List<String> ctg = [
    'Food',
    'Alphabet',
    'Happiness',
    'Family',
    'Nature',
    'Animals',
    'Feelings'
  ];

  String _item = 'Food';
  final List<String> letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    ];

  @override
  Widget build(BuildContext context) {
    return  Container( 
decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.greenAccent, Color.fromARGB(255, 112, 171, 99)],
          // Добавьте свои цвета градиента
        ),),
    child:  Column(
    verticalDirection: VerticalDirection.down,
    children: [
        
       Padding(
       padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
       child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), border: Border.all(color: Color.fromARGB(112, 255, 250, 250))
          ),
        child:  TextField(
          scrollPadding: EdgeInsets.all(5),
        style: TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: -3.0),

          fillColor: Colors.white,
          icon: Icon(Icons.search, color: Colors.white, size: 25,),
          hintText: 'Поиск',
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(   
            gapPadding: 1,      
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide.none,
          ),)
       ))),
      Expanded(child: 
       ListView (children: <Widget>[
 SizedBox(height: 10),
     CustomDropdown(),
     SizedBox(height: 10),
     CustomDropdown(),
     SizedBox(height: 10),
     CustomDropdown(),
     SizedBox(height: 10),
     CustomDropdown(),
     SizedBox(height: 80),
       ],))
    
    ]));
  }}

