// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/meal_app/buisness_logic/cubit/meal_cubit.dart';
import 'package:todoapp/meal_app/presentaion_layer/widgets/meal_recipe.dart';

class Meal extends StatelessWidget {
  final model;
  final String category;
  const Meal({super.key, required this.category, required this.model});

  @override
  Widget build(BuildContext context) {
       return  Scaffold(
            appBar: AppBar(
              title: Text(
                '$category Meals',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            body:  
            ListView.builder(
                  itemCount: model.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Image(
                            image: NetworkImage(
                              model[index].image.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 300,
                          left: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              model[index].name.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              BlocProvider.of<MealCubit>(context)
                                  .getMealDetails(model[index].name.toString());

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocBuilder<MealCubit,MealState>(
                                        builder: (context, snapshot) {
                                          return MealRecipe(
                                                model: BlocProvider.of<MealCubit>(
                                                        context)
                                                    .mealDetails,
                                              );
                                        }
                                      )));
                            },
                            child: Text(
                              'Show the recipe',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            );
       }
}
