import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:emf_tontine/data/models/client_particulier.dart';
import 'package:emf_tontine/presentation/utils/constant.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:http/http.dart' as http;
import 'package:emf_tontine/globals.dart' as global;

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

var _pays = [];

late List<dynamic> _personnesPhysiques;
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


dynamic myDateSerializer(dynamic object) {
  if (object is DateTime) {
    return object.toString();

  }
  return object;
}


Future<int?> postClientParticulier(ObjetSous objetSous,ClientE client, int montantMise, String cycle) async {
  Map<String, dynamic> myData = {
    "montantMise": montantMise,
    "intituleCarte": "carte",
    "cycleCarte": cycle == null? "UN_MOIS":cycle,
    "objetSous": objetSous.toMap(),
    "client": client.toMap(),
    "cInterneProduit": '01',
    "produitId": 483,
    "deviseId": 22,
    "agenceId": 71,
    "statut": "ACTIF"
  };

  print('afficher les données: $myData');
  print('afficher les données1: $myData');
  print('afficher les données2: $myData');

  var donnee = json.encode(myData, toEncodable: myDateSerializer);
  String lienClients = '$lienDev''clients/retail/souscription/create';
  var token2 = await retriveAccessToken();
  var token3 = token2['access_token'];

  print('envoyées: ${jsonEncode(myData)}');
  try {
    print('nouveau: $myData');
    final response = await http.post(Uri.parse(lienClients),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Authorization': 'Bearer $token3'},
      body: jsonEncode(myData));
    print('le statut du retour avant ${response.statusCode}');
    if(response.body.isNotEmpty){
      print('le statut du retour avant0 ${response.statusCode}');
      if (response.statusCode == 201) {
      global.status = response.statusCode;
      print('le statut du retour avant1 ${response.statusCode}');
      return response.statusCode;
    } else {
      return response.statusCode;
    }
    }
  } catch (e) {
    print('error: ${(e.toString())}');
  }
  return null;

}



Future<int?> postClientMoral(ObjetSous objetSous,ClientE client, int montantMise) async {
  Map<String, dynamic> myData = {
    "montantMise": montantMise,
    "intituleCarte": "carte",
    "cycleCarte": "UN_MOIS",
    "objetSous": objetSous.toMap(),
    "client": client.toMap(),
    "cInterneProduit": '01',
    "produitId": 483,
    "deviseId": 22,
    "agenceId": 71,
    "statut": "ACTIF"
  };

  String lienClientMoral = '$lienDev''clients/corporate/souscription/create';
  var token2 = await retriveAccessToken();
  var token3 = token2['access_token'];

  print('envoyées: ${jsonEncode(myData)}');
  try {
    print('nouveau: $myData');
    final response = await http.post(Uri.parse(lienClientMoral),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer $token3'},
        body: jsonEncode(myData));
    print('le statut du retour avant ${response.statusCode}');
    if(response.body.isNotEmpty){
      print('le statut du retour avant0 ${response.statusCode}');
      if (response.statusCode == 201) {
        global.status = response.statusCode;
        print('le statut du retour avant1 ${response.statusCode}');
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    }
  } catch (e) {
    print('error: ${(e.toString())}');
  }
  return null;

}


Future<List> getClientParticulier() async {
  String lienClients = '$lienDev''clients/retails';
  print('lien clients: $lienClients');

  var token2 = await retriveAccessToken();
  var token3 = token2['access_token'];
  final response = await http.get(Uri.parse(lienClients),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token3'});
  if (response.statusCode == 200) {
    print('je suis en train de charger les personnes ${response.body}');
    _personnesPhysiques = jsonDecode(response.body);
    return _personnesPhysiques;
  } else {
    var code =  response.statusCode;
    print('le resultat de echec: $code');
    throw Exception('Failed to load personnes');
  }


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


Future<dynamic> authTpe(String username, String imei) async{
  String lien_tpe = '$lienDev devices/auth';
  var token2 = await retriveAccessToken();
  var token3 = token2['access_token'];
  Map<String, String> input ={
    "userName": username,
    "IMEI": imei
  };
  final response = await http
      .post(Uri.parse(lien_tpe),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token3'},
          body: jsonEncode(input));
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {

    throw Exception('Failed to load client');
  }

}


Future<List> getTypeAdresse() async {
  try {
    String lienPays = '$lienDev''referentiels/type-adresse';
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


Future<List> getProdriut() async {
  String lienProduit = '$lienDev''produits';
  print('lien clients: $lienProduit');

  var token2 = await retriveAccessToken();
  var token3 = token2['access_token'];
  final response = await http.get(Uri.parse(lienProduit),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token3'});
  if (response.statusCode == 200) {
    print('produits chargés ${response.body}');
    List l = jsonDecode(response.body) as List;

    // _produits= produitFromMap(response.body) as List;
    return l;
  } else {
    var code =  response.statusCode;
    print('le resultat de echec: $code');
    throw Exception('Failed to load products');
  }


}




