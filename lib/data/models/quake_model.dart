class QuakeModel {
  final String? tanggal;
  final String? jam;
  final DateTime? datetime;
  final String? coordinates;
  final String? lintang;
  final String? bujur;
  final String? magnitude;
  final String? kedalaman;
  final String? wilayah;
  final String? potensi;
  final String? dirasakan;
  final String? shakemap;

  QuakeModel({
    this.tanggal,
    this.jam,
    this.datetime,
    this.coordinates,
    this.lintang,
    this.bujur,
    this.magnitude,
    this.kedalaman,
    this.wilayah,
    this.potensi,
    this.dirasakan,
    this.shakemap,
  });

  factory QuakeModel.fromJson(Map<String, dynamic> json) => QuakeModel(
        tanggal: json["tanggal"],
        jam: json["jam"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        coordinates: json["coordinates"],
        lintang: json["lintang"],
        bujur: json["bujur"],
        magnitude: json["magnitude"],
        kedalaman: json["kedalaman"],
        wilayah: json["wilayah"],
        potensi: json["potensi"],
        dirasakan: json["dirasakan"],
        shakemap: json["shakemap"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "jam": jam,
        "datetime": datetime?.toIso8601String(),
        "coordinates": coordinates,
        "lintang": lintang,
        "bujur": bujur,
        "magnitude": magnitude,
        "kedalaman": kedalaman,
        "wilayah": wilayah,
        "potensi": potensi,
        "dirasakan": dirasakan,
        "shakemap": shakemap,
      };
}
