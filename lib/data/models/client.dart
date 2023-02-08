import 'dart:convert';

import 'package:emf_tontine/data/models/client_particulier.dart';

// import 'package:emf_tontine/data/models/client_particulier.dart';




class Client{
  Client({
    this.montantMise,
    required this.intituleCarte,
    required this.cycleCarte,
    required this.objetSous,
    required this.client,
    required this.cInterneProduit,
    required this.produitId,
    required this.deviseId,
    required this.agenceId,
});
String ? montantMise;
String intituleCarte;
String cycleCarte;
ObjetSous objetSous;
Client client;
String cInterneProduit;
int produitId;
int deviseId;
int agenceId;

      }