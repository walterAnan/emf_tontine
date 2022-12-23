
import 'dart:convert';

import 'package:emf_tontine/data/models/adresse.dart';


Personne personneFromMap(String str) => Personne.fromMap(json.decode(str));

String personneToMap(Personne data) => json.encode(data.toMap());

class Personne {
  Personne({
    this.code,
    this.guid,
    this.cParrainage,
    this.cParrain,
    this.gestionnaireId,
    this.typeClientId,
    required this.personne,
  });

  int? code;
  String? guid;
  String? cParrainage;
  String? cParrain;
  int? gestionnaireId;
  int? typeClientId;
  PersonnePersonne personne;

  factory Personne.fromMap(Map<String, dynamic> json) => Personne(
    code: json["code"],
    guid: json["guid"],
    cParrainage: json["cParrainage"],
    cParrain: json["cParrain"],
    gestionnaireId: json["gestionnaireId"],
    typeClientId: json["typeClientId"],
    personne: PersonnePersonne.fromMap(json["personne"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "cParrainage": cParrainage,
    "cParrain": cParrain,
    "gestionnaireId": gestionnaireId,
    "typeClientId": typeClientId,
    "personne": personne.toMap(),
  };
}

class PersonnePersonne {
  PersonnePersonne({
    this.code,
    this.guid,
    this.codePers,
    required this.nomComplet,
    required this.telephone,
    required this.email,
    this.adresse,
    required this.resident,
    required this.dateNaissance,
    required this.paysResidence,
    required this.nationalite,
    required this.userDeSecurite,
    required this.raisonSociale,
    this.nif,
    this.nomGerant,
    this.formeJuridique,
  });

  int? code;
  String? guid;
  String? codePers;
  String nomComplet;
  String telephone;
  String email;
  Adresse? adresse;
  bool resident;
  DateTime dateNaissance;
  String paysResidence;
  String nationalite;
  String userDeSecurite;
  String raisonSociale;
  String? nif;
  String? nomGerant;
  String? formeJuridique;

  factory PersonnePersonne.fromMap(Map<String, dynamic> json) => PersonnePersonne(
    code: json["code"],
    guid: json["guid"],
    codePers: json["codePers"],
    nomComplet: json["nomComplet"],
    telephone: json["telephone"],
    email: json["email"],
    adresse: Adresse.fromMap(json["adresse"]),
    resident: json["resident"],
    dateNaissance: DateTime.parse(json["dateNaissance"]),
    paysResidence: json["paysResidence"],
    nationalite: json["nationalite"],
    userDeSecurite: json["userDeSecurite"],
    raisonSociale: json["raisonSociale"],
    nif: json["NIF"],
    nomGerant: json["nomGerant"],
    formeJuridique: json["formeJuridique"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "codePers": codePers,
    "nomComplet": nomComplet,
    "telephone": telephone,
    "email": email,
    "adresse": adresse?.toMap(),
    "resident": resident,
    "dateNaissance": dateNaissance.toIso8601String(),
    "paysResidence": paysResidence,
    "nationalite": nationalite,
    "userDeSecurite": userDeSecurite,
    "raisonSociale": raisonSociale,
    "NIF": nif,
    "nomGerant": nomGerant,
    "formeJuridique": formeJuridique,
  };
}



class Role {
  Role({
    this.code,
    this.guid,
    this.personne,
  });

  int? code;
  String? guid;
  RolePersonne? personne;

  factory Role.fromMap(Map<String, dynamic> json) => Role(
    code: json["code"],
    guid: json["guid"],
    personne: RolePersonne.fromMap(json["personne"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "personne": personne?.toMap(),
  };
}

class RolePersonne {
  RolePersonne({
    required this.code,
    required this.guid,
    required this.codePers,
    required this.nomComplet,
    required this.telephone,
    required this.email,
    required this.adresse,
    required this.resident,
    required this.dateNaissance,
    required this.paysResidence,
    required this.nationalite,
    required this.userDeSecurite,
    required this.roles,
  });

  int code;
  String guid;
  String codePers;
  String nomComplet;
  String telephone;
  String email;
  Adresse adresse;
  bool resident;
  DateTime dateNaissance;
  String paysResidence;
  String nationalite;
  String userDeSecurite;
  List<String> roles;

  factory RolePersonne.fromMap(Map<String, dynamic> json) => RolePersonne(
    code: json["code"],
    guid: json["guid"],
    codePers: json["codePers"],
    nomComplet: json["nomComplet"],
    telephone: json["telephone"],
    email: json["email"],
    adresse: Adresse.fromMap(json["adresse"]),
    resident: json["resident"],
    dateNaissance: DateTime.parse(json["dateNaissance"]),
    paysResidence: json["paysResidence"],
    nationalite: json["nationalite"],
    userDeSecurite: json["userDeSecurite"],
    roles: List<String>.from(json["roles"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "codePers": codePers,
    "nomComplet": nomComplet,
    "telephone": telephone,
    "email": email,
    "adresse": adresse.toMap(),
    "resident": resident,
    "dateNaissance": dateNaissance.toIso8601String(),
    "paysResidence": paysResidence,
    "nationalite": nationalite,
    "userDeSecurite": userDeSecurite,
    "roles": List<dynamic>.from(roles.map((x) => x)),
  };
}
