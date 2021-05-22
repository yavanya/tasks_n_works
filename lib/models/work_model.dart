import 'dart:math';

class Work {
  Work(this.number) {
    duration = Random().nextInt(15) + 5;
  }

  int number;

  int? duration;

  bool isSelected = false;
}
