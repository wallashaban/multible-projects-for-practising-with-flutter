// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp/meal_app/buisness_logic/cubit/meal_cubit.dart';
import 'package:todoapp/meal_app/data_layer/repos/meal_repo.dart';
import 'package:todoapp/meal_app/data_layer/web_services/meal_web_services.dart';
import 'package:todoapp/meal_app/presentaion_layer/screens/meal_home_screen.dart';
import 'package:todoapp/todo_app/controllers/tasks_cubit.dart';
import 'bloc_observer.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage =await HydratedStorage.build(
  storageDirectory: await getApplicationDocumentsDirectory(),
);
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 

  const MyApp({super.key,  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(
          create: (context) => TasksCubit()..getTasks(),
        ), 
        BlocProvider(
            create: (context) => MealCubit(MealRepo(mealWebServices: MealWebServices()))
              ..getMaels()
              ..getCategories() //..getMealDetails('Spicy Arrabiata Penne'),
            ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        title: 'Flutter Todo App',
        debugShowCheckedModeBanner: false,
        // onGenerateRoute: onGenerateRoute,
        home: const  MealHomeScreen(),
      ),
    );
  }
}
