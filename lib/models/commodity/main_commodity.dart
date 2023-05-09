import 'category_commodity.dart';
import 'details_commodity.dart';

class MainCommodity {
  String id;
  String name;
  String thumbnail;
  String picturedetail;
  String titlecategory;
  String highestprice;
  String lowestprice;
  String calorie;
  String carbo;
  String protein;
  CategoryCommodity category;
  List<DetailCommodity> details;

  MainCommodity({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.picturedetail,
    required this.titlecategory,
    required this.highestprice,
    required this.lowestprice,
    required this.calorie,
    required this.carbo,
    required this.protein,
    required this.category,
    required this.details,
  });

  factory MainCommodity.fromJson(Map<String, dynamic> json) => MainCommodity(
        id: json["id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        picturedetail: json["picturedetail"],
        titlecategory: json["titlecategory"],
        highestprice: json["highestprice"],
        lowestprice: json["lowestprice"],
        calorie: json["calorie"],
        carbo: json["carbo"],
        protein: json["protein"],
        category: CategoryCommodity.fromJson(json["category"]),
        details: List<DetailCommodity>.from(
            json["details"].map((x) => DetailCommodity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
        "calorie": calorie,
        "carbo": carbo,
        "protein": protein,
        "picturedetail": protein,
        "titlecategory": protein,
        "highestprice": protein,
        "lowestprice": protein,
        "category": category.toJson(),
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}
