import 'package:flutter/material.dart';
import 'package:todoapp/todo_app/utilities/routes.dart';

import '../views/screens/task_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routeres.taskScreenRoute:
      return MaterialPageRoute(builder: (_) => const TasksScreen());
    default:
      return MaterialPageRoute(builder: (_) => const TasksScreen());
  }
}
