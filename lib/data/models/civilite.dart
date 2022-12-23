import 'dart:convert';

List<Civilite> civiliteFromMap(String str) => List<Civilite>.from(json.decode(str).map((x) => Civilite.fromMap(x)));

String civiliteToMap(List<Civilite> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Civilite {
  Civilite({
    required this.value,
    required this.libelle,
  });

  String value;
  String libelle;

  factory Civilite.fromMap(Map<String, dynamic> json) => Civilite(
    value: json["value"],
    libelle: json["libelle"],
  );

  Map<String, dynamic> toMap() => {
    "value": value,
    "libelle": libelle,
  };
}