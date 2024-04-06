
import 'dart:convert';
List<Search> getSeachResultsFromJson(List<int> value) => List<Search>.from(json.decode(utf8.decode(value)).map((x) => Search.fromJson(x)));

class Search {
  String category;
  String imgUrl;
  String title;
  String date;
  String author;
  String description;

  Search({
    required this.category,
    required this.imgUrl,
    required this.title,
    required this.date,
    required this.author,
    required this.description,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    category: json["category"] ?? "",
    imgUrl: (json["img_url"] == "not-found" || json["img_url"] == "")
        ? "https://static.vecteezy.com/system/resources/previews/007/126/739/non_2x/question-mark-icon-free-vector.jpg"
        : convertUrl(json["img_url"]),
    title: json["title"] ?? "",
    date: json["date"] ?? "1970-01-01",
    author: json["author"] ?? "",
    description: json["description"] ?? "",
  );

}

String convertUrl(String imageUrl) {
  String newUrl = imageUrl;
  if (!(imageUrl.contains("https://") || imageUrl.contains("http://"))) {
    newUrl = "https://$imageUrl";
  }
  return newUrl;
}