// To parse this JSON data, do
//
//     final ville = villeFromMap(jsonString);

import 'dart:convert';

import 'package:emf_tontine/data/models/adresse.dart';

List<Ville> villeFromMap(String str) => List<Ville>.from(json.decode(str).map((x) => Ville.fromMap(x)));

String villeToMap(List<Ville> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Ville {
  Ville({
    required this.code,
    required this.guid,
    required this.nom,
    required this.pays,
  });

  int code;
  String guid;
  String nom;
  Pays pays;

  factory Ville.fromMap(Map<String, dynamic> json) => Ville(
    code: json["code"],
    guid: json["guid"],
    nom: json["nom"],
    pays: Pays.fromMap(json["pays"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "nom": nom,
    "pays": pays.toMap(),
  };
}

class Devise {
  Devise({
    required this.code,
    required this.guid,
    required this.nom,
    required this.nbreDecimal,
    required this.quotite,
  });

  int code;
  String guid;
  String nom;
  int nbreDecimal;
  int quotite;

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
