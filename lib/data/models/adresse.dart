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