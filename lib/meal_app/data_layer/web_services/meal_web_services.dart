// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:todoapp/meal_app/constants/strings.dart';

class MealWebServices {
  Dio? dio;

  MealWebServices() {
    BaseOptions options = BaseOptions(
       baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
      sendTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

   Future  getMeals() async {
    try {
      Response response = await dio!.get('search.php?f=b');
      //print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  Future  getMealCategories() async {
    try {
      Response response = await dio!.get('categories.php');
     // print('Category ${response.data}');
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future  getMealOfEachCategory(String category) async {
    try {
      Response response = await dio!.get('filter.php?c=$category');
     // print('Category ${response.data}');
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future  getMealDetails(String name) async {
    try {
      Response response = await dio!.get('search.php?s=$name');
      print('MealDetailsweb ${response.data}');
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
