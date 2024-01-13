import 'package:flutter/material.dart';
import 'package:flutter_quran_words/games/quiz/models/constants.dart';
import 'package:flutter_quran_words/games/quiz/models/db_connects.dart';
import 'package:flutter_quran_words/games/quiz/models/question_models.dart';
import 'package:flutter_quran_words/games/quiz/widgets/next_button.dart';
import 'package:flutter_quran_words/games/quiz/widgets/options_widget.dart';
import 'package:flutter_quran_words/games/quiz/widgets/question_widget.dart';
import 'package:flutter_quran_words/games/quiz/widgets/result_box.dart';


class MainQuestionsPage extends StatefulWidget {
  const MainQuestionsPage({super.key});

  @override
  State<MainQuestionsPage> createState() => _MainQuestionsPageState();
}

class _MainQuestionsPageState extends State<MainQuestionsPage> {

  // List<Questions> _questions = [
  //   Questions(
  //   id: '10', 
  //   title: 'First surah of Quran?', 
  //   options: {
  //     'Fatiha':true,
  //     'Baqarah':false,
  //     'Imran':false,
  //     'Maryam':false
  //   }),
  //   Questions(
  //   id: '10', 
  //   title: 'Second surah of Quran?', 
  //   options: {
  //     'Fatiha':false,
  //     'Baqarah':true,
  //     'Imran':false,
  //     'Maryam':false
  //   }),
  // ];
  
  var db = DBconnect();
  late Future _questions;

  Future<List<Questions>> getData() async {
    return db.fetchQuestions();
  }


  @override
  void initState(){
    _questions = getData();
    super.initState();
  }

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isSelected = false;

  void nextQuestion(int questionLength){
    if(index == questionLength - 1){
      showDialog(context: context, builder: ((ctx) => 
      ResultBox(
        result: score,
        questionLength: questionLength,
        OnPressed: startOver,
      )));
    }else{
      if(isPressed){
            setState((){
             index++;
             isPressed = false;
             isSelected = false;
             });
      }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text('Please select any option'),
                       behavior: SnackBarBehavior.floating,
                       margin: EdgeInsets.symmetric(vertical: 10.0),)
            );
      }

    };
  } 

  void checkAnswerAndUpdate(bool value){
    if(isSelected){
      return;
    }else{
      if(value == true){
      score++;
     }
     setState(() {
      isPressed = true;
      isSelected = true;
    });
    }  
  }

  void startOver(){
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isSelected = false;
    });
    Navigator.pop(context);  
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Questions>>, 
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }else if(snapshot.hasData){
            var extractedData = snapshot.data as List<Questions>;
            return Scaffold(
        backgroundColor: background,
       appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Choose correct variant'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              'Score: $score',
               style: TextStyle(fontSize: 18),
              ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            QuestionWidget(
             question: extractedData[index].title, 
             indexAction: index, 
             totalQuestions: extractedData.length),
            Divider(color: neutral,),
            const SizedBox(height: 25,),
            for(int i=0; i<extractedData[index].options.length; i++)
            GestureDetector(
            onTap: () => checkAnswerAndUpdate(
              extractedData[index].options.values.toList()[i]),
            child: OptionCard(
              option: extractedData[index].options.keys.toList()[i],
              color: isPressed
               ?extractedData[index].options.values .toList()[i] == true 
                   ? correct 
                   : incorrect
               : neutral,
               )),
          ],
        ),
      ),

      floatingActionButton: GestureDetector(
      onTap: () => nextQuestion(extractedData.length),
      child: Padding( 
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child:NextButton( 
        )
        )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
          }
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: Text('No data'),
        );
      },
       
    );
  }
}