import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/meal_app/buisness_logic/cubit/meal_cubit.dart';
import 'package:todoapp/meal_app/data_layer/web_services/meal_web_services.dart';
import 'package:todoapp/meal_app/presentaion_layer/screens/search_screen.dart';
import 'package:todoapp/meal_app/presentaion_layer/widgets/meal_category.dart';

class MealHomeScreen extends StatefulWidget {
  const MealHomeScreen({super.key});

  @override
  State<MealHomeScreen> createState() => _MealHomeScreenState();
}

class _MealHomeScreenState extends State<MealHomeScreen> {
  @override
  void initState() {
    super.initState();
    MealWebServices().getMeals();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {},
      builder: (context, state) {
        return  Scaffold(
        appBar: AppBar(
          title: Text(
            'Meal App',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: BlocBuilder<MealCubit, MealState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<MealCubit>(context);
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemCount: cubit.categories.length,
              itemBuilder: (BuildContext context, int index) {
                return MealCategory(model: cubit.categories[index]);
              },
            );
          },
        ));
 
      },
    );
  }
}
