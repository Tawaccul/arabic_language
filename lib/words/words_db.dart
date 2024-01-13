class MissingWord {
  final String id;
  final Map<String, String> sentence;
  final List<Map<String, String>> value;
  
  MissingWord(this.id, this.value, this.sentence);
}

class MatchWords {
  final String id;
  final Map<String, List<Map<String, String>>> value;
  
  MatchWords(this.id, this.value);
}



class Category {
  final String id;
  final String name;
  final String image;

  Category(this.id, this.name, this.image); 
}



// Пример базы данных со словами
class Database {

   final List<MissingWord> words = [
      MissingWord(
        '1',
       [
        {"يَـٰبَنِىٓ": "О потомки"},
        {"ٱلَّتِىٓ": "которой"},
        {"عَلَى": "мирами"},
       ],
       {
        'يَـٰبَنِىٓ إِسْرَٰٓءِيلَ ٱذْكُرُوا۟ نِعْمَتِىَ ٱلَّتِىٓ أَنْعَمْتُ عَلَيْكُمْ وَأَنِّى فَضَّلْتُكُمْ عَلَى ٱلْعَـٰلَمِينَ' : 
        'О сыны Исраила (Израиля)! Помните о милости, которую Я оказал вам, а также о том, что Я возвысил вас над мирами.'
        }
        ),
      MissingWord(
        "2", 
         [
        {"بِكُمُ": "ради вас"},
        {"فِرْعَوْنَ": "Фараона"},
        {"تَنظُرُونَ": "смотрели вы"},
         ],
       {
        'وَإِذْ فَرَقْنَا بِكُمُ ٱلْبَحْرَ فَأَنجَيْنَـٰكُمْ وَأَغْرَقْنَآ ءَالَ فِرْعَوْنَ وَأَنتُمْ تَنظُرُونَ' : 
        'Вот Мы разверзли для вас море, спасли вас и потопили род Фараона, тогда как вы наблюдали за этим.'
       }
        ),
      MissingWord(
        "3", 
         [
        {"ثُمَّ": "Потом"},
        {"عَنكُم": "вас"},
        {"لَعَلَّكُمْ": "чтобы вы"},
         ],
       {'ثُمَّ عَفَوْنَا عَنكُم مِّنۢ بَعْدِ ذَٰلِكَ لَعَلَّكُمْ تَشْكُرُونَ' :
        'После этого Мы простили вас, - быть может, вы будете благодарны.'
       },
        ),
   ];

    final List<MatchWords> matchWords = [
        MatchWords(
          '1',
          {'firstLevel' :
       [
        {"arabic": "يَـٰبَنِىٓ", 'russian' : 'О потомки'},
        {"arabic": "ٱلَّتِىٓ", 'russian' : 'которой'},
        {"arabic": "عَلَى", 'russian' : 'мирами'},
        
       ]
          },
          ),
          MatchWords(
          '2',
                {'secondLevel' :
       [
        {"arabic": "بِكُمُ", 'russian' : 'ради вас'},
        {"arabic": "فِرْعَوْنَ", 'russian' : 'Фараона'},
        {"arabic": "تَنظُرُونَ", 'russian' : 'смотрели вы'},
       ],
                }
          )
    ];
    
    final List<Category> categories = 
       [
        
     Category(
      '1', 
      'Al-fatiha', 
      'https://images.unsplash.com/photo-1584284675245-78ffa75a0982?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ),
    Category(
      '2',
      'Al-baqara',
      'https://images.unsplash.com/photo-1584284675245-78ffa75a0982?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ),
    Category(
      '3',
      'Al-imran',
      'https://images.unsplash.com/photo-1584284675245-78ffa75a0982?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ),
    Category(
      '4',
      'An-nisa',
      'https://images.unsplash.com/photo-1584284675245-78ffa75a0982?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ),
    Category(
      '5',
      'Al-maida',
      'https://images.unsplash.com/photo-1584284675245-78ffa75a0982?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ),
    Category(
      '6',
      'Al-anam',
      'https://images.unsplash.com/photo-1584284675245-78ffa75a0982?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ),
   ];

  
}



class GameLogic {
  final Database _database = Database();

  // Метод для получения случайных слов из базы данных
  List<MissingWord> getRandomWords(int count) {
    final List<MissingWord> shuffledWords = List.from(_database.words)..shuffle();
    return shuffledWords.take(count).toList();
  }

  // Метод для проведения игры
  void playGame() {
    // Получите 4 случайных слова
    final List<MissingWord> gameWords = getRandomWords(8);

    // TODO: Ваша логика игры (проверка знания слов, подсчет правильных и неправильных ответов)

    // После завершения игры вы можете вывести результаты
  }

  // Метод для вывода результатов
  void showResults(int correctAnswers, int incorrectAnswers) {
    print('Правильных ответов: $correctAnswers');
    print('Неправильных ответов: $incorrectAnswers');
  }
}

