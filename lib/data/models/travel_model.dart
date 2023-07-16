class TravelModel {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final String? culture;
  final String? history;
  final String? region;
  final String? type;
  final double? popularity;
  final List<String>? highlights;

  TravelModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.culture,
    this.history,
    this.region,
    this.type,
    this.popularity,
    this.highlights,
  });

  factory TravelModel.fromJson(Map<String, dynamic> json) => TravelModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        culture: json["culture"],
        history: json["history"],
        region: json["region"],
        type: json["type"],
        popularity: json["popularity"]?.toDouble(),
        highlights: json["highlights"] == null
            ? []
            : List<String>.from(json["highlights"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "culture": culture,
        "history": history,
        "region": region,
        "type": type,
        "popularity": popularity,
        "highlights": highlights == null
            ? []
            : List<dynamic>.from(highlights!.map((x) => x)),
      };
}
