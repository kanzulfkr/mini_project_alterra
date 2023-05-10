import 'dart:convert';
import 'main_news.dart';

SuperNewss superNewssFromJson(String str) =>
    SuperNewss.fromJson(json.decode(str));

String superNewssToJson(SuperNewss data) => json.encode(data.toJson());

class SuperNewss {
  SuperNewss({
    required this.data,
  });

  List<MainNewss> data;

  factory SuperNewss.fromJson(Map<String, dynamic> json) => SuperNewss(
        data: List<MainNewss>.from(
            json["data"].map((x) => MainNewss.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
