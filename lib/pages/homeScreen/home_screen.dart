
import 'package:flutter/material.dart';
import 'package:flutter_quran_words/pages/settingsScreen/settings_main_screen.dart';
import 'package:flutter_quran_words/widgets/bottom_menu.dart';
import 'package:flutter_quran_words/widgets/widget_home_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState1 createState() => _HomeScreenState1();
}


class _HomeScreenState1 extends State<HomeScreen> {
    
     
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     resizeToAvoidBottomInset : true,

      body: SingleChildScrollView(child:
      Container( 
        color: Color.fromRGBO(235, 252, 236, 1.0),
        child:
       Column( 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        Container(height: 25,),
           
           const Column( 
            
            children: <Widget>[
          Text('Suratus',),
         SizedBox(height: 10, width: 20,),
         SizedBox(
          height: 250,
          child:  WidgetsOnHomeScreen('Суры', 'Fatiha', Color.fromRGBO(178,211,166,1.0), Icon(Icons.abc_outlined))
          ) ]),
      
          const Column( 
            children: <Widget>[
          Text('Suratus',),
         SizedBox(height: 10,),
         SizedBox(
          height: 300,
          child:  WidgetsOnHomeScreen('Суры', 'Al-Baqara',  Color.fromRGBO(178,211,166,1.0), Icon(Icons.abc_outlined))
          ) ]),

          const Column( 
            children: <Widget>[
          Text('Suratus',),
         SizedBox(height: 10,),
         SizedBox(
          height: 300,
          child:  WidgetsOnHomeScreen('Суры', 'Al-Imran',  Color.fromRGBO(178,211,166,1.0), Icon(Icons.abc_outlined))
          ) ]),

          const Column( 
            children: <Widget>[
          Text('Suratus',),
         SizedBox(height: 10,),
         SizedBox(
          height: 300,
          child:  WidgetsOnHomeScreen('Суры', 'Maryam', Color.fromRGBO(178,211,166,1.0), Icon(Icons.abc_outlined))
          ),

          SizedBox( height: 100,) 
          ]),
        ],),
      ))
        
      

    ); }}