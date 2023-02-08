// To parse this JSON data, do
//
//     final produit = produitFromMap(jsonString);

import 'dart:convert';

Produit produitFromMap(String str) => Produit.fromMap(json.decode(str));

String produitToMap(Produit data) => json.encode(data.toMap());

class Produit {
  Produit({
    required this.code,
    required this.guid,
    required this.cProduit,
    required this.cInterne,
    required this.nomProduit,
    required this.description,
    required this.cycle,
    required this.freqCollecte,
    required this.mntMinCotisable,
    required this.mntMaxCotisable,
    required this.typeCotisation,
    required this.ribCptCommission,
    required this.statut,
  });

  int code;
  String guid;
  String cProduit;
  String cInterne;
  String nomProduit;
  String description;
  String cycle;
  String freqCollecte;
  int mntMinCotisable;
  int mntMaxCotisable;
  String typeCotisation;
  String ribCptCommission;
  String statut;

  factory Produit.fromMap(Map<String, dynamic> json) => Produit(
    code: json["code"],
    guid: json["guid"],
    cProduit: json["cProduit"],
    cInterne: json["cInterne"],
    nomProduit: json["nomProduit"],
    description: json["description"],
    cycle: json["cycle"],
    freqCollecte: json["freqCollecte"],
    mntMinCotisable: json["mntMinCotisable"],
    mntMaxCotisable: json["mntMaxCotisable"],
    typeCotisation: json["typeCotisation"],
    ribCptCommission: json["ribCptCommission"],
    statut: json["statut"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "cProduit": cProduit,
    "cInterne": cInterne,
    "nomProduit": nomProduit,
    "description": description,
    "cycle": cycle,
    "freqCollecte": freqCollecte,
    "mntMinCotisable": mntMinCotisable,
    "mntMaxCotisable": mntMaxCotisable,
    "typeCotisation": typeCotisation,
    "ribCptCommission": ribCptCommission,
    "statut": statut,
  };
}
