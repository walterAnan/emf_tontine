// To parse this JSON data, do
//https://app.quicktype.io/
//     final clientParticulier = clientParticulierFromMap(jsonString);

import 'dart:convert';
import 'dart:ffi';


List<ClientParticulier> clientParticulierFromMap(String str) => List<ClientParticulier>.from(json.decode(str).map((x)=>clientParticulierFromMap(str)));

String clientParticulierToMap(ClientParticulier? data) => json.encode(data!.toMap());

class ClientParticulier {
  ClientParticulier({
    this.code,
    this.guid ,
    this.dateSous,
    required this.montantMise,
    this.numeroCarte,
    required this.intituleCarte,
    this.soldeCarte,
    this.montantBloque,
    this.dateSolde,
    this.dateDernierMvt,
    required this.cycleCarte,
    required this.objetSous,
    required this.client,
    required this.cInterneProduit,
    required this.produitId,
    required this.deviseId,
    required this.agenceId,
    this.compteId = 71,
    this.statut = 'ACTIF',
  });

  double? code;
  String? guid;
  DateTime? dateSous;
  double montantMise;
  String? numeroCarte;
  String intituleCarte;
  int? soldeCarte;
  int? montantBloque;
  DateTime? dateSolde;
  DateTime? dateDernierMvt;
  String cycleCarte;
  ObjetSous objetSous;
  Client client;
  String cInterneProduit;
  int produitId;
  int deviseId;
  int? agenceId;
  int? compteId;
  String? statut;

  factory ClientParticulier.fromMap(Map<String, dynamic> json) => ClientParticulier(
    code: json["code"],
    guid: json["guid"],
    dateSous: json["dateSous"],
    montantMise: json["montantMise"],
    numeroCarte: json["numeroCarte"],
    intituleCarte: json["intituleCarte"],
    soldeCarte: json["soldeCarte"],
    montantBloque: json["montantBloque"],
    dateSolde: json["dateSolde"],
    dateDernierMvt: DateTime.parse(json["dateDernierMvt"]),
    cycleCarte: json["cycleCarte"],
    objetSous: ObjetSous.fromMap(json["objetSous"]),
    client: Client.fromMap(json["client"]),
    cInterneProduit: json["cInterneProduit"],
    produitId: json["produitId"],
    deviseId: json["deviseId"],
    agenceId: json["agenceId"],
    compteId: json["compteId"],
    statut: json["statut"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "dateSous": dateSous,
    "montantMise": montantMise,
    "numeroCarte": numeroCarte,
    "intituleCarte": intituleCarte,
    "soldeCarte": soldeCarte,
    "montantBloque": montantBloque,
    "dateSolde": dateSolde,
    "dateDernierMvt": dateDernierMvt,
    "cycleCarte": cycleCarte,
    "objetSous": objetSous.toMap(),
    "client": client.toMap(),
    "cInterneProduit": cInterneProduit,
    "produitId": produitId,
    "deviseId": deviseId,
    "agenceId": agenceId,
    "compteId": compteId,
    "statut": statut,
  };
}

class Client {
  Client({
    this.code,
    this.guid,
    required this.personne,
    this.cParrainage,
    this.cParrain,
    this.gestionnaireId = 274,
    this.typeClientId = 1041,
  });

  int? code;
  String? guid;
  Personne personne;
  String? cParrainage;
  String? cParrain;
  int? gestionnaireId;
  int? typeClientId;

  factory Client.fromMap(Map<String, dynamic> json) => Client(
    code: json["code"],
    guid: json["guid"],
    personne: Personne.fromMap(json["personne"]),
    cParrainage: json["cParrainage"],
    cParrain: json["cParrain"],
    gestionnaireId: json["gestionnaireId"],
    typeClientId: json["typeClientId"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "personne": personne.toMap(),
    "cParrainage": cParrainage,
    "cParrain": cParrain,
    "gestionnaireId": gestionnaireId,
    "typeClientId": typeClientId,
  };
}

class Personne {
  Personne({
    this.code,
    this.guid,
    this.codePers,
    this.nomComplet,
    required this.adresse,
    required this.resident,
    required this.dateNaissance,
    required this.paysResidence,
    required this.nationalite,
    this.userDeSecurite,
    this.roles,
    this.civilite,
    required this.nom,
    this.prenom,
    required this.sexe,
    this.photo,
    this.etatMatrimoniale,
  });

  double? code;
  String? guid;
  String? codePers;
  String? nomComplet;
  Adresse adresse;
  bool resident;
  String dateNaissance;
  String paysResidence;
  String nationalite;
  String? userDeSecurite;
  List<Role?>? roles;
  String? civilite;
  String? nom;
  String? prenom;
  String? sexe;
  String? photo;
  String? etatMatrimoniale;

  factory Personne.fromMap(Map<String, dynamic> json) => Personne(
    code: json["code"],
    guid: json["guid"],
    codePers: json["codePers"],
    nomComplet: json["nomComplet"],
    adresse: Adresse.fromMap(json["adresse"]),
    resident: json["resident"],
    dateNaissance: json["dateNaissance"],
    paysResidence: json["paysResidence"],
    nationalite: json["nationalite"],
    userDeSecurite: json["userDeSecurite"],
    roles: json["roles"] == null ? [] : List<Role?>.from(json["roles"]!.map((x) => Role.fromMap(x))),
    civilite: json["civilite"],
    nom: json["nom"],
    prenom: json["prenom"],
    sexe: json["sexe"],
    photo: json["photo"],
    etatMatrimoniale: json["etatMatrimoniale"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "codePers": codePers,
    "nomComplet": nomComplet,
    "adresse": adresse.toMap(),
    "resident": resident,
    "dateNaissance": dateNaissance,
    "paysResidence": paysResidence,
    "nationalite": nationalite,
    "userDeSecurite": userDeSecurite,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x!.toMap())),
    "civilite": civilite,
    "nom": nom,
    "prenom": prenom,
    "sexe": sexe,
    "photo": photo,
    "etatMatrimoniale": etatMatrimoniale,
  };
}

class Adresse {
  Adresse({
    this.type ,
    required this.adresse,
    required this.paysId,
    this.codePostal,
    this.quartier,
    required this.villeId,
    required this.telephone,
    this.email,
  });

  String? type;
  String adresse;
  int paysId;
  String? codePostal;
  String? quartier;
  int villeId;
  String telephone;
  String? email;

  factory Adresse.fromMap(Map<String, dynamic> json) => Adresse(
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

class Role {
  Role({
    this.code,
    this.guid,
    this.personne,
  });

  int? code;
  String? guid;
  String? personne;

  factory Role.fromMap(Map<String, dynamic> json) => Role(
    code: json["code"],
    guid: json["guid"],
    personne: json["personne"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "guid": guid,
    "personne": personne,
  };
}

class ObjetSous {
  ObjetSous({
    this.code = 1047,
    this.guid = '35c4cb51-0f41-4553-85bb-ee7b37d77011',
    this.libelle = 'Epargne Enfant',
  });

  int? code;
  String? guid;
  String? libelle;

  factory ObjetSous.fromMap(Map<String, dynamic> json) => ObjetSous(
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

// To parse this JSON data, do
//
//     final clientEnvoye = clientEnvoyeFromMap(jsonString);


ClientEnvoye clientEnvoyeFromMap(String str) => ClientEnvoye.fromMap(json.decode(str));

String clientEnvoyeToMap(ClientEnvoye data) => json.encode(data.toMap());

class ClientEnvoye {
  ClientEnvoye({
    required this.montantMise,
    required this.intituleCarte,
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
  String intituleCarte;
  String cycleCarte;
  ObjetSousE objetSous;
  ClientE client;
  String cInterneProduit;
  int produitId;
  int deviseId;
  int agenceId;
  String statut;

  factory ClientEnvoye.fromMap(Map<String, dynamic> json) => ClientEnvoye(
    montantMise: json["montantMise"],
    intituleCarte: json["intituleCarte"],
    cycleCarte: json["cycleCarte"],
    objetSous: ObjetSousE.fromMap(json["objetSous"]),
    client: ClientE.fromMap(json["client"]),
    cInterneProduit: json["cInterneProduit"],
    produitId: json["produitId"],
    deviseId: json["deviseId"],
    agenceId: json["agenceId"],
    statut: json["statut"],
  );

  Map<String, dynamic> toMap() => {
    "montantMise": montantMise,
    "intituleCarte": intituleCarte,
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

class ClientE {
  ClientE({
    required this.personne,
    this.gestionnaireId,
    this.typeClientId,
  });

  PersonneE personne;
  int? gestionnaireId;
  int? typeClientId;

  factory ClientE.fromMap(Map<String, dynamic> json) => ClientE(
    personne: PersonneE.fromMap(json["personne"]),
    gestionnaireId: json["gestionnaireId"],
    typeClientId: json["typeClientId"],
  );

  Map<String, dynamic> toMap() => {
    "personne": personne.toMap(),
    "gestionnaireId": gestionnaireId,
    "typeClientId": typeClientId,
  };
}

class PersonneE {
  PersonneE({
    required this.adresse,
    required this.resident,
    required this.dateNaissance,
    required this.paysResidence,
    required this.nationalite,
    this.civilite,
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.etatMatrimoniale,
  });

  AdresseE adresse;
  bool resident;
  DateTime dateNaissance;
  String paysResidence;
  String nationalite;
  String? civilite;
  String nom;
  String prenom;
  String sexe;
  String etatMatrimoniale;

  factory PersonneE.fromMap(Map<String, dynamic> json) => PersonneE(
    adresse: AdresseE.fromMap(json["adresse"]),
    resident: json["resident"],
    dateNaissance: DateTime.parse(json["dateNaissance"]),
    paysResidence: json["paysResidence"],
    nationalite: json["nationalite"],
    civilite: json["civilite"],
    nom: json["nom"],
    prenom: json["prenom"],
    sexe: json["sexe"],
    etatMatrimoniale: json["etatMatrimoniale"],
  );

  Map<String, dynamic> toMap() => {
    "adresse": adresse.toMap(),
    "resident": resident,
    "dateNaissance": "${dateNaissance.year.toString().padLeft(4, '0')}-${dateNaissance.month.toString().padLeft(2, '0')}-${dateNaissance.day.toString().padLeft(2, '0')}",
    "paysResidence": paysResidence,
    "nationalite": nationalite,
    "civilite": civilite,
    "nom": nom,
    "prenom": prenom,
    "sexe": sexe,
    "etatMatrimoniale": etatMatrimoniale,
  };
}

class AdresseE {
  AdresseE({
    this.type,
    required this.adresse,
    required this.paysId,
    required this.codePostal,
    required this.quartier,
    required this.villeId,
    required this.telephone,
    required this.email,
  });

  String? type;
  String adresse;
  int paysId;
  String codePostal;
  String quartier;
  int villeId;
  String telephone;
  String email;

  factory AdresseE.fromMap(Map<String, dynamic> json) => AdresseE(
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

class ObjetSousE {
  ObjetSousE({
    required this.code,
    required this.guid,
    required this.libelle,
  });

  int code;
  String guid;
  String libelle;

  factory ObjetSousE.fromMap(Map<String, dynamic> json) => ObjetSousE(
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
