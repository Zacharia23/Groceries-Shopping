import 'dart:convert';
import 'products_model.dart';

class CategoriesModel {
  final String id;
  final String name;
  final String slug;
  final String categoryImage;
  final List<ProductModel> products;

  CategoriesModel({
    this.id = '',
    this.name= '',
    this.slug= '',
    this.categoryImage= '',
    required this.products,
  });

  factory CategoriesModel.fromRawJson(String string) => CategoriesModel.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    id: json['id'],
    name: json['name'],
    slug: json['slug'],
    categoryImage: json['category_image'],
    products: List<ProductModel>.from(json['products'].map((x) => ProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id':id,
    'name':name,
    'slug':slug,
    'category_image': categoryImage,
    'products': List<ProductModel>.from(products.map((e) => e.toJson())),
  };
}