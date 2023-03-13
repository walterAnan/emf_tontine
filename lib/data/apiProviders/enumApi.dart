import 'dart:developer';
import 'dart:async';
import 'dart:convert';

import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/data/models/civilite.dart';
import 'package:emf_tontine/data/models/objet.dart';
import 'package:emf_tontine/data/models/pays.dart';
// import 'package:emf_tontine/data/models/ville.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetDataProvider with ChangeNotifier {
  final  _prefs = SharedPreferences.getInstance();
  List <Civilite>? civilites;
  late List <dynamic> villes;
  late List <dynamic> professions;
  late List <dynamic> forme_juridique;
  List etaMatri = [];
  List _typePiece = [];
  List <dynamic> _cycle = [];
  List <Pays>?_list_pays ;
  List <Objet>?_list_objet ;
  bool isLoading = false;
  String lien_civilite = '$lienDev''referentiels/civilites';
  String lien_cycle = '$lienDev''referentiels/cycle-souscription';
  String lien_forme_juridique = '$lienDev''referentiels/forme-juridiques';
  String lien_pays = '$lienDev''pays';
  String lien_ville = '$lienDev''villes';
  String lien_profession = '$lienDev''referentiels/secteur-activites';
  String lien_objet = '$lienDev''objets';
  String lien_type_adesse = '$lienDev''type-pieces';




  Future<List<Civilite>?> getCivilite(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    try {
      final response = await http
          .get(Uri.parse(
          lien_civilite),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        civilites = civiliteFromMap(response.body);

        print(' civiliteeeeeee! $civilites');
        return civilites;
      }else if(response.statusCode == 401){
        refreshToken(context);
        return getCivilite(context);
      } else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return civilites;
  }

  Future<dynamic> getCycle(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    try {
      final response = await http
          .get(Uri.parse(
          lien_cycle),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        print('je suis dans le ville ');

        _cycle = jsonDecode(response.body);

        print('ville! $_cycle');
        return _cycle;
      }else if(response.statusCode == 401){
        refreshToken(context);
        return getCycle(context);
      } else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return villes;
  }


  Future<dynamic> getVille(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    try {
      final response = await http
          .get(Uri.parse(
          lien_ville),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        print('je suis dans le ville ');
        // villes = villeFromMap(response.body);
        villes = jsonDecode(response.body);

        print('ville! $villes');
        return villes;
      } else if(response.statusCode == 401){
        refreshToken(context);
        return getVille(context);
      }else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return villes;
  }


  Future<dynamic> getFormeJuridique(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    try {
      final response = await http
          .get(Uri.parse(
          lien_forme_juridique),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        print('je suis dans la forme juridique ');
        // villes = villeFromMap(response.body);
        forme_juridique = jsonDecode(response.body);

        return forme_juridique;
      } else if(response.statusCode == 401){
        refreshToken(context);
        return getFormeJuridique(context);
      }else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return forme_juridique;
  }


  Future<dynamic> getprofession(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    try {
      final response = await http
          .get(Uri.parse(
          lien_profession),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        print('je suis dans la profession ');
        // villes = villeFromMap(response.body);
        professions = jsonDecode(response.body);

        print('profession! $professions');
        return professions;
      } else if(response.statusCode == 401){
        refreshToken(context);
        return getprofession(context);
      }else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return professions;
  }

  Future<List<Pays>?> getPays(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    try {
      final response = await http
          .get(Uri.parse(
          lien_pays),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'});
      print('je suis toujours dans le pays');
      if (response.statusCode == 200) {
       var reponse = paysFromMap(response.body);
       _list_pays = reponse;
        return _list_pays;
      }else if(response.statusCode == 401){
        refreshToken(context);
        return getPays(context);
      } else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return _list_pays;
  }


  Future<List<Objet>?> getObjet(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    try {
      final response = await http
          .get(Uri.parse(
          lien_objet),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'});
      print('je objet');
      if (response.statusCode == 200) {
        var reponse = objetFromMap(response.body);
        _list_objet = reponse;
        return _list_objet;
      } else if(response.statusCode == 401){
        refreshToken(context);
        return getObjet(context);
      } else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return _list_objet;
  }

  Future<List> getEtatMatri(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    try {
      final response = await http
          .get(Uri.parse(
          "https://api-dev.ventis.group/emftontine/api/v1/referentiels/etat-matrimonials"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'});

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        etaMatri = item;
        // notifyListeners();
      } else if(response.statusCode == 401){
        refreshToken(context);
        return getEtatMatri(context);
      } else {
        print("else");
      }
    } catch (e) {
      log(e.toString());
    }

    return etaMatri;
  }


  Future<List> getTypePiece(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    try {
      final response = await http
          .get(Uri.parse(
          lien_type_adesse),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'});

      if (response.statusCode == 200) {
        _typePiece = json.decode(response.body);
        print('mes pieces : $_typePiece');
       return _typePiece;
      } else if(response.statusCode == 401){
        refreshToken(context);
        return getTypePiece(context);
      } else {
        print("else");
      }
    } catch (e) {
      log(e.toString());
    }

    return _typePiece;
  }


}

