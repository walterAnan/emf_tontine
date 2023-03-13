// @dart=2.9



import 'dart:async';
import 'dart:io';


import 'package:emf_tontine/presentation/screens/loginPage.dart';
import 'package:emf_tontine/presentation/screens/souscrire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:developer' as developer;

import 'package:geolocator/geolocator.dart';

class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = PostHttpOverrides();
  await Geolocator.requestPermission();
  FlavorConfig(
    name: "DEV",
    color: Colors.red,
    location: BannerLocation.bottomStart,
    variables: {
      "baseApiUrl": "https://keycloakdev.ventis.group/:8080",
      "baseKeycloakUrl": "https://keycloakdev.ventis.group/:8081",
    },
  );

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (dynamic error, dynamic stack) {
    developer.log("Something went wrong!", error: error, stackTrace: stack);
  });


}

class MyApp extends StatelessWidget {
   const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Navigation avec Flutter',
      theme: ThemeData(
        radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => const Color(0xff4a9e04))
      ),),
      routes: {
          '/souscrire': (context)=> const Souscrire(),
      },
      home: const LoginPage(),
    );
  }


}

