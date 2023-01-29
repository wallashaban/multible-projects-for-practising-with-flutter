// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

class ChangeBottomNavbarState extends TasksState {}

class Done extends TasksState {}

class AddTaskSuccessState extends TasksState {}

class GetTaskSuccessState extends TasksState {}

class DeleteTaskState extends TasksState {}

class UpdateTaskState extends TasksState {}

class FavouriteTaskState extends TasksState {}

class DeleteTaskForEverState extends TasksState {}

class RestoreTaskState extends TasksState {}

class CompleteState extends TasksState {}

class FavState extends TasksState {}

class EditTasksState extends TasksState {}
