import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:emf_tontine/data/models/clientPhysique.dart';
import 'package:emf_tontine/data/models/souscription.dart';
import 'package:emf_tontine/presentation/utils/constant.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

var _pays = [];
var lienDev = Dev_constante().dev;
Future<List> fetchClientPhysique() async {
  String lienClients = '$lienDev''clients/retails';
  print('lien clients: $lienClients');

  var token2 = await retriveAccessToken();
  var token3 = token2['access_token'];
  final response = await http.get(Uri.parse(lienClients),
      headers: <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer $token3'});
  if (response.statusCode == 200) {
    var personnes = response.body;
    return (json.decode(personnes) as List).toList();
  } else {
    var code =  response.statusCode;
    print('le resultat de echec: $code');
    throw Exception('Failed to load personnes');
  }


}


Future<Personne> createPersonneP(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {

    return Personne.fromMap(jsonDecode(response.body));
  } else {
    throw Exception('Echec pour l\'enrollement d\'une personne.');
  }
}
Future<Object> postClientsPhysique(PersonnePersonne personnePersonne,SouscriptionM souscription) async {
  var donnee = json.encode(<String, dynamic>{
    "code": '989',
    "guid": '562',
    "cParrainage":'1' ,
    "cParrain":'1' ,
    "gestionnaireId":'1' ,
    "typeClientId": '1',
    "personne": personnePersonne.toMap(),
  });
  try {
    String lienClients = '$lienDev''clients/retails';
    print('lien clients: $lienClients');
    var token2 = await retriveAccessToken();
    var token3 = token2['access_token'];

    final response = await http.post(Uri.parse(lienClients),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer $token3'},
        body: json.encode(<String, dynamic>{
          "code": '989',
          "guid": '562',
          "cParrainage":'1' ,
          "cParrain":'1' ,
          "gestionnaireId":'1' ,
          "typeClientId": '1',
          "personne": personnePersonne.toMap(),
          "souscription": souscription.toMap(),
        }),);

    print('personnepersonne: ${personnePersonne.toMap()}');
    print('donnée: $donnee');

    if (response.statusCode == 201) {
      return Personne.fromMap(jsonDecode(response.body));
      // notifyListeners();
    } else {
      print("else");
      print(response.statusCode);
    }
  } catch (e) {
    print('error: ${(e.toString())}');
  }

  return personnePersonne;
}


Future<List> getEtatMatri() async {
  try {
    String lienClients = '$lienDev''clients/retails';
    print('lien clients: $lienClients');

    var token2 = await retriveAccessToken();
    var token3 = token2['access_token'];
    final response = await http
        .get(Uri.parse(
        "https://api-dev.ventis.group/emftontine/api/v1/pays"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token3'});
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      _pays = item;
      // notifyListeners();
    } else {
      print("else");
    }
  } catch (e) {
    log(e.toString());
  }

  return _pays;
}


Future<List> getPays() async {
  try {
    String lienPays = '$lienDev''pays';
    print('lien clients: $lienPays');
    var tokenP = await retriveAccessToken();
    var token3 = tokenP['access_token'];
    final response = await http
        .get(Uri.parse(
        "https://api-dev.ventis.group/emftontine/api/v1/pays"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token3'});
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      _pays = item;
      // notifyListeners();
    } else {
      print("else");
    }
  } catch (e) {
    log(e.toString());
  }

  return _pays;
}


Future<List<dynamic>> fetchClient() async{
  String lienClient = '$lienDev clients/corporates';
  final response = await http
      .get(Uri.parse(lienClient));
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List).toList();
  } else {

    throw Exception('Failed to load client');
  }

}


