// import 'package:flutter/material.dart';

// class WidgetsOnHomeScreen extends StatelessWidget {
//   final Color _backgroundColor;
//  final String _title;
//   final String _subtitle; 
//   final Icon _icon;

//   const WidgetsOnHomeScreen( this._title, this._subtitle, this._backgroundColor, this._icon);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         SizedBox(
//           height: 120,
//           child: Container( 
//             height: 100,
//             width: 200,
//             decoration: BoxDecoration( color: _backgroundColor, borderRadius: BorderRadius.all(Radius.circular(10.0))), 
//             child: Row(children: <Widget>[
//               Text(_subtitle, style: TextStyle(fontSize: 25),),
//               _icon
//               ],) )
//         ),
//       ],
//     );
//   }
// }