import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/meal_app/buisness_logic/cubit/meal_cubit.dart';

import '../widgets/ingredient.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: BlocBuilder<MealCubit, MealState>(builder: (context, state) {
              var model = BlocProvider.of<MealCubit>(context).searchDetails;
              return Column(
                children: [
                  TextField(
                    controller: searchController,
                    onSubmitted: (value) {
                      BlocProvider.of<MealCubit>(context)
                          .searchMeals(searchController.text);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Add the first letter of the meal to search',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is SearchByFirstLetterSuccesState
                      ? Column(
                          children: [
                            Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    model.name!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                )),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Image(
                                  image: NetworkImage(model.image.toString()),
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: double.infinity,
                                  color: Colors.white.withOpacity(0.7),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text(
                                    'Ingredients',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Ingredient(
                                text:
                                    '${model.mealMeasure1} ${model.mealIngredient1}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Ingredient(
                                text:
                                    '${model.mealMeasure2} ${model.mealIngredient2}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Ingredient(
                                text:
                                    '${model.mealMeasure3} ${model.mealIngredient3}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Ingredient(
                                text:
                                    '${model.mealMeasure4} ${model.mealIngredient4}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Ingredient(
                                text:
                                    '${model.mealMeasure5} ${model.mealIngredient5}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Ingredient(
                                text:
                                    '${model.mealMeasure6} ${model.mealIngredient6}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Ingredient(
                                text:
                                    '${model.mealMeasure7} ${model.mealIngredient7}'),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white.withOpacity(0.7),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                'Steps',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Ingredient(text: '${model.instructions}'),
                          ],
                        )
                      : state is SearchByFirstLetterLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox()
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
