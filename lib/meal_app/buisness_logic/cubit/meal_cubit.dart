// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/meal_app/data_layer/models/meal_model.dart';
import 'package:todoapp/meal_app/data_layer/repos/meal_repo.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealRepo mealRepo;
  MealCubit(
    this.mealRepo,
  ) : super(MealInitial());

  List meals = [];
  List categories = [];
  List mealCategories = [];
  Future getMaels() async {
    emit(GetMealsLoadingState());
    mealRepo.getMeals().then((meals) {
      this.meals = meals; // as List<MealModel>;
      //print('Meals : ${this.meals[0].id}');
      emit(GetMealsSuccesState());
    }).catchError((error) {
      emit(GetMealsErrorState(error: error));
      print('error$error');
    });
    return meals;
  }

  Future getCategories() async {
    emit(GetMealsCategoriesLoadingState());
    mealRepo.getMealCategories().then((categories) {
      this.categories = categories; // as List<MealModel>;
      //print('Categories : ${this.categories[0].id}');
      emit(GetMealsCategoriesSuccesState());
    }).catchError((error) {
      emit(GetMealsCategoriesErrorState(error: error));
      print('error$error');
    });
    return categories;
  }

  Future getMealOfEachCategory(String category) async {
    emit(GetMealOfEachCategoryLoadingState());
    mealRepo.getMealOfEachCategory(category).then((mealCategories) {
      this.mealCategories = mealCategories; // as List<MealModel>;
      print('mealCategories : ${this.mealCategories[0].id}');
      emit(GetMealOfEachCategorySuccesState());
    }).catchError((error) {
      emit(GetMealOfEachCategoryErrorState(error: error));
      print('error$error');
    });
  }

  MealModel mealDetails = MealModel();
  Future getMealDetails(String name) async {
    emit(GetMealDetailsLoadingState());
    mealRepo.getMealDetails(name).then((mealDetails) {
      this.mealDetails = MealModel.fromJson(mealDetails);
      // this.mealCategories = mealDetails; // as List<MealModel>;
      print('mealDetails : ${this.mealDetails.id}');
      emit(GetMealDetailsSuccesState());
    }).catchError((error) {
      emit(GetMealDetailsErrorState(error: error));
      print('error$error');
    });
  }

  MealModel searchDetails = MealModel();
  Future searchMeals(String name) async {
    emit(SearchByFirstLetterLoadingState());
    mealRepo.getMealDetails(name).then((searchDetails) {
      this.searchDetails = MealModel.fromJson(searchDetails);
      // this.mealCategories = mealDetails; // as List<MealModel>;
      print('searchDetails : ${this.searchDetails.id}');
      emit(SearchByFirstLetterSuccesState());
     // emit(Done());
    }).catchError((error) {
      emit(SearchByFirstLetterErrorState(error: error));
      print('error$error');
    });
  }
}
