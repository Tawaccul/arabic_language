// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_quran_words/auth/login.dart';
// import 'package:flutter_quran_words/auth/person_details.dart';
// import 'package:flutter_quran_words/auth/profile_screen.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passController = TextEditingController();

//   String _email = '';
//   String _password = '';

//   Future<bool> _handleSignUp() async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: _email,
//         password: _password,
//       );
//       print('User Registered: ${userCredential.user!.email}');
//       return true;
//     } catch (e) {
//       print('Error during Registration: $e');
//       return false;
//     }
//   }

//   Future<void> saveUserDataToFirestore(User user) async {
//     try {
//       // Получите ссылку на Firestore
//       FirebaseFirestore firestore = FirebaseFirestore.instance;

//       // Определите коллекцию пользователей (в данном случае, 'Users')
//       CollectionReference usersCollection = firestore.collection('Users');

//       // Создайте документ для конкретного пользователя
//       String userId = user.uid;

//       // Сохраните данные пользователя в Firestore
//       await usersCollection.doc(userId).set({
//         'email': user.email,
//         // Другие данные пользователя, которые вы хотите сохранить
//       });

//       print('User data saved to Firestore');
//     } catch (e) {
//       print('Error saving user data to Firestore: $e');
//     }
//   }

//   void _handleGoogleSignIn() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount!.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       UserCredential userCredential = await _auth.signInWithCredential(credential);

//       // Сохранение данных пользователя в Firestore
//       await saveUserDataToFirestore(userCredential.user!);

//       print('User Signed In with Google: ${userCredential.user!.displayName}');
//     } catch (e) {
//       print('Error during Google Sign In: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Verification'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please Enter Your Valid Email';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       _email = value;
//                     });
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   controller: _passController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please Enter Your Valid Password';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       _password = value;
//                     });
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                      await _handleSignUp();
//                       Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                       builder: (context) => AdditionalDetailsPage(userEmail: _email),
//           ));
//                     }
//                   },
//                   child: Text('Sign Up'),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 ElevatedButton(
//                   onPressed: _handleGoogleSignIn,
//                   child: Text('Sign Up with Google'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
