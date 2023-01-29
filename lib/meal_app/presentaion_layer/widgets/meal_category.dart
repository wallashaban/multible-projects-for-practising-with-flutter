import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/meal_app/buisness_logic/cubit/meal_cubit.dart';
import 'package:todoapp/meal_app/data_layer/models/category_model.dart';
import 'package:todoapp/meal_app/presentaion_layer/widgets/meal.dart';

class MealCategory extends StatelessWidget {
  final CategoryModel model;
  const MealCategory({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
          onTap: ()  {
            BlocProvider.of<MealCubit>(context)
                .getMealOfEachCategory(model.category.toString()).then((value) {
                     Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocBuilder<MealCubit,MealState>(
                      builder: (context, snapshot) {
                        return Meal(
                              category: model.category.toString(),
                              model: BlocProvider.of<MealCubit>(context)
                                  .mealCategories,
                            );
                      }
                    )));
      
                });
             },
          child: BlocBuilder<MealCubit,MealState>(
            builder: (context, snapshot) {
              return Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: Colors.white),
                child: 
                Stack(alignment: Alignment.bottomCenter, children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Image(
                      image: NetworkImage(
                        model.categoryImage.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      model.category.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ]),
              );
            }
          ),
        );
  }
}
