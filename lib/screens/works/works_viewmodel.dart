import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/task_model.dart';
import '../../models/work_model.dart';

class WorksViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Task _task = Task([], 0);
  Task get task => _task;
  set task(Task task) {
    _task = task;
    notifyListeners();
  }

  List<Work> _works = <Work>[];
  List<Work> get works => _works;
  set works(List<Work> works) {
    _works = works;
    notifyListeners();
  }

  void generateWorks(int amount) {
    works = List.generate(amount, (i) => Work(i));
  }

  void deleteWorksList() {
    clearSelection();
    works = <Work>[];
  }

  void selectWork(int i) {
    _works[i].isSelected = !_works[i].isSelected;
    if (_works[i].isSelected) {
      task.addWork(_works[i]);
    } else {
      task.removeWork(_works[i]);
    }
    notifyListeners();
  }

  void clearSelection() {
    var tWorks = works;
    for (var work in tWorks) {
      work.isSelected = false;
    }
    task = Task([], 0);
    works = tWorks;
  }

  void initialise() {
    task = Task([], 0);
    works = <Work>[];
  }

  void navBack() {
    _navigationService.back();
  }
}
