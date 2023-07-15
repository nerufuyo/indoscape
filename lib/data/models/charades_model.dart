class CharadesModel {
  final int? index;
  final String? soal;
  final String? jawaban;

  CharadesModel({
    this.index,
    this.soal,
    this.jawaban,
  });

  factory CharadesModel.fromJson(Map<String, dynamic> json) => CharadesModel(
        index: json["index"],
        soal: json["soal"],
        jawaban: json["jawaban"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "soal": soal,
        "jawaban": jawaban,
      };
}
