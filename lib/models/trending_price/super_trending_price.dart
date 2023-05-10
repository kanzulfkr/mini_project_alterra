import 'dart:convert';

import 'package:bahanku/models/trending_price/main_trending_price.dart';

SuperTrendingPrice superTrendingPriceFromJson(String str) =>
    SuperTrendingPrice.fromJson(json.decode(str));

String superTrendingPriceToJson(SuperTrendingPrice data) =>
    json.encode(data.toJson());

class SuperTrendingPrice {
  SuperTrendingPrice({
    required this.data,
  });

  List<MainTrendingPrice> data;

  factory SuperTrendingPrice.fromJson(Map<String, dynamic> json) =>
      SuperTrendingPrice(
        data: List<MainTrendingPrice>.from(
            json["data"].map((x) => MainTrendingPrice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
