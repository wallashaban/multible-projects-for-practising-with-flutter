import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/todo_app/controllers/tasks_cubit.dart';
import 'package:todoapp/todo_app/views/widgets/custom_task_widget.dart';

import '../../controllers/tasks_state.dart';

class BinScreen extends StatelessWidget {
  const BinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bin Folder')),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomTask(
                  model: BlocProvider.of<TasksCubit>(context).deletedTask,
                  isDelete: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
