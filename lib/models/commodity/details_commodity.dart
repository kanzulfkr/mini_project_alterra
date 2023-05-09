class DetailCommodity {
  String value;
  String name;
  String display;
  String id;

  DetailCommodity({
    required this.value,
    required this.name,
    required this.display,
    required this.id,
  });

  factory DetailCommodity.fromJson(Map<String, dynamic> json) =>
      DetailCommodity(
        value: json["value"],
        name: json["name"],
        display: json["display"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
        "display": display,
        "id": id,
      };
}
