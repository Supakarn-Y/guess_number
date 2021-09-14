import 'dart:math';

class Game {
  final int _answer;
  int _totalGuess;
  List<String> data = [];
  Game()
      : _answer = Random().nextInt(100) + 1,
        _totalGuess = 0 {
    print('The answer is: $_answer');
  }
  String getanswer() {
    return _answer.toString();
  }

  int get totalGuess {
    return _totalGuess;
  }

  String getdata() {
    String db = '';
    for (int i = 0; i < data.length; i++) {
      if (i == data.length - 1) {
        db += data[i];
      } else
        db += data[i] + " → ";
    }
    return db;
  }

  int doGuess(int num) {
    data.add(num.toString());
    _totalGuess++;
    if (num > _answer) {
      return 1;
    } else if (num < _answer) {
      return -1;
    } else {
      return 0;
    }
  }
}
