// To parse this JSON data, do
//
//     final categoriesVm = categoriesVmFromJson(jsonString);

import 'dart:convert';

CategoriesVm categoriesVmFromJson(String str) => CategoriesVm.fromJson(json.decode(str));

String categoriesVmToJson(CategoriesVm data) => json.encode(data.toJson());

class CategoriesVm {
  CategoriesVm({
    this.categories,
  });

  List<Category> categories;

  factory CategoriesVm.fromJson(Map<String, dynamic> json) => CategoriesVm(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.avatar,
  });

  int id;
  String name;
  String avatar;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };
}