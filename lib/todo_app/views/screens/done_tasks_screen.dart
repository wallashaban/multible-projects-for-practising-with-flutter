import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/todo_app/controllers/tasks_cubit.dart';
import 'package:todoapp/todo_app/views/widgets/custom_task_widget.dart';

import '../../controllers/tasks_state.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) { 
      var cubit = BlocProvider.of<TasksCubit>(context).completedTAsks;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              CustomTask(
                model: cubit,
                isDelete: false,
              ),
            ],
          ),
        );
       },
    );
  }
}
