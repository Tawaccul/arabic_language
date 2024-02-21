import 'package:flutter/material.dart';
import 'package:flutter_quran_words/pages/homePage/Screens/homeScreen/home_screen.dart';
import 'package:flutter_quran_words/pages/home_page.dart';

class AdditionalDetailsPage extends StatefulWidget {
  final String userEmail;

  const AdditionalDetailsPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _AdditionalDetailsPageState createState() => _AdditionalDetailsPageState();
}

class _AdditionalDetailsPageState extends State<AdditionalDetailsPage> {
  String? _selectedGender;
  int? _selectedAge;
  String? _enteredName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Gender:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            DropdownButton<String>(
              value: _selectedGender,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
              items: <String>['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Enter Age:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _selectedAge = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Enter Name:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _enteredName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                print('Selected Gender: $_selectedGender');
                print('Selected Age: $_selectedAge');
                print('Entered Name: $_enteredName');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

 

