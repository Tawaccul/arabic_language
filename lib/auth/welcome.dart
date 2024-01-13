

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran_words/auth/login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    String? _email = _auth.currentUser!.email;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Logged In With $_email'),
              SizedBox(
                height: 50),
              ElevatedButton(
                onPressed: (){
                  _auth.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
                } , 
                child: Text(
                  'SignOut'))
            ]
          ),
        )),
    );
  }
}