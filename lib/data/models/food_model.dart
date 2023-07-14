// ignore_for_file: constant_identifier_names

class FoodModel {
  final String? name;
  final String? description;
  final String? imageUrl;
  final Region? region;
  final String? price;

  FoodModel({
    this.name,
    this.description,
    this.imageUrl,
    this.region,
    this.price,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        region: regionValues.map[json["region"]]!,
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "region": regionValues.reverse[region],
        "price": price,
      };
}

enum Region { JAVA, SUMATRA }

final regionValues =
    EnumValues({"Java": Region.JAVA, "Sumatra": Region.SUMATRA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
