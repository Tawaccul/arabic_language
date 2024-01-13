import 'package:flutter_quran_words/games/quiz/models/question_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DBconnect {
  final url = Uri.parse('https://wordsapp-28bbd-default-rtdb.europe-west1.firebasedatabase.app/questions.json');

  Future<void> addQuestion(Questions questions) async {
    http.post(url, body: json.encode({
      'title' : questions.title,
      'answer' : questions.options
    }));
  }

 Future<List<Questions>> fetchQuestions() async {
  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as Map<String, dynamic>;

      List<Questions> newQuestions = [];

      data.forEach((key, value) {
        var newQuestion = Questions(
          id: key ?? '', // Handle null key if necessary
          title: value['title'] ?? '', // Handle null title if necessary
          options: Map.castFrom(value['options'] ?? {}), // Handle null options if necessary
        );
        newQuestions.add(newQuestion);
      });

      return newQuestions;
      // Use the newQuestions list as needed
    } else {
      // Handle error - response.statusCode is not 200
      print('Failed to load questions. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that might occur during the HTTP request
    print('Error fetching questions: $e');
  }
  return []; // Add a default return value for error cases
}


  
}

