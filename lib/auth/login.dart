import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran_words/auth/welcome.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  

  String _email = '';
  String _password = ''; 

  
  void _handleLogin() async {
    try {
      UserCredential userCredential = 
      await _auth.createUserWithEmailAndPassword(
        email: _email, 
        password: _password
        );
        print('User Logged in: ${userCredential.user!.email}');
         Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } catch (e) {
        print('Error during Logged in: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),

      body: Center(
        child: Padding(
          padding:EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please Enter Your Valid Email';
                      }
                      return null;
                    },
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passController, 
                  obscureText: true, 
                  decoration: InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please Enter Your Valid Password';
                      }
                      return null;
                    },
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _handleLogin();
                    }
                  }, 
                  child: Text(
                    'Login'
                  ))
              ],
            ),
          ) )),
    );
  }
}