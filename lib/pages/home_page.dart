
import 'package:flutter/material.dart';
import 'package:flutter_quran_words/constants/colors.dart';
import 'package:flutter_quran_words/pages/homePage/Screens/homeScreen/home_screen.dart';
import 'package:flutter_quran_words/pages/settingsScreen/settings_main_screen.dart';
import 'package:flutter_quran_words/pages/words/dictionary_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_quran_words/widgets/bottom_menu.dart';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  static final List<Widget> _pages = [
     HomeScreen(),
     DictionaryScreen(),
     SettingsPage2(),
  ];

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                resizeToAvoidBottomInset : false,

      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 70.0,
        items: <Widget>[
          Icon(Icons.school, size: 30, color: titleColor),
          Icon(Icons.bookmark, size: 30, color: titleColor),
          Icon(Icons.person, size: 30, color: titleColor),
        ],
        color: buttonColor,
        buttonBackgroundColor: buttonColor,
        backgroundColor: mainBackground,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 260),
        onTap: (index) {
          setState(() {
            _page = index; // Update _page when tapping on the navigation bar
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        color: mainBackground,
        child: Center(
          child: _pages[_page], // Display the selected page
        ),
      ),
    );
  }
}




