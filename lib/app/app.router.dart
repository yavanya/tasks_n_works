// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../screens/tasks/tasks_view.dart';
import '../screens/tasks/tasks_viewmodel.dart';
import '../screens/works/works_view.dart';

class Routes {
  static const String tasksView = '/';
  static const String worksView = '/works-view';
  static const all = <String>{
    tasksView,
    worksView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.tasksView, page: TasksView),
    RouteDef(Routes.worksView, page: WorksView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    TasksView: (data) {
      var args = data.getArgs<TasksViewArguments>(
        orElse: () => TasksViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TasksView(key: args.key),
        settings: data,
      );
    },
    WorksView: (data) {
      var args = data.getArgs<WorksViewArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => WorksView(
          args.tasksModel,
          key: args.key,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// TasksView arguments holder class
class TasksViewArguments {
  TasksViewArguments({this.key});
  final Key? key;
}

/// WorksView arguments holder class
class WorksViewArguments {
  WorksViewArguments({required this.tasksModel, this.key});
  final TasksViewModel tasksModel;
  final Key? key;
}
