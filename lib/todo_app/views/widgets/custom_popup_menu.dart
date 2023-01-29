import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/todo_app/controllers/tasks_cubit.dart';
import 'package:todoapp/todo_app/views/screens/edit_task_screen.dart';

class CustomPopMenu extends StatelessWidget {
  final int index;
  final bool isBin;
  final List model;
  const CustomPopMenu({super.key,required this.model, required this.index, this.isBin = false});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TasksCubit>(context);
    /*  return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) { */
    return PopupMenuButton(
      itemBuilder: (context) => [
        if (!isBin)
          PopupMenuItem(
              child: TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => EditTaskScreen(
                        oldTask: model[index], index: model[index]['id'])),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            label: const Text(
              'Add to bookmark',
              style: TextStyle(color: Colors.white),
            ),
          )),
        if (!isBin)
          PopupMenuItem(
              child:
               TextButton.icon(
            onPressed: () {
              cubit.addToFavourite(model[index]['id'],model[index]['isFav']);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            label: const Text(
              'Add to bookmark',
              style: TextStyle(color: Colors.white),
            ),
          ),
          
          ),
      
        if (!isBin)
          PopupMenuItem(
              child: TextButton.icon(
            onPressed: () {
              cubit.deleteTask(model[index]['id']);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            label: const Text(
              'Add to bookmark',
              style: TextStyle(color: Colors.white),
            ),
          )),
        if (isBin)
          PopupMenuItem(
              child: TextButton.icon(
            onPressed: () {
              cubit.restoreTask(model[index]['id']);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.restore_from_trash,
              color: Colors.white,
            ),
            label: const Text(
              'Add to bookmark',
              style: TextStyle(color: Colors.white),
            ),
          )),
        if (isBin)
          PopupMenuItem(
              child: TextButton.icon(
            onPressed: () {
              cubit.deleteTaskForEver(model[index]['id']);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            label: const Text(
              'Add to bookmark',
              style: TextStyle(color: Colors.white),
            ),
          )),
      ],
    );
    /*  },
    ); */
  }
}
