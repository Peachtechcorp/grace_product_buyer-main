List<Category> getCategoriesFromJson(List<dynamic> json) =>
    List.generate(json.length, (index) => Category.fromJson(json[index]));

class Category {
  int id;
  String name;
  String? description;

  Category({
    required this.id,
    required this.name,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      description: json["description"],
    );
  }

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
    };
  }
}
