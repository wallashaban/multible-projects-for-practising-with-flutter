import 'dart:convert';

class CategoryModel {
  dynamic id;
  String? category;
  String? categoryImage;
  String? description;
  CategoryModel({
    required this.id,
    required this.category,
    required this.categoryImage,
    required this.description,
  });

 CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['idCategory'];
    category = json['strCategory'];
    categoryImage = json['strCategoryThumb'];
    description = json['strCategoryDescription'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'categoryImage': categoryImage,
      'description': description,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt(),
      category: map['category'],
      categoryImage: map['categoryImage'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());


}
