import 'dart:developer';
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/data/models/civilite.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetDataProvider with ChangeNotifier {
  List <Civilite>? civilites;
  List etaMatri = [];
  List typeCotisation = [];
  List _list_pays = [];
  bool isLoading = false;
  String lien_civilite = '$lienDev''referentiels/civilites';

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

        civilites  = civiliteFromMap(response.body);

        print(' civiliteeeeeee! $civilites');
        return civilites;
      } else {
        print('statut de la reponse: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }

    return civilites ;
  }


  Future<List> getTypeCotisation() async {
    try {
      final response = await http
          .get(Uri.parse(
          "https://api-dev.ventis.group/emftontine/api/v1/referentiels/etat-matrimonials"));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        typeCotisation = item;
        // notifyListeners();
      } else {
        print("else");
      }
    } catch (e) {
      log(e.toString());
    }

    return typeCotisation;
  }


  Future<List> getPays() async {
    var dio = Dio();
    final response = await dio.get('https://api-dev.ventis.group/emftontine/api/v1/referentiels/civilites');
    _list_pays = response.data;
    return _list_pays;
  }
}



