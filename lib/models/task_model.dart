import 'dart:async';

import 'work_model.dart';

class Task {
  Task(this.workList, this.durationSum) {
    leftTime = durationSum;
  }

  List<Work> workList = [];

  int durationSum;

  late int leftTime;

  bool isStarted = false;

  bool isCompleted = false;

  late Timer _timer;

  Stream<int>? _innerStream;

  Stream<int> timerStream() {
    var stream = _innerStream!.asyncMap((event) {
      return event;
    });
    return stream.asBroadcastStream();
  }

  void attachTimer() {
    var controller = StreamController<int>();
    _innerStream = controller.stream;
    _timer = Timer.periodic(const Duration(seconds: 1), (x) {
      leftTime = leftTime - 1;
      controller.add(x.tick);
      if (leftTime < 1) {
        isCompleted = true;
        _timer.cancel();
      }
    });
  }

  void addWork(Work work) {
    workList.add(work);
    durationSum = 0;
    for (var work in workList) {
      durationSum += work.duration!;
    }
    leftTime = durationSum;
  }

  void removeWork(Work work) {
    workList.removeWhere((e) => e.number == work.number);
    durationSum -= work.duration!;
    leftTime = durationSum;
  }
}
