import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/task_model.dart';
import 'tasks_viewmodel.dart';

class TasksView extends StatelessWidget {
  TasksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TasksViewModel>.reactive(
        viewModelBuilder: () => TasksViewModel(),
        onModelReady: (model) => model.initialise(),
        fireOnModelReadyOnce: true,
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tasks'),
              centerTitle: true,
            ),
            body: model.tasks.isEmpty ? emptyTasks() : FilledTasksWidget(model),
            floatingActionButton: FloatingActionButton(
              onPressed: () => model.navToWorks(model),
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}

class FilledTasksWidget extends StatelessWidget {
  FilledTasksWidget(this.model, {Key? key}) : super(key: key);
  final TasksViewModel model;

  @override
  Widget build(BuildContext context) {
    var tasks = model.tasks;

    for (var i = taskWidgetList.length; i < tasks.length; i++) {
      tasks[i].attachTimer();
      tasks[i].isStarted = true;
      taskWidgetList.add(taskWidget(context, tasks[i]));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: taskWidgetList.length,
      itemBuilder: (context, index) {
        return taskWidgetList[index];
      },
    );
  }
}

final taskWidgetList = <Widget>[];

Widget taskWidget(BuildContext context, Task task) {
  final subtitle1 = Theme.of(context).textTheme.subtitle1;
  final bodyText2 = Theme.of(context).textTheme.bodyText2;
  int? tick;
  var isActive = false;
  final widget = StreamBuilder(
      initialData: task.durationSum - task.leftTime,
      stream: task.timerStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          tick = 0;
          isActive = false;
        } else {
          tick = snapshot.data as int;
          isActive = true;
        }
        var timeLeft =
            'left sec.: ${isActive ? task.durationSum - tick! : task.leftTime}';
        var circValue = isActive
            ? tick! / task.durationSum
            : (task.durationSum - task.leftTime) / task.durationSum;

        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: task.isCompleted ? Colors.green[100] : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${task.workList.length} work(s) in task',
                  style: subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      task.isCompleted ? 'task done' : timeLeft,
                      style: bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: task.isCompleted
                        ? const Icon(Icons.check, color: Colors.black54)
                        : SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator.adaptive(
                              value: circValue,
                            ),
                          ),
                  ),
                ],
              )
            ],
          ),
        );
      });
  return widget;
}

Widget emptyTasks() => const Center(
      child: Text('No tasks yet'),
    );
