import 'dart:convert';

List<GetCategories> getCategoriesFromJson(List<int> value) => List<GetCategories>.from(json.decode(utf8.decode(value)).map((x) => GetCategories.fromJson(x)));

class GetCategories {
  String category;

  GetCategories({
    required this.category,
  });

  factory GetCategories.fromJson(Map<String, dynamic> json) => GetCategories(
    category: json["category"] ?? [],
  );
}