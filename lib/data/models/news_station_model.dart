class NewsStationListModel {
  final String? name;
  final List<Path>? paths;

  NewsStationListModel({
    this.name,
    this.paths,
  });

  factory NewsStationListModel.fromJson(Map<String, dynamic> json) =>
      NewsStationListModel(
        name: json["name"],
        paths: json["paths"] == null
            ? []
            : List<Path>.from(json["paths"]!.map((x) => Path.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "paths": paths == null
            ? []
            : List<dynamic>.from(paths!.map((x) => x.toJson())),
      };
}

class Path {
  final String? name;
  final String? path;

  Path({
    this.name,
    this.path,
  });

  factory Path.fromJson(Map<String, dynamic> json) => Path(
        name: json["name"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
      };
}
