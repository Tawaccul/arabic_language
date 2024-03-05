import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quran_words/constants/colors.dart';
import 'package:flutter_quran_words/games/quiz/models/constants.dart';
import 'package:flutter_quran_words/widgets/widget_home_screen.dart';
import 'package:flutter_quran_words/words/words_db.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
    final List<String> sections = ['Section 1', 'Section 2', 'Section 3', 'Section 4', 'Section 5', 'Section 6'];

  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
   late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

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

    
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(-15.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Запустите анимацию при появлении виджета на экране
    _animationController.forward();
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
    SingleChildScrollView(
      child: 
    ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 3),
      child: 
    Column( 
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300,
          child: Container( 
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Container(
              height: 140,
          child:  Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    Text('ОСНОВЫ', style: TextStyle(color: titleColor, fontSize: 14, fontWeight: FontWeight.w500),),
                    Text('Цифры', style: TextStyle(color: titleColor, fontSize: 32, fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
              SizedBox(height: 15,),
             SizedBox(
              height: 55,
              child:
              ElevatedButton.icon(
                icon: Icon(Icons.play_arrow),
                onPressed: (){}, 
                
                style: ButtonStyle( 
                   backgroundColor: MaterialStateColor.resolveWith((states) => buttonColor),
                   foregroundColor: MaterialStateColor.resolveWith((states) => titleColor),
                   shadowColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(0, 0, 0, 0))
                ),
                label: Text('ПРОЙТИ УРОВЕНЬ', style: TextStyle(fontWeight: FontWeight.w700),)))
            ],
          ),
          ),
          )),

              Container( 
                height: MediaQuery.of(context).size.height* 1.3,
                child: 
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
          itemCount: sections.length,
          itemBuilder: (context, sectionIndex) {
            return Container(
                    margin: EdgeInsets.only(bottom: 20),

              // Ваш контейнер для раздела...
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ваш заголовок раздела...
                  Container(   
                    padding: EdgeInsets.only(left: 30),
                    child: 
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _opacityAnimation.value,
                        child: Transform.translate(
                          offset: _slideAnimation.value,
                          child: Text(
                            sections[sectionIndex],
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: titleColor,
                            ),
                          ),
                        ),
                      );
                    },
                  )),
                  SizedBox(height: 10.0),
                  Container(
                    height: 120,
                    // Ваш ListView.builder для категорий...
                    child:
                     ListView.builder(
                      
                      padding: EdgeInsets.only(left: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: db.categories.length,
                      itemBuilder: (context, index) {
                        if(index==0){
                          return Container ( height: 200, color: Colors.red,);
                        }

                        final category = db.categories[index];
                        return AnimatedBuilder(
                          animation: _controllers[index],
                          builder: (context, child) {
                            return Opacity(
                              opacity: _animations[index].value,
                              child: Transform.translate(
                                offset: Offset(
                                  0.0,
                                  100.0 - 100.0 * _animations[index].value,
                                ),
                                child:  Row(
                                  children: [
                                    WidgetsOnHomeScreen(
                                      category.name,
                                      category.image,
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )),
      ],
    )));
  }
}