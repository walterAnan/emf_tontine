import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



final  _prefs = SharedPreferences.getInstance();
Uri KEYCLOAK_AUTH = Uri.parse("https://keycloakdev.ventis.group/realms/ventis/protocol/openid-connect/token") ;

Future<Object> authenticateUser(String username, String password) async {
  print('je suis dans la fonction');
  var res = await http.post(KEYCLOAK_AUTH, headers: {
    "Content-Type": "application/x-www-form-urlencoded",
    'Connection': 'keep-alive',
  }, body: {
    "username": username,
    "password": password,
    "client_id": "emftontine-tpe",
    "grant_type": "password"
  });

  if (res.statusCode == 200) {
    var token = res.body;
    return token;

  } else {
    debugPrint(
        "An Error Occurred during loggin in. Status code: ${res.statusCode} , body: ${res.body.toString()}");
    return res.statusCode;
  }
}


void saveAccessToken(String accessToken)async {
  final SharedPreferences prefs = await _prefs;
  print('le token dans le fonction save: $accessToken');
  prefs.setString('ACCESS_TOKEN_KEY', accessToken);
}

retriveAccessToken() async {
  final SharedPreferences prefs = await _prefs;
  String? tokenJson = prefs.getString('ACCESS_TOKEN_KEY');
  print('le token dans la fonction retrive $tokenJson');
  if (tokenJson == null) {
    return null;
  } else{
    Map valueMap = json.decode(tokenJson);
    return valueMap;
  }
}

