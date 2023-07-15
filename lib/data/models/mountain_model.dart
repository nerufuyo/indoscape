class MountainModel {
  final int? id;
  final String? name;
  final int? elevation;
  final String? range;
  final String? region;
  final String? image;
  final bool? active;
  final List<String>? tags;
  final String? description;

  MountainModel({
    this.id,
    this.name,
    this.elevation,
    this.range,
    this.region,
    this.image,
    this.active,
    this.tags,
    this.description,
  });

  factory MountainModel.fromJson(Map<String, dynamic> json) => MountainModel(
        id: json["id"],
        name: json["name"],
        elevation: json["elevation"],
        range: json["range"],
        region: json["region"],
        image: json["image"],
        active: json["active"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "elevation": elevation,
        "range": range,
        "region": region,
        "image": image,
        "active": active,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "description": description,
      };
}
