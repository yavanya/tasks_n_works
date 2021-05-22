import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../screens/tasks/tasks_view.dart';
import '../screens/tasks/tasks_viewmodel.dart';
import '../screens/works/works_view.dart';
import '../screens/works/works_viewmodel.dart';


@StackedApp(
  routes: [
    MaterialRoute(page: TasksView, initial: true),
    CustomRoute(
      page: WorksView,
      
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    Singleton(classType: TasksViewModel),
    Singleton(classType: WorksViewModel),
  ],
)
class App {}
