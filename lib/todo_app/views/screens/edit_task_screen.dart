// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/tasks_cubit.dart';

class EditTaskScreen extends StatelessWidget {
  final  oldTask;
  final int index;
  EditTaskScreen({
    Key? key,
    required this.oldTask,
    required this.index,
  }) : super(key: key);

  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescribtionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    taskTitleController.text = oldTask['title'];
    taskDescribtionController.text = oldTask['describtion'];
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 330),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'Edit Task',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: taskTitleController,
                  autofocus: true,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Please add task title';
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Title'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: taskDescribtionController,
                  autofocus: true,
                  minLines: 3,
                  maxLines: 6,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Please add task describtion';
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Describtion'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<TasksCubit>(context).editTask(
                            taskTitle: taskTitleController.text,
                            describtion: taskDescribtionController.text,
                            taskId: index,
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: TextButton.styleFrom(
                          // foregroundColor: Colors.blue,
                          // backgroundColor: Colors.blue.withOpacity(0.4)
                          ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
