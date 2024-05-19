// To parse this JSON data, do
//
//     final caregorymodel = caregorymodelFromJson(jsonString);

import 'dart:convert';

Caregorymodel caregorymodelFromJson(String str) =>
    Caregorymodel.fromJson(json.decode(str));

String caregorymodelToJson(Caregorymodel data) => json.encode(data.toJson());

class Caregorymodel {
  List<Category> category;

  Caregorymodel({
    required this.category,
  });

  factory Caregorymodel.fromJson(Map<String, dynamic> json) => Caregorymodel(
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class Category {
  String name;
  List<String> subcategory;

  Category({
    required this.name,
    required this.subcategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subcategory": List<dynamic>.from(subcategory.map((x) => x)),
      };
}
