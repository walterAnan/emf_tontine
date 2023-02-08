// To parse this JSON data, do
//
//     final pays = paysFromMap(jsonString);

import 'dart:convert';

// Pays paysFromMap(String str) => Pays.fromMap(json.decode(str));
List<Pays> paysFromMap(String str) => List<Pays>.from(json.decode(str).map((x) => Pays.fromMap(x)));

// String paysToMap(Pays? data) => json.encode(data!.toMap());
String paysToMap(List<Pays> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Pays {
  Pays({
    this.code,
    this.guid,
    this.cPays,
    this.nom,
    this.indicatif,
    this.devise,
  });

  int? code;
  String? guid;
  String? cPays;
  String? nom;
  String? indicatif;
  Devise? devise;

  factory Pays.fromMap(Map<String, dynamic> json) => Pays(
    code: json["code"],
    guid: json["guid"],
    cPays: json["cPays"],
    nom: json["nom"],
    indicatif: json["indicatif"],
    devise: Devise.fromMap(json["devise"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "cPays": cPays,
    "nom": nom,
    "indicatif": indicatif,
    "devise": devise!.toMap(),
  };
}

class Devise {
  Devise({
    this.code,
    this.guid,
    this.nom,
    this.nbreDecimal,
    this.quotite,
  });

  int? code;
  String? guid;
  String? nom;
  int? nbreDecimal;
  int? quotite;

  factory Devise.fromMap(Map<String, dynamic> json) => Devise(
    code: json["code"],
    guid: json["guid"],
    nom: json["nom"],
    nbreDecimal: json["nbreDecimal"],
    quotite: json["quotite"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "nom": nom,
    "nbreDecimal": nbreDecimal,
    "quotite": quotite,
  };
}
