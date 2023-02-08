import 'dart:convert';

List<Objet> objetFromMap(String str) => List<Objet>.from(json.decode(str).map((x) => Objet.fromMap(x)));

String objetToMap(List<Objet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Objet {
  Objet({
    required this.value,
    required this.libelle,
  });

  String value;
  String libelle;

  factory Objet.fromMap(Map<String, dynamic> json) => Objet(
    value: json["value"],
    libelle: json["libelle"],
  );

  Map<String, dynamic> toMap() => {
    "value": value,
    "libelle": libelle,
  };
}