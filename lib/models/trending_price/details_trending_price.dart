class DetailTrendingPrice {
  String id;
  String name;
  String price;
  String percent;
  String indicatorprice;
  String time;
  String image;

  DetailTrendingPrice({
    required this.id,
    required this.name,
    required this.price,
    required this.percent,
    required this.indicatorprice,
    required this.time,
    required this.image,
  });

  factory DetailTrendingPrice.fromJson(Map<String, dynamic> json) =>
      DetailTrendingPrice(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        percent: json["percent"],
        indicatorprice: json["indicatorprice"],
        time: json["time"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "percent": percent,
        "indicatorprice": indicatorprice,
        "time": time,
        "image": image,
      };
}
