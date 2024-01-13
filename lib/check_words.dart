// statistics.dart

class GameStatistics {
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  void handleCorrectAnswer() {
    correctAnswers++;
  }

  void handleIncorrectAnswer() {
    incorrectAnswers++;
  }

  void resetStatistics() {
    correctAnswers = 0;
    incorrectAnswers = 0;
  }
}
