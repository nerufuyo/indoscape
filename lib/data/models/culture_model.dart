class CultureModel {
  final int? id;
  final String? name;
  final String? description;
  final String? origin;
  final String? imageUrl;
  final String? type;
  final List<String>? tags;
  final String? history;

  CultureModel({
    this.id,
    this.name,
    this.description,
    this.origin,
    this.imageUrl,
    this.type,
    this.tags,
    this.history,
  });

  factory CultureModel.fromJson(Map<String, dynamic> json) => CultureModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        origin: json["origin"],
        imageUrl: json["imageURL"],
        type: json["type"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        history: json["history"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "origin": origin,
        "imageURL": imageUrl,
        "type": type,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "history": history,
      };
}
