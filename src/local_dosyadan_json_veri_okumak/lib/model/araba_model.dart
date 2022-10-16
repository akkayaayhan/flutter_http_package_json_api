import 'dart:convert';

Araba arabaFromMap(String str) => Araba.fromMap(json.decode(str));

String arabaToMap(Araba data) => json.encode(data.toMap());

class Araba {
  Araba({
    required this.arabaAdi,
    required this.ulke,
    required this.kurulusYil,
    required this.model,
  });

  final String arabaAdi;
  final String ulke;
  final int kurulusYil;
  final List<Model> model;

  factory Araba.fromMap(Map<String, dynamic> json) => Araba(
        arabaAdi: json["araba_adi"],
        ulke: json["ulke"],
        kurulusYil: json["kurulus_yil"],
        model: List<Model>.from(json["model"].map((x) => Model.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "araba_adi": arabaAdi,
        "ulke": ulke,
        "kurulus_yil": kurulusYil,
        "model": List<dynamic>.from(model.map((x) => x.toMap())),
      };
}

class Model {
  Model({
    required this.modelSerisi,
    required this.fiyat,
    required this.benzinliMi,
  });

  final String modelSerisi;
  final int fiyat;
  final bool benzinliMi;

  factory Model.fromMap(Map<String, dynamic> json) => Model(
        modelSerisi: json["model_serisi"],
        fiyat: json["fiyat"],
        benzinliMi: json["benzinliMi"],
      );

  Map<String, dynamic> toMap() => {
        "model_serisi": modelSerisi,
        "fiyat": fiyat,
        "benzinliMi": benzinliMi,
      };
}
