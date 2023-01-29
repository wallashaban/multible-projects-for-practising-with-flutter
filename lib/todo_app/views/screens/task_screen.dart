// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/todo_app/views/widgets/custom_task_widget.dart';

import '../../controllers/tasks_cubit.dart';
import '../../controllers/tasks_state.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<TasksCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                    label: Text(
                        '${cubit.pinnedTasks.length} Pinned | ${cubit.completedTAsks.length} Completed')),
              ),
               CustomTask(model: cubit.all,isDelete: false,)
                     ],
          ),
        );
      },
    );
  }
}
