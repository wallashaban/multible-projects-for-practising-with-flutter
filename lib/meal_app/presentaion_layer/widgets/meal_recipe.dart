import 'package:flutter/material.dart';
import 'package:todoapp/meal_app/data_layer/models/meal_model.dart';
import 'package:todoapp/meal_app/presentaion_layer/widgets/ingredient.dart';

class MealRecipe extends StatelessWidget {
  final MealModel model;
  const MealRecipe({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${model.name} Meals',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
        ),
        body:  SingleChildScrollView(
              child: Column(
                children: [
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
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
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
                      text: '${model.mealMeasure1} ${model.mealIngredient1}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Ingredient(
                      text: '${model.mealMeasure2} ${model.mealIngredient2}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Ingredient(
                      text: '${model.mealMeasure3} ${model.mealIngredient3}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Ingredient(
                      text: '${model.mealMeasure4} ${model.mealIngredient4}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Ingredient(
                      text: '${model.mealMeasure5} ${model.mealIngredient5}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Ingredient(
                      text: '${model.mealMeasure6} ${model.mealIngredient6}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Ingredient(
                      text: '${model.mealMeasure7} ${model.mealIngredient7}'),
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
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Ingredient(text: '${model.instructions}'),
                ],
              ),
        ));
  }
}
