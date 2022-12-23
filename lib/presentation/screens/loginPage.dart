

import 'dart:async';
import 'dart:convert';

import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/presentation/screens/bottom.dart';
import 'package:emf_tontine/presentation/utils/constant.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:emf_tontine/presentation/widgets/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unique_device_id/flutter_unique_device_id.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var token = 'default';
  bool _isloading = false;
   ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  var lien = Dev_constante().dev;


  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  TextEditingController codeSecret = new TextEditingController();
  TextEditingController mdp = new TextEditingController();
   String lien_civilite = '$lienDev''referentiels/civilites';
  void authentif(String id_app, String code, String mdp) async {
    var queryResponse = await http.post(Uri.parse('https://dev-cashdelivery.ventis.group/api/apareil_auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ',
      },
      body: jsonEncode(<String, String>{
        'id_app': id_app,
        'tel': code,
        'code': mdp,
      }),
    ).catchError((onError){
      showErrorToast(this.context, 'Vérifiez votre Connexion Internet ');
    });

    if(queryResponse!=null && queryResponse.statusCode==200) {

      var queryResponseBody = json.decode(queryResponse.body);

      if (queryResponseBody['status'] == 'OK') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (
              context) => const Bottom()),
        );

      }
      else {

        // showDialog(context: context, builder: builder)

      }
    }else{
      SystemNavigator.pop();
    }



  }

  static final _formkey = GlobalKey<FormState>();
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery
        .of(context)
        .size
        .height;
    var wt = MediaQuery
        .of(context)
        .size
        .width;


    return Scaffold(

        body: Column(
          children: [
            Container(
              height: 70,
              color: const Color(0xff4a9e04),
            ),
        Container(
        height: 150,
      // color: Colors.green,
              child: SvgPicture.asset(
                'assets/images/logo-sfe.svg', height: 50,
                color: const Color(0xff4a9e04),),
            ),
        Text('EMF-TONTINE',
            style: GoogleFonts.acme(
            textStyle: const TextStyle(color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold)
            )),

            Text('Page de Connexion',
            style: GoogleFonts.handlee(
            textStyle: const TextStyle(color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold)
            )),

            const SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
               child: Container(
                 margin: const EdgeInsets.symmetric(horizontal: 20),
                 child: Form(
                   key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Code agent",
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: Colors.grey,
                          ),
                        ),

                        validator: (email) {
                          if (validationCode(email!)) return null;
                          else {
                            return 'Entrer une addresse mail valide';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Mot de passe",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                        obscureText: isChecked == true ? false : true,
                        validator: (password) {
                          if (validationMdp(password!)) return null;
                          else {
                            return 'Entrer un mot de passe valide';
                          }
                        },
                      ),
                      const SizedBox(height: 20,),

                      Row(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Checkbox(
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ),
                          const Text('mot de passe visible!', style: TextStyle(
                              fontSize: 18
                          ),)
                        ],
                      ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                        child: _isloading? const CircularProgressIndicator(color: Colors.white,): const Text('Connecter'),
                        onPressed: () async {
                            // fetchClientPhysique();
                          if(_formkey.currentState!.validate()){
                            setState(() {
                              _isloading = true;
                            });
                            var token = await authenticateUser('benjamin', '142946An');
                            var token1 = token.toString();

                            saveAccessToken(token1);
                            var personne = await fetchClientPhysique();
                            print('liste des personnes physiques .....');
                            print('liste des personnes physiques: $personne');
                            var token2 = await retriveAccessToken();

                            print('avant');
                            var token3 = token2['access_token'];
                            setState(() {
                              token = token3;
                            });
                            print('apres');
                            print('aprés le token retourne: $token3');
                            print('lien: $lien_civilite');
                            _isloading = false;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (

                                  context) => const Bottom()),
                            );
                          }


                          // if(!validationCode(codeSecret.text)){
                          //
                          // }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (
                          //       context) => const Bottom()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff4a9e04),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            textStyle:
                            const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 40),
                      const InkWell(
                        child: Text('mot de passe oublié ?', style: TextStyle(
                            color: Color(0xff4a9e04),
                            fontSize: 18
                        ),),
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
              ),
               ),
    ),
            )]));}





  Future<String>initPlatformState() async {
    String uniqueDeviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      uniqueDeviceId = await UniqueDeviceId.get;
    } on PlatformException {
      uniqueDeviceId = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    return uniqueDeviceId;
  }
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  bool validationMdp(String text){
    return text.length >= 6 ? true : false;
  }

   bool validationCode(String text){
     return text.length >= 8 ? true : false;
   }
}
