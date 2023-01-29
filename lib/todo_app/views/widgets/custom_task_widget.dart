import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/todo_app/views/widgets/custom_popup_menu.dart';

import '../../controllers/tasks_cubit.dart';

class CustomTask extends StatelessWidget {
  final List model;
  final bool isDelete;
  const CustomTask({super.key, required this.model, required this.isDelete});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TasksCubit>(context);
    return model.isEmpty
        ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                const Text(
                  'There is no tasks yet ',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Try Adding some tasks now',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          )
        : Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                itemCount: model.length,
                itemBuilder: ((context, index) =>
                    ExpansionPanelList.radio(children: [
                      ExpansionPanelRadio(
                          value: model[index]['id'],
                          body: ListTile(
                            title: SelectableText.rich(TextSpan(children: [
                              const TextSpan(
                                text: 'Text :\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: model[index]['title'],
                              ),
                              const TextSpan(
                                text: '\n\nDecribtion :\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: model[index]['describtion'],
                              ),
                            ])),
                          ),
                          headerBuilder: (context, isExpanded) => InkWell(
                                onLongPress: () => cubit.deleteTask(cubit.allTasks[index]['id']),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            cubit.addToFavourite(
                                                model[index]['id'], model[index]['isFav']);
                                          },
                                          icon: Icon(
                                            isDelete || cubit.allTasks.isEmpty
                                                ? Icons.star_border_rounded
                                                    : model[index]['isFav']==1
                                                        ? Icons.star
                                                        : Icons
                                                            .star_border_rounded,
                                          )),
                                   
                                      Column(
                                        children: [
                                          Text(model[index]['title']),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(DateFormat()
                                              .add_yMEd()
                                              .add_Hms()
                                              .format(DateTime.parse(
                                                  model[index]['date']))),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Checkbox(
                                        value: isDelete
                                                ? false 
                                                : model[index]['isDone']==1?true:false,
                                        onChanged: (value) {
                                          cubit.updateTask(cubit.allTasks[index]['id'], value!);
                                        },
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CustomPopMenu(
                                        model: model,
                                        index: index,
                                        isBin: isDelete,
                                      )
                                    ],
                                  ),
                                ),
                              )),
                    ]))),
          );
  }
}
