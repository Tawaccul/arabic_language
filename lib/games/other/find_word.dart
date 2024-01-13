import 'package:flutter/material.dart';

class AlphabetPuzzle extends StatefulWidget {
  const AlphabetPuzzle({Key? key}) : super(key: key);
  @override
  _AlphabetPuzzleState createState() => _AlphabetPuzzleState();
}
class _AlphabetPuzzleState extends State<AlphabetPuzzle>
    with SingleTickerProviderStateMixin {
  int currentPuzzle = 0;
  /// List of Questions
  List<String> questions = [
    "What is the name of this game?",
    "What is this animal?",
    "What is the name of this animal?",
  ];
  /// List of Answers
  List<String> answers = [
    "mario",
    "cat",
    "wolf",
  ];

  /// List of Images
  List<String> imageUrls = [
    "https://images.pexels.com/photos/163077/mario-yoschi-figures-funny-163077.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://as1.ftcdn.net/v2/jpg/02/48/64/04/1000_F_248640483_5KAZi0GqcWrBu6GOhFEAxk1quNEuOzHJ.jpg",
  ];

  List<String> alphabet = [];
  List<String> userAnswers = [];
  late AnimationController _animationController;
  late Animation<double> _animation;
  int currentLetterIndex = 0;


  @override
  void initState() {
    super.initState();
    generateAlphabetOptions();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  /// Generate Alphabets
  void generateAlphabetOptions() {
    alphabet = answers[currentPuzzle].split('');
    alphabet.shuffle();
    userAnswers = List.filled(answers[currentPuzzle].length, '');
  }

 void handleLetterPress(String pressedLetter) {
  setState(() {
    // Удаляем букву, если она уже была в списке
    userAnswers.remove(pressedLetter);
    // Вставляем букву на первое место
    userAnswers.insert(0, pressedLetter);
    // Если userAnswers уже заполнен, удаляем последнюю букву, чтобы остаться в пределах ответа
    if (userAnswers.length > answers[currentPuzzle].length) {
      userAnswers.removeLast();
    }
    currentLetterIndex++;
  });
}


  /// Check Answer
 void checkAnswer() {
  // Проверяем, что порядок букв в userAnswers совпадает с порядком в answers
  bool isCorrect = List.generate(userAnswers.length, (index) {
    return userAnswers[index] == answers[currentPuzzle][index];
  }).every((element) => element);

  if (isCorrect) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Correct Answer!'),
            content: const Text('Congratulations! You got it right.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (currentPuzzle == questions.length - 1) {
                    // Last puzzle, show completion message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Puzzle Completed'),
                          content: const Text('You have completed all the puzzles.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  currentPuzzle = 0;
                                  generateAlphabetOptions();
                                });
                              },
                              child: const Text('Restart'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Next puzzle
                    setState(() {
                      currentPuzzle++;
                      generateAlphabetOptions();
                    });
                  }
                },
                child: Text('Next'),
              ),
            ],
          );
        },
      ).then((_) {
        _animationController.reset();
        _animationController.forward();
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Incorrect Answer!'),
            content: Text('Please try again.'),
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Alphabet Puzzle'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        questions[currentPuzzle],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageUrls[currentPuzzle],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(userAnswers.length, (index) {
                          return DragTarget<String>(
                            builder: (context, candidateData, rejectedData) {
                              return Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      userAnswers[index].isEmpty ? ' ' : userAnswers[index],
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                ],
                              );
                            },
                            onAccept: (data) {
                              setState(() {
                                userAnswers[index] = data;
                              });
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 500,
                        height: 60,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: alphabet.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Draggable<String>(
                                      data: alphabet[index],
                                      feedback: Material(
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              alphabet[index],
                                              style: const TextStyle(fontSize: 24),
                                            ),
                                          ),
                                        ),
                                      ),
                                      childWhenDragging: Container(),
                                      child: Material(
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          margin: EdgeInsets.only(left: 5,right: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              alphabet[index],
                                              style: TextStyle(fontSize: 24),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(width: 10,),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: checkAnswer,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          primary: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Check Answer',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}