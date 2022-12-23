class SouscriptionM {
  SouscriptionM({
    required this.produit,
    required this.periodicite,
    required this.objet,
    required this.mise,
  });

  String produit;
  String periodicite;
  String objet;
  String mise;

  factory SouscriptionM.fromMap(Map<String, dynamic> json) => SouscriptionM(
    produit: json["produit"],
    periodicite: json["periodicite"],
    objet: json["objet"],
    mise: json["mise"],
  );

  Map<String, dynamic> toMap() => {
    "produit": produit,
    "periodicite": periodicite,
    "objet": objet,
    "mise": mise,

  };
}