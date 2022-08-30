

// import 'dart:ui';
// import 'package:emf_tontine/screens/dashboard.dart';
// import 'package:emf_tontine/screens/registerClient.dart';
import 'dart:ui';

import 'package:emf_tontine/widgets/inputs/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bottom.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  static final _formkey = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {

    var ht = MediaQuery.of(context).size.height;
    var wt = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Colors.lightGreenAccent,
      body: SingleChildScrollView(
        child: Form(
              key: _formkey,
              child: Column(
                      children: [
                Container(
                height: 180,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill
                    )
                ),
              ),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Text ('EMF_TONTINE',
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold)
                              )),

                              Text ('Page de Connexion',
                                  style: GoogleFonts.handlee(
                                      textStyle: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold)
                                  )),
                              const SizedBox(height: 40),
                              const InputField(icon: Icons.person, hint: 'Code Agent',
                                  obscureText: false),

                              const SizedBox(height: 20),


                          InputField(icon: Icons.lock, hint: 'Mot de Passe',
                            obscureText: isChecked == true? false:true,),

                              const SizedBox(height: 20),

                              Row(
                                children: [
                                  Container(
                                    color:Colors.white,
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
                            const SizedBox(height: 0,),
                              ElevatedButton(
                                child: const Text('Connecter'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  Bottom()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.indigo,
                                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                                    textStyle:
                                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 40),
                              const InkWell(
                                child: Text('mot de passe oublié ?', style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18
                                ),),
                              ),
                              const SizedBox(height: 30,),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
      )

    );
  }
}
