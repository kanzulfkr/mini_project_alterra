import 'package:bahanku/models/trending_price/details_trending_price.dart';

class MainTrendingPrice {
  String id;
  String name;

  List<DetailTrendingPrice> details;

  MainTrendingPrice({
    required this.id,
    required this.name,
    required this.details,
  });

  factory MainTrendingPrice.fromJson(Map<String, dynamic> json) =>
      MainTrendingPrice(
        id: json["id"],
        name: json["name"],
        details: List<DetailTrendingPrice>.from(
            json["details"].map((x) => DetailTrendingPrice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}
