
import 'dart:io';

import 'package:emf_tontine/presentation/screens/loginPage.dart';
import 'package:emf_tontine/presentation/screens/souscrire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

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
  FlavorConfig(
    name: "DEV",
    color: Colors.red,
    location: BannerLocation.bottomStart,
    variables: {
      "baseApiUrl": "https://keycloakdev.ventis.group/:8080",
      "baseKeycloakUrl": "https://keycloakdev.ventis.group/:8081",
    },
  );

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Navigation avec Flutter',
      routes: {
          '/souscrire': (context)=> const Souscrire(),
      },
      home: const LoginPage(),
    );
  }


}

