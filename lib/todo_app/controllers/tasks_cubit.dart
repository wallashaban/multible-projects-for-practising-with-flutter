// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todoapp/todo_app/controllers/tasks_state.dart';
import 'package:todoapp/todo_app/models/tasks_sqlite.dart';
import 'package:todoapp/todo_app/views/screens/done_tasks_screen.dart';
import 'package:todoapp/todo_app/views/screens/fav_task_screen.dart';
import 'package:todoapp/todo_app/views/screens/task_screen.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  SqlTasks sqlTasks = SqlTasks();
  List pinnedTasks = [];
  List allTasks = [];
  List deletedTask = [];
  List completedTAsks = [];
  List favouriteTasks = [];
  List all = [];
  List<Widget> screens = [
    const TasksScreen(),
    const DoneTasksScreen(),
    const FavouriteTasksScreen(),
  ];
  List<String> titles = [
    'Pending Tasks',
    'Done Tasks',
    'Favourite Tasks',
  ];
  int currentIndex = 0;
  void changgeBottomNavbar(int index) {
    currentIndex = index;
    emit(
      ChangeBottomNavbarState(),
    );
    emit(Done());
  }

  getTasks() async {
    allTasks = await sqlTasks.retriveData(query: 'SELECT * FROM tasks');
    emit(GetTaskSuccessState());
    completedTAsks = [];
    favouriteTasks = [];
    pinnedTasks = [];
    deletedTask = [];
    all = [];
    allTasks.forEach((task) {
       if (task['isDelete'] == 0) {
        all.add(task);
      }
      if (task['isDelete'] == 1) {
        deletedTask.add(task);
      }
      if (task['isDone'] == 1) {
        completedTAsks.add(task);
      }
      if (task['isFav'] == 1) {
        favouriteTasks.add(task);
      }
      if (task['isDone'] == 0 && task['isDelete']==0) {
        pinnedTasks.add(task);
      }
    });
  }

  addTask({
    required String taskTitle,
    required String describtion,
  }) async {
    sqlTasks.insertData(
        query:
            '''INSERT INTO tasks(title, describtion, date, isDone, isFav, isDelete) 
            VALUES('$taskTitle', '$describtion', '${DateTime.now().toString()}', 0, 0, 0)''').then(
        (task) {
      getTasks();
      emit(AddTaskSuccessState());
      emit(Done());
    });
  }

  updateTask(int taskId, bool value) async {
    int isDone = value ? 1 : 0;
    sqlTasks.updateData(data: 'isDone', id: taskId, type: isDone).then((value) {
      getTasks();
      emit(
        UpdateTaskState(),
      );
    });
  }

  deleteTask(int taskId) async {
    sqlTasks
        .updateData(
      data: 'isDelete',
      id: taskId,
      type: 1,
    )
        .then((value) {
      getTasks();
      emit(
        DeleteTaskState(),
      );
    });
  }

  deleteTaskForEver(int taskId) {
    sqlTasks
        .deleteData(query: 'DELETE FROM tasks WHERE id = $taskId')
        .then((value) {
      getTasks();
      emit(
        DeleteTaskState(),
      );
      emit(Done());
    });
  }

  restoreTask(int taskId) {
    sqlTasks
        .updateData(
      data: 'isDelete',
      id: taskId,
      type: 0,
    )
        .then((value) {
      getTasks();
      emit(
        RestoreTaskState(),
      );
    });
  }

  addToFavourite(int taskId, int value) {
    value == 1 ? value = 0 : value = 1;
    sqlTasks.updateData(data: 'isFav', id: taskId, type: value).then((value) {
      getTasks();
      emit(
        FavouriteTaskState(),
      );
    });
  }

  editTask({
    required taskTitle,
    required describtion,
    required taskId,
  }) {
    sqlTasks
        .editData(title: taskTitle, describtion: describtion, id: taskId)
        .then((value) {
      getTasks();
      emit(
        EditTasksState(),
      );
    });
  }
}
