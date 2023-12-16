import 'package:flutter/material.dart';





final List<String> letters = ['ﺍ', 'ﺭ', 'ﺝ', 'ﻥ', 'ﻙ', 'ﻕ', 'ﻕ'];




class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreen();
}

class _DictionaryScreen extends State<DictionaryScreen> {
  @override
  Widget build(BuildContext context) {
    return  Column(
    
    verticalDirection: VerticalDirection.down,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      
       Align(
        alignment: Alignment.bottomLeft,
        child: 
        Padding(padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: 
        Row( 
          
          children: <Widget> [
       const Expanded(
        flex: 1,
        child: Text('Words', style: TextStyle(fontSize: 24, ), textAlign: TextAlign.left, textDirection: TextDirection.ltr, ),
       ),
        Expanded(
        flex: 1,
        child:  ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.pinkAccent,
            elevation: 0,
            shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    )),
          onPressed: () {},
          child: const Text("Filter"),
        )),
        ])),

        ),
      const Padding(
       padding: EdgeInsets.only(left: 30, right: 30),
       child: TextField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey),
          hintText: 'Поиск',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),)),
    Expanded(child:  ListView(
      padding: EdgeInsets.all(30),
      scrollDirection: Axis.vertical,
      children:  <Widget>[
        Card(
          color: Colors.greenAccent,
        child: SizedBox(
          width: 200,
          height: 120,
          child: Center(child: Text(letters[0])),
        )),
        Card(
        color: Colors.greenAccent,
        child: SizedBox(
          width: 200,
          height: 120,
          child: Center(child: Text(letters[1])),
        )),
        Card(
          color: Colors.greenAccent,
        child: SizedBox(
          width: 200,
          height: 120,
          child: Center(child: Text(letters[2])),
        )),
        Card(
        color: Colors.greenAccent,
        child: SizedBox(
          width: 200,
          height: 120,
          child: Center(child: Text(letters[3])),
        )),
        Card(
        color: Colors.greenAccent,
        child: SizedBox(
          width: 200,
          height: 120,
          child: Center(child: Text(letters[4])),
        )),
        Card(
        color: Colors.greenAccent,
        child: SizedBox(
          width: 200,
          height: 120,
          child: Center(child: Text(letters[5])),
        )),
        Card(
        color: Colors.greenAccent,
        child: SizedBox(
          width: 200,
          height: 120,
          child: Center(child: Text(letters[6])),
        )),
        SizedBox(height: 100,)
      ],
    ))
    ]); 
  }}

