// ignore_for_file: avoid_print

import 'package:todoapp/meal_app/data_layer/models/category_model.dart';
import 'package:todoapp/meal_app/data_layer/models/meal_model.dart';
import 'package:todoapp/meal_app/data_layer/web_services/meal_web_services.dart';

class MealRepo {
  MealWebServices mealWebServices;
  MealRepo({
    required this.mealWebServices,
  });

  Future getMeals() async {
    final meals = await mealWebServices.getMeals();

    // print('Meal ${meals['meals'][0]['strMeal']}');
    return meals['meals'].map((meal) => MealModel.fromJson(meal)).toList();
  }

  Future getMealCategories() async {
    final categories = await mealWebServices.getMealCategories();
    // print('categories ${categories['categories'][0]['idCategory']}');
    return categories['categories']
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }

  Future getMealOfEachCategory(String category) async {
    final categorieyMeals =
        await mealWebServices.getMealOfEachCategory(category);
    print('categorieyMeals ${categorieyMeals['meals'][0]['strMeal']}');
    return categorieyMeals['meals']
        .map((category) => MealModel.fromJson(category))
        .toList();
  }

  Future getMealDetails(String name) async {
    final mealDetails =
        await mealWebServices.getMealDetails(name);
    print('mealDetails ${mealDetails['meals'][0]['strMeal']}');
    return mealDetails['meals'][0];
  }
}
