import 'dart:developer';
import 'dart:async';
import 'dart:convert';

import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/data/models/civilite.dart';
import 'package:emf_tontine/data/models/objet.dart';
import 'package:emf_tontine/data/models/pays.dart';
import 'package:emf_tontine/data/models/ville.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetDataProvider with ChangeNotifier {
  List <Civilite>? civilites;
  late List <dynamic> villes;
  late List <dynamic> professions;
  List etaMatri = [];
  List _typePiece = [];
  List <Pays>?_list_pays ;
  List <Objet>?_list_objet ;
  bool isLoading = false;
  String lien_civilite = '$lienDev''referentiels/civilites';
  String lien_pays = '$lienDev''pays';
  String lien_ville = '$lienDev''villes';
  String lien_profession = '$lienDev''referentiels/secteur-activites';
  String lien_objet = '$lienDev''objets';
  String lien_type_adesse = '$lienDev''type-pieces';




  Future<List<Civilite>?> getCivilite() async {
    var token2 = await retriveAccessToken();
    var token3 = token2['access_token'];
    try {
      final response = await http
          .get(Uri.parse(
          lien_civilite),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token3'});
      if (response.statusCode == 200) {
        civilites = civiliteFromMap(response.body);

        print(' civiliteeeeeee! $civilites');
        return civilites;
      } else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return civilites;
  }


  Future<dynamic> getVille() async {
    var token2 = await retriveAccessToken();
    print('je suis dans le ville111 ');
    var token3 = token2['access_token'];
    try {
      final response = await http
          .get(Uri.parse(
          lien_ville),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token3'});
      if (response.statusCode == 200) {
        print('je suis dans le ville ');
        // villes = villeFromMap(response.body);
        villes = jsonDecode(response.body);

        print('ville! $villes');
        return villes;
      } else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return villes;
  }


  Future<dynamic> getprofession() async {
    var token2 = await retriveAccessToken();
    print('je suis dans la profession11');
    var token3 = token2['access_token'];
    try {
      final response = await http
          .get(Uri.parse(
          lien_profession),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token3'});
      if (response.statusCode == 200) {
        print('je suis dans la profession ');
        // villes = villeFromMap(response.body);
        professions = jsonDecode(response.body);

        print('profession! $professions');
        return professions;
      } else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return professions;
  }

  Future<List<Pays>?> getPays() async {
    var token2 = await retriveAccessToken();
    print('je suis dens le pays');
    var token3 = token2['access_token'];
    try {
      final response = await http
          .get(Uri.parse(
          lien_pays),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token3'});
      print('je suis toujours dans le pays');
      if (response.statusCode == 200) {
       var reponse = paysFromMap(response.body);
       _list_pays = reponse;
        return _list_pays;
      } else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return _list_pays;
  }


  Future<List<Objet>?> getObjet() async {
    var token2 = await retriveAccessToken();
    var token3 = token2['access_token'];
    try {
      final response = await http
          .get(Uri.parse(
          lien_objet),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token3'});
      print('je objet');
      if (response.statusCode == 200) {
        var reponse = objetFromMap(response.body);
        _list_objet = reponse;
        return _list_objet;
      } else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return _list_objet;
  }

  Future<List> getEtatMatri() async {
    var token2 = await retriveAccessToken();
    var token3 = token2['access_token'];
    try {
      final response = await http
          .get(Uri.parse(
          "https://api-dev.ventis.group/emftontine/api/v1/referentiels/etat-matrimonials"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token3'});

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        etaMatri = item;
        // notifyListeners();
      } else {
        print("else");
      }
    } catch (e) {
      log(e.toString());
    }

    return etaMatri;
  }


  Future<List> getTypePiece() async {
    var token2 = await retriveAccessToken();
    var token3 = token2['access_token'];
    try {
      final response = await http
          .get(Uri.parse(
          lien_type_adesse),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token3'});

      if (response.statusCode == 200) {
        _typePiece = json.decode(response.body);
        print('mes pieces : $_typePiece');
       return _typePiece;
      } else {
        print("else");
      }
    } catch (e) {
      log(e.toString());
    }

    return _typePiece;
  }


}

