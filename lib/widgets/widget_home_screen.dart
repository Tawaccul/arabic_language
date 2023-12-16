import 'package:flutter/material.dart';
import 'package:flutter_quran_words/games/drag_and_drop_level.dart';
import 'package:flutter_quran_words/games/full_word_level.dart';
import 'package:flutter_quran_words/main.dart';

class WidgetsOnHomeScreen extends StatelessWidget {
  final Color _backgroundColor;
 final String _title;
  final String _subtitle; 
  final Icon _icon;

  const WidgetsOnHomeScreen( this._title, this._subtitle, this._backgroundColor, this._icon);
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: false,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        
        SizedBox(
          height: 120,
          child: Container( 
           
            height: 100,
            width: 200,
            decoration: BoxDecoration( color: _backgroundColor, borderRadius: BorderRadius.all(Radius.circular(10.0)), border: Border.all(width: 1, color: Color.fromRGBO(196,252,185,1.0))), 
            child: Column(children: <Widget>[
              SizedBox(height: 10,),
              Text(_subtitle, style: TextStyle(fontSize: 25),),
              _icon, 
               ElevatedButton(onPressed: () { Navigator.pushNamed(context, '/firstgame');  },
               child: const Text('game')),
              Image.asset('lib/images/Qaaba.jpg',
              width: 90, height: 90,)
              ],) )
        ),
        SizedBox(width: 10,),
        SizedBox(
          height: 120,
          child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FirstTypeOfGame(),
            ),
          );
        },
        splashColor: Colors.grey, 
          
          child: Container( 
            height: 100,
            width: 200,
            decoration: BoxDecoration( color: _backgroundColor, borderRadius: BorderRadius.all(Radius.circular(10.0)), border: Border.all(width: 1, color: Color.fromRGBO(196,252,185,1.0))), 
            child: Column(children: <Widget>[
              SizedBox(height: 10,),
              Text(_subtitle, style: TextStyle(fontSize: 25, color: Color.fromRGBO(194, 248, 190, 1.0), fontWeight:FontWeight.bold, fontFamily: 'San Francisco'),),
              _icon, 
                 
              Image.asset('lib/images/Qaaba.jpg',
              width: 90, height: 90,)
              ],) ))
        ),
        SizedBox(width: 10,),
        SizedBox(
          height: 120,
          child: Container( 
            height: 100,
            width: 200,
            decoration: BoxDecoration( color: _backgroundColor, borderRadius: BorderRadius.all(Radius.circular(10.0)), border: Border.all(width: 1, color: Color.fromRGBO(196,252,185,1.0))), 
            child: Column(children: <Widget>[
              SizedBox(height: 10,),
              Text(_subtitle, style: TextStyle(fontSize: 25),),
              _icon, 
              ElevatedButton(onPressed: () { Navigator.pushNamed(context, '/thirdgame');  },
               child: const Text('game')),
              Image.asset('lib/images/Qaaba.jpg',
              width: 90, height: 90,)
              ],) )
        ),
        SizedBox(width: 10,),
        SizedBox(
          height: 120,
          child: Container( 
            height: 100,
            width: 200,
            decoration: BoxDecoration( color: _backgroundColor, borderRadius: BorderRadius.all(Radius.circular(10.0)), border: Border.all(width:1, color: Color.fromRGBO(196,252,185,1.0))), 
            child: Column(children: <Widget>[
              SizedBox(height: 10,),
              Text(_subtitle, style: TextStyle(fontSize: 25),),
              _icon, 
              ElevatedButton(onPressed: () { Navigator.pushNamed(context, '/sixsgame');  },
               child: const Text('game')),
              Image.asset('lib/images/Qaaba.jpg',
              width: 90, height: 90,)
              ],) )
        ),
        SizedBox(width: 10,),
        SizedBox(
          height: 120,
          child: Container( 
            height: 100,
            width: 200,
            decoration: BoxDecoration( color: _backgroundColor, borderRadius: BorderRadius.all(Radius.circular(10.0)), border: Border.all(width: 1, color: Color.fromRGBO(196,252,185,1.0))), 
            child: Column(children: <Widget>[
              SizedBox(height: 10,),
              Text(_subtitle, style: TextStyle(fontSize: 25),),
              _icon, 
              Image.asset('lib/images/Qaaba.jpg',
              width: 90, height: 90,)
              ],) )
        ),
        SizedBox(width: 10,),
        SizedBox(
          height: 120,
          child: Container( 
            height: 100,
            width: 200,
            decoration: BoxDecoration( color: _backgroundColor, borderRadius: BorderRadius.all(Radius.circular(10.0)), border: Border.all(width: 1, color: Color.fromRGBO(196,252,185,1.0))), 
            child: Column(children: <Widget>[
              SizedBox(height: 10,),
              Text(_subtitle, style: TextStyle(fontSize: 25),),
              _icon, 
              Image.asset('lib/images/Qaaba.jpg',
              width: 90, height: 90,)
              ],) )
        ),
        SizedBox(width: 10,),
        
      ],
    );
  }
}