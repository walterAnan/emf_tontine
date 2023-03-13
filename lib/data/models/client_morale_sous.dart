// To parse this JSON data, do
//
//     final clientMoraleSous = clientMoraleSousFromMap(jsonString);

import 'dart:convert';

import 'package:emf_tontine/data/models/client_morale_sous.dart';

ClientMoraleSous clientMoraleSousFromMap(String str) => ClientMoraleSous.fromMap(json.decode(str));

String clientMoraleSousToMap(ClientMoraleSous data) => json.encode(data.toMap());

class ClientMoraleSous {
  ClientMoraleSous({
    required this.montantMise,
    required this.cycleCarte,
    required this.objetSous,
    required this.client,
    required this.cInterneProduit,
    required this.produitId,
    required this.deviseId,
    required this.agenceId,
    required this.statut,
  });

  int montantMise;
  String cycleCarte;
  ObjetSousM objetSous;
  ClientM client;
  String cInterneProduit;
  int produitId;
  int deviseId;
  int agenceId;
  String statut;

  factory ClientMoraleSous.fromMap(Map<String, dynamic> json) => ClientMoraleSous(
    montantMise: json["montantMise"],
    cycleCarte: json["cycleCarte"],
    objetSous: ObjetSousM.fromMap(json["objetSous"]),
    client: ClientM.fromMap(json["client"]),
    cInterneProduit: json["cInterneProduit"],
    produitId: json["produitId"],
    deviseId: json["deviseId"],
    agenceId: json["agenceId"],
    statut: json["statut"],
  );

  Map<String, dynamic> toMap() => {
    "montantMise": montantMise,
    "cycleCarte": cycleCarte,
    "objetSous": objetSous.toMap(),
    "client": client.toMap(),
    "cInterneProduit": cInterneProduit,
    "produitId": produitId,
    "deviseId": deviseId,
    "agenceId": agenceId,
    "statut": statut,
  };
}

class ClientM {
  ClientM({
    required this.personne,
    required this.gestionnaireId,
    required this.typeClientId,
  });

  PersonneM personne;
  int gestionnaireId;
  int typeClientId;

  factory ClientM.fromMap(Map<String, dynamic> json) => ClientM(
    personne: PersonneM.fromMap(json["personne"]),
    gestionnaireId: json["gestionnaireId"],
    typeClientId: json["typeClientId"],
  );

  Map<String, dynamic> toMap() => {
    "personne": personne.toMap(),
    "gestionnaireId": gestionnaireId,
    "typeClientId": typeClientId,
  };
}

class PersonneM {
  PersonneM({
    required this.adresse,
    required this.resident,
    required this.dateNaissance,
    required this.paysResidence,
    required this.nationalite,
    required this.raisonSociale,
    required this.nif,
    required this.nomGerant,
    required this.formeJuridique,
  });

  AdresseM adresse;
  bool resident;
  DateTime dateNaissance;
  String paysResidence;
  String nationalite;
  String raisonSociale;
  String nif;
  String nomGerant;
  String formeJuridique;

  factory PersonneM.fromMap(Map<String, dynamic> json) => PersonneM(
    adresse: AdresseM.fromMap(json["adresse"]),
    resident: json["resident"],
    dateNaissance: DateTime.parse(json["dateNaissance"]),
    paysResidence: json["paysResidence"],
    nationalite: json["nationalite"],
    raisonSociale: json["raisonSociale"],
    nif: json["NIF"],
    nomGerant: json["nomGerant"],
    formeJuridique: json["formeJuridique"],
  );

  Map<String, dynamic> toMap() => {
    "adresse": adresse.toMap(),
    "resident": resident,
    "dateNaissance": dateNaissance.toIso8601String(),
    "paysResidence": paysResidence,
    "nationalite": nationalite,
    "raisonSociale": raisonSociale,
    "NIF": nif,
    "nomGerant": nomGerant,
    "formeJuridique": formeJuridique,
  };
}

class AdresseM {
  AdresseM({
    // required this.type,
    required this.adresse,
    required this.paysId,
    required this.codePostal,
    required this.quartier,
    required this.villeId,
    required this.telephone,
    required this.email,
  });

  // String type;
  String adresse;
  int paysId;
  String codePostal;
  String quartier;
  int villeId;
  String telephone;
  String email;

  factory AdresseM.fromMap(Map<String, dynamic> json) => AdresseM(
    // type: json["type"],
    adresse: json["adresse"],
    paysId: json["paysId"],
    codePostal: json["codePostal"],
    quartier: json["quartier"],
    villeId: json["villeId"],
    telephone: json["telephone"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    // "type": type,
    "adresse": adresse,
    "paysId": paysId,
    "codePostal": codePostal,
    "quartier": quartier,
    "villeId": villeId,
    "telephone": telephone,
    "email": email,
  };
}


class ObjetSousM {
  ObjetSousM({
    this.code = 1047,
    this.guid = '35c4cb51-0f41-4553-85bb-ee7b37d77011',
    this.libelle = 'Epargne Enfant',
  });

  int? code;
  String? guid;
  String? libelle;

  factory ObjetSousM.fromMap(Map<String, dynamic> json) => ObjetSousM(
    code: json["code"],
    guid: json["guid"],
    libelle: json["libelle"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "libelle": libelle,
  };
}



