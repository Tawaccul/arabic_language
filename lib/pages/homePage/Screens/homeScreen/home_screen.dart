import 'package:flutter/material.dart';
import 'package:flutter_quran_words/widgets/widget_home_screen.dart';
import 'package:flutter_quran_words/words/words_db.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  Database db = Database();

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      db.categories.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
        reverseDuration: Duration(milliseconds: 300),
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        
        curve: Curves.easeInOut,
      ));
      
    }).toList();
    
    
    _startAnimations();
  }
  

  void _startAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(Duration(milliseconds: 110));
      _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // Set a fixed height for the ListView
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        scrollDirection: Axis.horizontal,
        itemCount: db.categories.length,
        itemBuilder: (context, index) {
          final category = db.categories[index];

          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Opacity(
                opacity: _animations[index].value,
                child: Transform.translate(
                  offset: Offset(0.0, 100.0 - 100.0 * _animations[index].value),
                  child: Row ( 
                    children: <Widget> [  
                      SizedBox(width: 10),
                      WidgetsOnHomeScreen(
                    category.name,
                    category.image,  
                  ),
                 SizedBox(width: 10), 

                   ] )
                  ),
                
              );
            },
          );
        },
      ),
    );
  }
}
