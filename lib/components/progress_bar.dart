import 'package:flutter/material.dart';

class GlobalProgressBar extends StatelessWidget {
  final int value;
  int steps;


  GlobalProgressBar({required this.value, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(value: steps / value,),     
      );
  
  }
}
