part of 'meal_cubit.dart';

abstract class MealState extends Equatable {
  const MealState();

  @override
  List<Object> get props => [];
}

class MealInitial extends MealState {}

class GetMealsSuccesState extends MealState {}

class GetMealsLoadingState extends MealState {}

class GetMealsErrorState extends MealState {
  final String error;
  const GetMealsErrorState({
    required this.error,
  });
}

class GetMealsCategoriesSuccesState extends MealState {}

class GetMealsCategoriesLoadingState extends MealState {}

class GetMealsCategoriesErrorState extends MealState {
  final String error;
  const GetMealsCategoriesErrorState({
    required this.error,
  });
}

class GetMealOfEachCategorySuccesState extends MealState {}

class GetMealOfEachCategoryLoadingState extends MealState {}

class GetMealOfEachCategoryErrorState extends MealState {
  final String error;
  const GetMealOfEachCategoryErrorState({
    required this.error,
  });
}

class GetMealDetailsSuccesState extends MealState {}

class GetMealDetailsLoadingState extends MealState {}

class GetMealDetailsErrorState extends MealState {
  final String error;
  const GetMealDetailsErrorState({
    required this.error,
  });
}

class SearchByFirstLetterSuccesState extends MealState {}

class SearchByFirstLetterLoadingState extends MealState {}

class SearchByFirstLetterErrorState extends MealState {
  final String error;
  const SearchByFirstLetterErrorState({
    required this.error,
  });
}

class Done extends MealState{}
