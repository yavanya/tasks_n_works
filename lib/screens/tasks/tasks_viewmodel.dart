import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../models/task_model.dart';

class TasksViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  late List<Task> _tasks;
  List<Task> get tasks => _tasks;
  set tasks(List<Task> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(Task(task.workList, task.durationSum));
    notifyListeners();
  }

  void addTasks(Task task, int amount) {
    for (var i = 0; i < amount; i++) {
      addTask(task);
    }
  }

  void initialise() {
    tasks = <Task>[];
  }

  void navToWorks(TasksViewModel model) async {
    await _navigationService.navigateTo(
      Routes.worksView,
      arguments: WorksViewArguments(tasksModel: model),
    );
  }
}
