import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../tasks/tasks_viewmodel.dart';

import 'works_viewmodel.dart';

class WorksView extends StatelessWidget {
  WorksView(this.tasksModel, {Key? key}) : super(key: key);
  final TasksViewModel tasksModel;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorksViewModel>.reactive(
        viewModelBuilder: () => WorksViewModel(),
        disposeViewModel: false,
        fireOnModelReadyOnce: true,
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: worksAppBar(context, model),
            body:
                model.works.isEmpty ? EmptyWorksWidget() : FilledWorksWidget(),
            floatingActionButton: model.task.workList.isEmpty
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        heroTag: "btn1",
                        child: const Text('x1000'),
                        onPressed: () {
                          tasksModel.addTasks(model.task, 1000);
                          model.navBack();
                        },
                      ),
                       const SizedBox(width: 20),
                      FloatingActionButton(
                        heroTag: "btn2",
                        child: const Text('x100'),
                        onPressed: () {
                          tasksModel.addTasks(model.task, 100);
                          model.navBack();
                        },
                      ),
                      const SizedBox(width: 20),
                      FloatingActionButton(
                        heroTag: "btn3",
                        child: const Text('x10'),
                        onPressed: () {
                          tasksModel.addTasks(model.task, 10);
                          model.navBack();
                        },
                      ),
                      const SizedBox(width: 20),
                      FloatingActionButton(
                        heroTag: "btn4",
                        child: const Icon(Icons.check),
                        onPressed: () {
                          tasksModel.addTask(model.task);
                          model.navBack();
                        },
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
          );
        });
  }
}

AppBar worksAppBar(BuildContext context, WorksViewModel model) {
  var task = model.task;
  var worklist = task.workList;
  return AppBar(
    title: task.workList.isEmpty
        ? const Text('Works')
        : Text('${worklist.length} works on ${task.durationSum} sec. total'),
    actions: [
      task.workList.isEmpty
          ? Container()
          : IconButton(
              onPressed: model.clearSelection,
              icon: const Icon(Icons.close),
            ),
      IconButton(
        onPressed: model.deleteWorksList,
        icon: const Icon(Icons.delete_outline),
      )
    ],
  );
}

class EmptyWorksWidget extends ViewModelWidget<WorksViewModel> {
  EmptyWorksWidget({Key? key})
      : super(
          key: key,
          reactive: false,
        );
  @override
  Widget build(BuildContext context, WorksViewModel model) {
    return SizedBox(
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.5,
              child: ElevatedButton(
                onPressed: () => model.generateWorks(900),
                child: const Text('Generate 900'),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: ElevatedButton(
                onPressed: () => model.generateWorks(9000),
                child: const Text('Generate 9000'),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: ElevatedButton(
                onPressed: () => model.generateWorks(90000),
                child: const Text('Generate 90000'),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: ElevatedButton(
                onPressed: () => model.generateWorks(900000),
                child: const Text('Generate 900000'),
              ),
            ),
          ]),
    );
  }
}

class FilledWorksWidget extends ViewModelWidget<WorksViewModel> {
  FilledWorksWidget({Key? key})
      : super(
          key: key,
          reactive: false,
        );
  @override
  Widget build(BuildContext context, WorksViewModel model) {
    return ListView.builder(
      itemCount: model.works.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => model.selectWork(index),
        child: WorkElement(index),
      ),
    );
  }
}

class WorkElement extends ViewModelWidget<WorksViewModel> {
  WorkElement(this.index, {Key? key}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context, WorksViewModel model) {
    var headline5 = Theme.of(context).textTheme.headline5;
    var works = model.works;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: works[index].isSelected
            ? Border.all(color: Colors.grey, width: 2)
            : Border.all(color: Colors.transparent, width: 2),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(2, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 16.0,
      ),
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Work# ${works[index].number + 1}',
              style: headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              '${works[index].duration} sec.',
              style: headline5,
            ),
          ),
        ],
      ),
    );
  }
}
