import 'dart:convert';

import 'package:emf_tontine/presentation/widgets/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


final  _prefs = SharedPreferences.getInstance();
Uri KEYCLOAK_AUTH = Uri.parse("https://keycloakdev.ventis.group/realms/ventis/protocol/openid-connect/token") ;


Future<Object> authenticateUser(BuildContext context, String username, String password) async {
  print('je suis dans la fonction');
  var res = await http.post(KEYCLOAK_AUTH, headers: {
    "Content-Type": "application/x-www-form-urlencoded",
    'Accept': 'application/json',
    'Connection': 'keep-alive',
  }, body: {
    "username": username,
    "password": password,
    "client_id": "emftontine-tpe",
    "grant_type": "password"
  }).catchError((onError){
    showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
  print('je suis ici');
  if (res.statusCode == 200) {
    var response = json.decode(res.body);
    final SharedPreferences prefs = await _prefs;
    prefs.setString('ACCESS_TOKEN_KEY', response['access_token']);
    prefs.setString('REFRESH_TOKEN_KEY', response['refresh_token']);
    return res.statusCode;
  } else {

    return res.statusCode;
  }
}

Future<Object> refreshToken(BuildContext context) async {
  print('je suis dans la fonction');
  final SharedPreferences prefs = await _prefs;
  var refreshToken = prefs.getString('REFRESH_TOKEN_KEY');
  var res = await http.post(KEYCLOAK_AUTH, headers: {
    "Content-Type": "application/x-www-form-urlencoded",
    'Accept': 'application/json',
    'Connection': 'keep-alive',
  }, body: {
    "refresh_token": refreshToken,
    "client_id": "emftontine-tpe",
    "grant_type": "refresh_token"
  }).catchError((onError){
    showErrorToast(context, 'Vérifiez votre Connexion Internet ');
  });
  if (res.statusCode == 200) {
    var response = json.decode(res.body);
    prefs.setString('ACCESS_TOKEN_KEY', response['access_token']);
    prefs.setString('REFRESH_TOKEN_KEY', response['refresh_token']);
    return true;
  } else {
    debugPrint("An Error Occurred during loggin in. Status code: ${res.statusCode} , body: ${res.body.toString()}");
    return res.statusCode;
  }
}



