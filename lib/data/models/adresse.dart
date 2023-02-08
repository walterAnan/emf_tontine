class Adresse {
  Adresse({
    this.code,
    this.guid,
    this.type,
    required this.adresse,
    required this.paysId,
    required this.codePostal,
    required this.quartier,
    required this.villeId,
    required this.telephone,
    required this.email,
  });

  int? code;
  String? guid;
  String? type;
  String adresse;
  int paysId;
  String codePostal;
  String quartier;
  int villeId;
  String telephone;
  String email;

  factory Adresse.fromMap(Map<String, dynamic> json) => Adresse(
    code: json["code"],
    guid: json["guid"],
    type: json["type"],
    adresse: json["adresse"],
    paysId: json["paysId"],
    codePostal: json["codePostal"],
    quartier: json["quartier"],
    villeId: json["villeId"],
    telephone: json["telephone"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "type": type,
    "adresse": adresse,
    "paysId": paysId,
    "codePostal": codePostal,
    "quartier": quartier,
    "villeId": villeId,
    "telephone": telephone,
    "email": email,
  };
}



// Model Pays

class Pays {
  Pays({
    this.code,
    this.guid,
    this.cPays,
    required this.nom,
    required this.indicatif,
    required this.codePostal,
    required this.quartier,
    required this.villeId,
    required this.telephone,
    required this.email,
  });

  int? code;
  String? guid;
  String? cPays;
  String nom;
  int indicatif;
  String codePostal;
  String quartier;
  int villeId;
  String telephone;
  String email;

  factory Pays.fromMap(Map<String, dynamic> json) => Pays(
    code: json["code"],
    guid: json["guid"],
    cPays: json["cPays"],
    nom: json["nom"],
    indicatif: json["indicatif"],
    codePostal: json["codePostal"],
    quartier: json["quartier"],
    villeId: json["villeId"],
    telephone: json["telephone"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "type": cPays,
    "adresse": nom,
    "paysId": indicatif,
    "codePostal": codePostal,
    "quartier": quartier,
    "villeId": villeId,
    "telephone": telephone,
    "email": email,
  };
}