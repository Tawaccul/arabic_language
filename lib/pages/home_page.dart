
import 'package:flutter/material.dart';
import 'package:flutter_quran_words/pages/homePage/Screens/homeScreen/home_screen.dart';
import 'package:flutter_quran_words/pages/settingsScreen/settings_main_screen.dart';
import 'package:flutter_quran_words/pages/words/dictionary_screen.dart';
import 'package:flutter_quran_words/widgets/bottom_menu.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  static final List<Widget> _pages = [
    HomeScreen(),
    const DictionaryScreen(),
    const SettingsPage2(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _pages.elementAt(_selectedIndex),
          ),
          CustomBottomNavigationBar(
            height: 80.0, // Установите нужную высоту
            selectedIndex: _selectedIndex,
            onItemSelected: _onItemTapped,
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final double height;
  final int selectedIndex;
  final Function(int) onItemSelected;

  CustomBottomNavigationBar({
    required this.height,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromRGBO(239,246,239,1.0), // Цвет фона
          
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(context, 0, Icons.school),
            _buildNavItem(context, 1, Icons.book),
            _buildNavItem(context, 2, Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon) {
    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width / 3,
        child: Icon(
          icon,
          color: index == selectedIndex ? Colors.greenAccent : Color.fromARGB(255, 42, 72, 95),
          size: 35,
        ),
      ),
    );
  }
}

class HomeScr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyHomeScreen(),
    );
  }
}

class DictionaryScr extends StatelessWidget {
  const DictionaryScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:DictionaryScreen() ,
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:SettingsPage2(),
    );
  }
}