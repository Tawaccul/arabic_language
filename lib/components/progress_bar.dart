import 'package:flutter/material.dart';

class GlobalProgressBar extends StatelessWidget {
  final int value;
  int steps;


  GlobalProgressBar({required this.value, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:const Color.fromRGBO(241, 253, 241, 100),
      child: LinearProgressIndicator(
        backgroundColor:const Color.fromRGBO(241, 253, 241, 100),
        color: const Color.fromARGB(158, 158, 255, 100),
        minHeight: 6.0,
        borderRadius: BorderRadius.circular(25.0),
        value: value / steps,),     
      );
  
  }
}
