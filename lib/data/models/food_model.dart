// ignore_for_file: constant_identifier_names

class FoodModel {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? region;
  final String? price;

  FoodModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.region,
    this.price,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        region: json["region"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "region": region,
        "price": price,
      };
}
