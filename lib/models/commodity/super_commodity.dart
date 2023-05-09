import 'dart:convert';
import 'main_commodity.dart';

SuperCommodity superCommodityFromJson(String str) =>
    SuperCommodity.fromJson(json.decode(str));

String superCommodityToJson(SuperCommodity data) => json.encode(data.toJson());

class SuperCommodity {
  SuperCommodity({
    required this.data,
  });

  List<MainCommodity> data;

  factory SuperCommodity.fromJson(Map<String, dynamic> json) => SuperCommodity(
        data: List<MainCommodity>.from(
            json["data"].map((x) => MainCommodity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
