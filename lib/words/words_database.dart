// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';




// class Words extends StatelessWidget {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Example'),
//       ),
//       body: StreamBuilder(
//         stream: _firestore.collection('Words').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }

//           List<DocumentSnapshot> documents = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: documents.length,
//             itemBuilder: (context, index) {
//               Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;

//               // Здесь вы можете использовать данные
//               // Например, для получения значения поля "word":
//               String word = data[0];

//               return ListTile(
//                 title: Text(word),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
