
import 'dart:convert';
List<GetAll> getAllFromJson(List<int> value) => List<GetAll>.from(json.decode(utf8.decode(value)).map((x) => GetAll.fromJson(x)));

class GetAll {
  String category;
  String imgUrl;
  String title;
  String date;
  String author;
  String description;

  GetAll({
    required this.category,
    required this.imgUrl,
    required this.title,
    required this.date,
    required this.author,
    required this.description,
  });

  factory GetAll.fromJson(Map<String, dynamic> json) => GetAll(
    category: json["category"] ?? "",
    imgUrl: (json["img_url"] == "not-found" || json["img_url"] == "")
        ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
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