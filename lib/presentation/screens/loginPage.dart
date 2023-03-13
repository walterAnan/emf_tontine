
import 'dart:async';
import 'dart:convert';
import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/presentation/screens/bottom.dart';
import 'package:emf_tontine/presentation/utils/constant.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:emf_tontine/presentation/widgets/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:imei_plugin/imei_plugin.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_keycloak/flutter_keycloak.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  final FlutterKeycloak _flutterKeycloak = FlutterKeycloak(

  );

  var token = 'default';
  dynamic imei;
  bool _isloading = false;
  bool _passwordVisible = false;
   ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  var lien = Dev_constante().dev;
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";

  Future<void> initPlatformStates() async {
    var deviceData = <String, dynamic>{};

    try {

          deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);

      }
     on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }





  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
      ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }


  Future<void> initPlatformState() async {
    String platformImei;
    String idunique = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
      await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      imei = await ImeiPlugin.getImeiMulti();
      idunique = await ImeiPlugin.getId();
      print('le dernier package: $imei et $idunique');
    } on PlatformException {
      platformImei = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;
      uniqueId = idunique;
    });
  }




  @override
  void initState() {
    initPlatformState();
    initPlatformStates();
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

  TextEditingController codeSecret = TextEditingController();
  TextEditingController mdp = TextEditingController();
   String lien_civilite = '$lienDev''referentiels/civilites';
  // void authentif(String id_app, String code, String mdp) async {
  //   var queryResponse = await http.post(Uri.parse('https://dev-cashdelivery.ventis.group/api/apareil_auth'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer ',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'id_app': id_app,
  //       'tel': code,
  //       'code': mdp,
  //     }),
  //   ).catchError((onError){
  //     showErrorToast(context, 'Vérifiez votre Connexion Internet ');
  //   });
  //
  //   if(queryResponse!=null && queryResponse.statusCode==200) {
  //
  //     var queryResponseBody = json.decode(queryResponse.body);
  //
  //     if (queryResponseBody['status'] == 'OK') {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (
  //             context) => const Bottom()),
  //       );
  //
  //     }
  //     else {
  //
  //       // showDialog(context: context, builder: builder)
  //
  //     }
  //   }else{
  //     SystemNavigator.pop();
  //   }
  //
  //
  //
  // }

  static final _formkey = GlobalKey<FormState>();
  bool isChecked = false;



  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Column(
          children: [
            Container(
              height: 50,
              color: const Color(0xff4a9e04),
            ),
        const SizedBox(height: 15,),
        SizedBox(
        height: 40,
              child: Container(
                child: SvgPicture.asset(
                  'assets/images/logo-sfe.svg', height: 40,
                  color: const Color(0xff4a9e04),),
              ),
            ),

            const SizedBox(height: 5,),
        // Container(
        //   alignment:  Alignment.topRight,
        //   margin: EdgeInsets.only(right: 50),
        //   child: Text('EMF-TONTINE',
        //       style: GoogleFonts.acme(
        //           textStyle: const TextStyle(color: Colors.green,
        //               fontSize: 16,
        //               fontWeight: FontWeight.bold)
        //       )),
        // ),

        Column(
          children: [
            Center(child:
            Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Icon(Icons.person_outline_outlined, color: Colors.black.withOpacity(0.5), size: 68,))),
          ],
        ),

            const SizedBox(height: 5,),
            Text('Bienvenue sur emf-tontine',
            style: GoogleFonts.handlee(
            textStyle: const TextStyle(color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold)
            )),

            Text('Connectez-vous pour continuer',
                style: GoogleFonts.handlee(
                    textStyle: const TextStyle(color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)
                )),


            const SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
               child: Container(
                 margin: const EdgeInsets.symmetric(horizontal: 20),
                 child: Form(
                   key: _formkey,
                  child: Column(
                    children: [
                  Container(
                  padding: const EdgeInsets.fromLTRB(10,1,10,1),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5),
                       border: Border.all(color: const Color(0xff4a9e04))
                   ),
                        child: TextFormField(
                          controller: codeSecret,
                          style: const TextStyle(
                              color: Color(0xff4a9e04), fontWeight: FontWeight.w400,
                              fontSize: 18
                          ),
                          decoration: const InputDecoration(
                            labelText: "Code agent",
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                              color: Colors.black,
                            ),
                          ),

                          validator: (email) {
                            if (validationCode(email!)) return null;
                            else {
                              return 'Entrer une addresse mail valide';
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10,2,10,2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: const Color(0xff4a9e04))
                        ),
                        // child: TextFormField(
                        //   style: const TextStyle(
                        //     color: Colors.black, fontWeight: FontWeight.w500,
                        //     fontSize: 18
                        //   ),
                        //   decoration: const InputDecoration(
                        //     labelText: "Mot de passe",
                        //     border: InputBorder.none,
                        //     prefixIcon: Icon(
                        //       Icons.lock,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        //   obscureText: isChecked == true ? false : true,
                        //   validator: (password) {
                        //     if (validationMdp(password!)) return null;
                        //     else {
                        //       return 'Entrer un mot de passe valide';
                        //     }
                        //   },
                        // ),

                        child: TextFormField(
                          obscureText: !_passwordVisible,
                          controller: mdp,
                          style: const TextStyle(
                              color: Color(0xff4a9e04), fontWeight: FontWeight.w400,
                              fontSize: 18
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.lock, color: Colors.black,),
                            fillColor: Colors.white.withOpacity(0.5),
                            labelText: "Password",
                            suffixIcon: GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  _passwordVisible = true;
                                });
                              },
                              onLongPressUp: () {
                                setState(() {
                                  _passwordVisible = false;
                                });
                              },
                              child: Icon(
                                  _passwordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.black,),
                            ), floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Inserer le mot de passe";
                            }
                          },
                          onSaved: (value) {
                            // _setPassword(value);
                          },
                        ),

                      ),

                      const SizedBox(height: 40),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: const InkWell(
                          child: Text('Mot de passe oublié ?', style: TextStyle(
                              color: Color(0xff4a9e04),
                              fontSize: 18
                          ),),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      // Row(
                      //   children: [
                      //     Container(
                      //       color: Colors.white,
                      //       child: Checkbox(
                      //         value: isChecked,
                      //         onChanged: (bool? value) {
                      //           setState(() {
                      //             isChecked = value!;
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //     const Text('mot de passe visible!', style: TextStyle(
                      //         fontSize: 20,
                      //       fontWeight: FontWeight.w500
                      //     ),)
                      //   ],
                      // ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                        child: _isloading? const CircularProgressIndicator(color: Colors.white,): const Text('Connexion'),
                        onPressed: () async {
                          if(_formkey.currentState!.validate()){
                            setState(() {
                              _isloading = true;
                            });
                            String identifiant = codeSecret.text;
                            String mot = mdp.text;
                            print('identifiant $identifiant et le mot de pas $mot');
                            var status = await authenticateUser(context,identifiant, mot,);

                            _isloading = false;

                            initPlatformStates();
                            print('les données récuperées: $_deviceData');
                            print(imei[0]);

                            if(status == 200){
                              // var statut = await authTpe(context, codeSecret.text, imei[0]);
                              // print('statut de api auth tpe: $statut');
                              // if(statut == 200){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Bottom()),
                                );
                              // }

                            }else{
                              showErrorToast(context, 'Code agent ou mot de passe incorrect');
                            }


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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),

                      const SizedBox(height: 100,),

                    ],
                  ),
              ),
               ),
    ),
            )]));}





  // Future<String>initPlatformState() async {
  //   String uniqueDeviceId;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     uniqueDeviceId = await UniqueDeviceId.get;
  //     print('je suis l\'identifiant unique: $uniqueDeviceId');
  //   } on PlatformException {
  //     uniqueDeviceId = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //
  //   return uniqueDeviceId;
  // }


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
