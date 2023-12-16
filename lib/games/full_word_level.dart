

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class FullWord extends StatefulWidget {
  const FullWord({super.key});

  @override
  State<FullWord> createState() => _FullWordState();
}

class _FullWordState extends State<FullWord> {

  bool _isDropped = false;
  bool _isDroppedSecond = false;

  final List<String> _words = ['شكرا', 'جزيلا'];
  final String _color = 'red';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Center(child: Icon(Icons.face_3_sharp, size: 200, color: Colors.pinkAccent, )),
        ),
        SizedBox(height: 100,),

        LongPressDraggable<String>(
          // Data is the value this Draggable stores.
          data: _color,
          feedback: Material(
            child: Column(children: [
               Container(
            height: 70.0,
            width: 70.0,
            color: Colors.redAccent,
            child:  Center(
              child: Text(
                _words[0],
                textScaleFactor: 2,
              ),
            ),
          ),
         
            ],),
            
          ),
          childWhenDragging: Container(
         height: 70,
          ),
          child: Column(children: [
            Container(
            height: 70.0,
            width: 70.0,
            child:  Center(
              child: Text(
                _words[0],
                textScaleFactor: 2,
              ),
            ),
          ),
          
        
          ],),
        ),
        LongPressDraggable<String>(
          // Data is the value this Draggable stores.
          data: _color,
          feedback: Material(
            child: Column(children: [
               Container(
            height: 70.0,
            width: 70.0,
            color: Colors.redAccent,
            child:  Center(
              child: Text(
                _words[1],
                textScaleFactor: 2,
              ),
            ),
          ),
         
            ],),
            
          ),
          childWhenDragging: Container(
         height: 70,
          ),
          child: Column(children: [
            Container(
            height: 70.0,
            width: 70.0,
            child: Center(
              child: Text(
                _words[1],
                textScaleFactor: 2,
              ),
            ),
          ),
          
        
          ],),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Row(children: [
          DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              padding: EdgeInsets.all(6),
              color: Colors.red,
              strokeWidth: 2,
              dashPattern: const [8],
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 70,
                  width: 135,
                  color: _isDropped ? Colors.redAccent : null,
                  child: Row(children: [
                    Container(
                      width: 135,
                      child: Center(
                      child: 

                         Text(
                    !_isDropped ? '' : _words[0],
                    
                    textScaleFactor: 2,
                  )
                      
                      ),),
                   
                  ],),
                  
                ),
              ),
            );
          },
          onAccept: (data) {
            debugPrint('hi $data');
            setState(() {
              showSnackBarGlobal(context, 'Dropped successfully!');
              _isDroppedSecond = false;
              _isDropped = true;
            });
          },
          onWillAccept: (data) {
            return data == _color;
          },
          onLeave: (data) {
            showSnackBarGlobal(context, 'Missed');
          },
        ),
        DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              padding: EdgeInsets.all(6),
              color: Colors.red,
              strokeWidth: 2,
              dashPattern: const [8],
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 70,
                  width: 135,
                  color: _isDropped ? Colors.redAccent : null,
                  child: Row(children: [
                    Container(
                      width: 135,
                      child: Center(
                      child: 

                         Text(
                    !_isDroppedSecond ? '' : _words[1],
                    
                    textScaleFactor: 2,
                  )
                      
                      ),),
                   
                  ],),
                  
                ),
              ),
            );
          },
          onAccept: (data) {
            debugPrint('hi $data');
            setState(() {
              showSnackBarGlobal(context, 'Dropped successfully!');
              _isDroppedSecond = true;
            });
          },
          onWillAccept: (data) {
            return data == _color;
          },
          onLeave: (data) {
            showSnackBarGlobal(context, 'Missed');
          },
        ),
        ],),
        
      ],
    ),
  ),
));
  }

  

  void showSnackBarGlobal(BuildContext context, String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      textScaleFactor: 2,
    )));
  }
}