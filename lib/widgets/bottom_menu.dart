import 'package:flutter/material.dart';
import 'package:flutter_quran_words/pages/home_page.dart';
import 'package:flutter_quran_words/pages/settingsScreen/settings_main_screen.dart';
import 'package:flutter_quran_words/widgets/widget_home_screen.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override 
  State<BottomMenu> createState() => _BottomMenuState();

}

  class _BottomMenuState extends State<BottomMenu> {

static const List<Widget> _pages = <Widget>[
  Icon(
    Icons.school,
    size: 150,
  ),
  Icon(
    Icons.camera,
    size: 150,
  ),
  Icon(
    Icons.chat,
    size: 150,
  ),
];

    int _selectedIndex = 0; //New
    
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
         @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        label: 'Study',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.camera),
        label: 'Words',
      ),
     
    ],
    currentIndex: _selectedIndex,
    onTap:  _onItemTapped,
  
    );
  }
  } 

