import 'package:flutter/material.dart';





 class SwipeGame extends StatefulWidget {
   const SwipeGame({super.key});

   @override
   State<SwipeGame> createState() => _SwipeGameState();
 }

 class _SwipeGameState extends State<SwipeGame> {
   double offsetX = 0.0;
   double rotationAngle = 0.0;
   double leftContainerWidth = 100.0; 
   double rightContainerWidth = 100.0;

 
   @override
   Widget build(BuildContext context) {
     return Padding(padding: EdgeInsets.only(top: 30) ,
     child:
      Center( 
      
       child:
        Column(children: <Widget>[
        Center(
         child: GestureDetector(
           onHorizontalDragUpdate: (details) {
              setState(() {
              offsetX += details.primaryDelta ?? 0.0;
              
            });
           
            if (offsetX > 0) {
              // Движение вправо
              rightContainerWidth += details.primaryDelta ?? 10.0;
            } else {
              // Движение влево
              leftContainerWidth -= details.primaryDelta ?? 10.0;
            }

            // Рассчитываем угол поворота
            rotationAngle = offsetX / 300; // Вы можете настроить это значение
          },
          onHorizontalDragEnd: (details) {
            setState(() {
              offsetX = 0.0;
               leftContainerWidth = 100.0;
              rightContainerWidth = 100.0;
            });

            rotationAngle = 0.0;
          },
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(offsetX, 0.0),
                child: Transform.rotate(
                  angle: rotationAngle,
                  child: Container(
                    width: 250.0,
                    height: 400.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Image.network('https://www.thisiscolossal.com/wp-content/uploads/2023/03/Weerasekera-6.jpg'), // Замените на свою картинку
                  ),
                ),
              ),
              Container(
                child: Text(
                  'سماء',
                  style: TextStyle(fontSize: 44, color: Colors.blue),
                ),
              ),
             Container(
               alignment: Alignment.center,

              height: 130,
              width: 250,
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LimitedBox(
                      maxHeight: 130,
                      maxWidth: 130,
                       child:
                    Container(
                      width: leftContainerWidth,
                      height: leftContainerWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000.0),
                        border: Border.all(
                    color: Color.fromARGB(255, 34, 240, 103),
                    style: BorderStyle.solid,
                    width: 1.0,
                ),
                        ),

                        child: Icon(Icons.check_rounded, size: 44, color: Color.fromARGB(255, 34, 240, 103)),
                    )),
                    Expanded(
                      child: Container(
                        width: 100,
                      ),
                    ),
                    LimitedBox(
                      maxHeight: 130,
                      maxWidth: 130,
                       child:
                    Container(
                      width: rightContainerWidth,
                      height: rightContainerWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000.0),
                        border: Border.all(
                    color: Color(0xFFF05A22),
                    style: BorderStyle.solid,
                    width: 1.0,
                ),
                      ),
                      child: Icon(Icons.close_rounded, size: 44, color: Color(0xFFF05A22),),
                    )),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    ]
    )
    ));
  }
}