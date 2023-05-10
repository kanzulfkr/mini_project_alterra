// ignore_for_file: file_names

class MainNewss {
  String id;
  String name;
  String namewebsite;
  String time;
  String lokasi;
  String image;
  String sources;

  MainNewss({
    required this.id,
    required this.name,
    required this.namewebsite,
    required this.time,
    required this.lokasi,
    required this.image,
    required this.sources,
  });

  factory MainNewss.fromJson(Map<String, dynamic> json) => MainNewss(
        id: json["id"],
        name: json["name"],
        namewebsite: json["namewebsite"],
        time: json["time"],
        lokasi: json["lokasi"],
        image: json["image"],
        sources: json["sources"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "namewebsite": namewebsite,
        "time": time,
        "lokasi": lokasi,
        "image": image,
        "sources": sources,
      };
}
