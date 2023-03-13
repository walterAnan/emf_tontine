import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';
import 'package:emf_tontine/presentation/screens/loginPage.dart';
import 'package:emf_tontine/presentation/widgets/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:emf_tontine/data/models/client_particulier.dart';
import 'package:emf_tontine/data/models/client_morale_sous.dart';
import 'package:emf_tontine/presentation/utils/constant.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:emf_tontine/globals.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
final  _prefs = SharedPreferences.getInstance();
var _pays = [];

late List<dynamic> _personnesPhysiques;
late List<dynamic> _personnesMorales;
late Map<String, dynamic> _carnet;
dynamic retourImage;
var lienDev = Dev_constante().dev;


Future<List> fetchClientPhysique(BuildContext context) async {
  String lienClients = '$lienDev''clients/retails';
  print('lien clients: $lienClients');

  final SharedPreferences prefs = await _prefs;
  var accessToken = prefs.getString('ACCESS_TOKEN_KEY');

  final response = await http.get(Uri.parse(lienClients),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      }
  ).catchError((onError){
    showErrorToast(context, 'Vérifiez votre Connexion Internet ');
  });
  if (response.statusCode == 200) {
    var personnes = response.body;
    return (json.decode(personnes) as List).toList();
  }else if(response.statusCode == 401){
    refreshToken(context);
    return fetchClientPhysique(context);
  } else {
    var code =  response.statusCode;
    print('le resultat de echec: $code');
    throw Exception('Failed to load personnes');
  }


}



Future<Personne> createPersonneP(BuildContext context, String title) async {
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
  } else if(response.statusCode == 401){
    refreshToken(context);
    return createPersonneP(context, title);
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


Future<int?> postClientParticulier(BuildContext context, ObjetSous objetSous,ClientE client, int montantMise, String cycle) async {
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

  String lienClients = '$lienDev''clients/retail/souscription/create';
  final SharedPreferences prefs = await _prefs;
  var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
  try {
    final response = await http.post(Uri.parse(lienClients),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Authorization': 'Bearer $accessToken'},
      body: jsonEncode(myData)).catchError((onError){
      showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
    if(response.body.isNotEmpty){
      if (response.statusCode == 201) {
      global.status = response.statusCode;
      return response.statusCode;
    } else if(response.statusCode == 401){
        refreshToken(context);
        return postClientParticulier(context, objetSous, client, montantMise, cycle);
      } else {
      return response.statusCode;
    }
    }
  } catch (e) {
    print('error: ${(e.toString())}');
  }
  return null;

}



Future<int?> postClientMoral(BuildContext context,ClientM client, Map sousc, dynamic objetSous) async {
  print('client sousc dans le api: ${objetSous['objetSous'].toMap()}');
  Map<String, dynamic> myData = {
    "montantMise": objetSous['montantMise'],
    "intituleCarte": 'Carte Intiluté',
    "cycleCarte": objetSous['cycleCarte'],
    "objetSous": objetSous['objetSous'].toMap(),
     "client": client.toMap(),
    "cInterneProduit": objetSous['cInterneProduit'],
    "produitId": objetSous['produitId'],
    "deviseId": objetSous['deviseId'],
    "agenceId": 71,
    "statut": "ACTIF"
  };

  print('mes données morales: $myData');
  String lienClientMoral = '$lienDev''clients/corporate/souscription/create';
  final SharedPreferences prefs = await _prefs;
  var accessToken = prefs.getString('ACCESS_TOKEN_KEY');

  print('envoyées: ${jsonEncode(myData)}');
  try {
    print('nouveau: $myData');
    final response = await http.post(Uri.parse(lienClientMoral),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer $accessToken'},
        body: jsonEncode(myData)).catchError((onError){
      showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
    if(response.body.isNotEmpty){
      if (response.statusCode == 201) {
        global.status = response.statusCode;
        return response.statusCode;
      } else if(response.statusCode == 401){
        refreshToken(context);
        return postClientMoral(context, client, sousc, objetSous);
      } else if(response.statusCode == 400){
        SystemNavigator.pop();
      }else{
        return response.statusCode;
      }
    }else{
      print('je suis le body: ${response.body}');
    }
  } catch (e) {
    print('error: ${(e.toString())}');
  }
  return null;

}


Future<List> getClientParticulier(BuildContext context) async {
  String lienClients = '$lienDev''clients/retails';
  print('lien clients: $lienClients');

  final SharedPreferences prefs = await _prefs;
  var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
  final response = await http.get(Uri.parse(lienClients),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'}).catchError((onError){
    showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
  if (response.statusCode == 200) {
    _personnesPhysiques = jsonDecode(response.body);
    return _personnesPhysiques;
  } else if(response.statusCode == 401){
    refreshToken(context);
    return getClientParticulier(context);
  } else {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
    var code =  response.statusCode;
    print('le resultat de echec: $code');
    throw Exception('Failed to load personnes');
  }


}


Future<Map<String, dynamic>> getCarnet(BuildContext context, String cycle) async {
  String lienCarnet = '$lienDev''articles/cycle/';
  final SharedPreferences prefs = await _prefs;
  var accessToken = prefs.getString('ACCESS_TOKEN_KEY');

  final response = await http.get(Uri.parse(lienCarnet+cycle.toLowerCase()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept':'application/json',
        'Authorization': 'Bearer $accessToken'}).catchError((onError){
    showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
  if (response.statusCode == 200) {
    print('je suis en train de charger le carnet: ${response.body}');
    _carnet = jsonDecode(response.body);
    return _carnet;
  } else if(response.statusCode == 401){
    refreshToken(context);
    return getCarnet( context,  cycle);
  } else {
    var code =  response.statusCode;
    print('le resultat de echec: $code');
    throw Exception('Failed to load carnet');
  }


}

Future<List> getClientMoral(BuildContext context) async {
  String lienClientM = '$lienDev''clients/corporates';
  print('lien clients: $lienClientM');

  final SharedPreferences prefs = await _prefs;
  var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
  final response = await http.get(Uri.parse(lienClientM),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'}).catchError((onError){
    showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
  if (response.statusCode == 200) {
    print('je suis en train de charger les entreprises ${response.body}');
    _personnesMorales = jsonDecode(response.body);
    return _personnesMorales;
  }else if(response.statusCode == 401){
    refreshToken(context);
    return getClientMoral(context);
  } else {
    var code =  response.statusCode;
    print('le resultat de echec: $code');
    throw Exception('Failed to load personnes');
  }


}



Future<List> getEtatMatri(BuildContext context) async {
  try {
    String lienClients = '$lienDev''clients/retails';
    print('lien clients: $lienClients');

    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    final response = await http
        .get(Uri.parse(
        "https://api-dev.ventis.group/emftontine/api/v1/pays"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'}).catchError((onError){
      showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      _pays = item;
       // notifyListeners();
    }
    else if(response.statusCode == 401){
      refreshToken(context);
      return getEtatMatri(context);
    }else {
      print("else");
    }
  } catch (e) {
    log(e.toString());
  }

  return _pays;
}


Future<List> getPays(BuildContext context) async {
  try {
    String lienPays = '$lienDev''pays';
    print('lien clients: $lienPays');
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    final response = await http
        .get(Uri.parse(
        "https://api-dev.ventis.group/emftontine/api/v1/pays"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'}).catchError((onError){
      showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      _pays = item;
      // notifyListeners();
    } else if(response.statusCode == 401){
      refreshToken(context);
      return getEtatMatri(context);
    }else {
      print("else");
    }
  } catch (e) {
    log(e.toString());
  }

  return _pays;
}

Future<List<dynamic>> fetchClient(BuildContext context) async{
  String lienClient = '$lienDev clients/corporates';
  final response = await http
      .get(Uri.parse(lienClient));
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List).toList();
  } else if(response.statusCode == 401){
    refreshToken(context);
    return fetchClient(context);
  } else {

    throw Exception('Failed to load client');
  }

}


Future<dynamic> authTpe(BuildContext context, String username, String imei) async{
  String lien_tpe = '$lienDev''devices/auth';

  print('lien: $lien_tpe');
  final SharedPreferences prefs = await _prefs;
  var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
  Map<String, dynamic> input ={
    "userName": username,
    "IMEI": imei,
    "serialNumber": "VB02213U21973",
    "isSerialNumberAuth": false
};
  final response = await http
      .post(Uri.parse(lien_tpe),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'},
          body: jsonEncode(input)).catchError((onError){
    showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
  if (response.statusCode == 200) {
    return response.statusCode;
  }  else if(response.statusCode == 401){
    refreshToken(context);
    return authTpe( context,  username, imei);
  }else {
     print(response.body);
     print(response.statusCode);
    throw Exception('Failed to load client');
  }

}





Future<List> getTypeAdresse(BuildContext context) async {
  try {
    String lienPays = '$lienDev''referentiels/type-adresse';
    print('lien clients: $lienPays');

    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    final response = await http
        .get(Uri.parse(
        "https://api-dev.ventis.group/emftontine/api/v1/pays"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'}).catchError((onError){
      showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      _pays = item;
      // notifyListeners();
    } else if(response.statusCode == 401){
      refreshToken(context);
      return getTypeAdresse(context);
    } else {
      print("else");
    }
  } catch (e) {
    log(e.toString());
  }

  return _pays;
}





Future<String> submitSubscription(BuildContext context, File file)async{
  ///MultiPart request
  final SharedPreferences prefs = await _prefs;
  var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
  var request = http.MultipartRequest(
    'POST', Uri.parse('$lienDev''piecejointe'),

  );

  Map<String,String> headers={
    "Authorization":"Bearer $accessToken",
    "Content-type": "multipart/form-data"
  };
  request.files.add(
    http.MultipartFile(
      'file',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      contentType: MediaType('image','jpeg'),
    ),
  );
  request.headers.addAll(headers);
  print("request: "+request.toString());
  var res = await request.send().catchError((onError){
    showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
  dynamic retour;
 if(res.statusCode == 202){
   res.stream.transform(utf8.decoder).listen((value) {
     if(value!=null){
       retourImage = value;
       print('retour: $retourImage');
       print(retourImage.runtimeType);
     }
   });
   print(retour.toString());
   print("This is response:"+res.toString());
 }else if(res.statusCode == 401){
   refreshToken(context);
   return submitSubscription(context, file);
 }

  return json.decode(retour);
}



Future<List> getProdriut(BuildContext context) async {
  String lienProduit = '$lienDev''produits';
  print('lien clients: $lienProduit');

  final SharedPreferences prefs = await _prefs;
  var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
  final response = await http.get(Uri.parse(lienProduit),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'}).catchError((onError){
    showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
  if (response.statusCode == 200) {
    print('produits chargés ${response.body}');
    List l = jsonDecode(response.body) as List;

    // _produits= produitFromMap(response.body) as List;
    return l;
  } else if(response.statusCode == 401){
    refreshToken(context);
    return getProdriut(context);
  } else {
    var code =  response.statusCode;
    print('le resultat de echec: $code');
    throw Exception('Failed to load products');
  }


}


Future<List> getProdriutSousctionClient(BuildContext context, String client) async {
  String lienProduit = '$lienDev''souscriptions/client/';


  final SharedPreferences prefs = await _prefs;
  var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
  final response = await http.get(Uri.parse(lienProduit+client),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'}).catchError((onError){
    showErrorToast(context, 'Vérifiez votre Connexion Internet ');});
  if (response.statusCode == 200) {
    print('produits chargés ${response.body}');
    List l = jsonDecode(response.body) as List;

    // _produits= produitFromMap(response.body) as List;
    return l;
  } else if(response.statusCode == 401){
    refreshToken(context);
    return getProdriutSousctionClient(context, client);
  } else if(response.statusCode == 400) {
    refreshToken(context);
    return getProdriutSousctionClient(context, client);
  }
  var code =  response.statusCode;
  print('le resultat de echec: $code');
  throw Exception('Failed to load products');

}

