class CategoryCommodity {
  String id;
  String name;

  CategoryCommodity({
    required this.id,
    required this.name,
  });

  factory CategoryCommodity.fromJson(Map<String, dynamic> json) =>
      CategoryCommodity(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
