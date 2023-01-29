import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/todo_app/controllers/tasks_cubit.dart';
import 'package:todoapp/todo_app/views/screens/bin_screen.dart';
import '../../controllers/tasks_state.dart';

class BottomNavBarScreen extends StatelessWidget {
  BottomNavBarScreen({super.key});
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescribtionController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<TasksCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  customBottomSheet(
                    context: context,
                    taskTitleController: taskTitleController,
                    taskDescribtionController: taskDescribtionController,
                  );
                },
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BottomNavBarScreen()));
                      },
                      child: ListTile(
                          leading: const Icon(
                            Icons.folder_copy_rounded,
                          ),
                          title: const Text('My Tasks'),
                          trailing: Text(
                            cubit.pinnedTasks.length.toString(),
                          )),
                    ),
                    // SizedBox(height: 15,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const BinScreen()));
                      },
                      child: ListTile(
                        leading: const Icon(
                          Icons.delete,
                        ),
                        title: const Text('Recycle Bin'),
                        trailing: Text(
                          cubit.deletedTask.length.toString(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: cubit.currentIndex == 0
              ? FloatingActionButton(
                  onPressed: () {
                    customBottomSheet(
                      context: context,
                      taskTitleController: taskTitleController,
                      taskDescribtionController: taskDescribtionController,
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : null,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: ((index) {
                cubit.changgeBottomNavbar(
                  index,
                );
              }),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.incomplete_circle_sharp),
                  label: 'Pending Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.done,
                  ),
                  label: 'Done Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourite Tasks',
                ),
              ]),
        );
      },
    );
  }

  customBottomSheet({
    required context,
    required TextEditingController taskTitleController,
    required TextEditingController taskDescribtionController,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => 
        SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 330),
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Add Task',
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
                                BlocProvider.of<TasksCubit>(context).addTask(
                                  taskTitle: taskTitleController.text,
                                  describtion: taskDescribtionController.text,
                                );
                                Navigator.pop(context);
                                taskTitleController.clear();
                                taskDescribtionController.clear();
                              }
                            },
                            style: TextButton.styleFrom(
                                // foregroundColor: Colors.blue,
                                // backgroundColor: Colors.blue.withOpacity(0.4)
                                ),
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
