import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/data/models/client_particulier.dart';
import 'package:emf_tontine/presentation/screens/clients.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emf_tontine/globals.dart' as global;
class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  late ClientE _client;
  @override
  Widget build(BuildContext context) {
    final Map client = ModalRoute.of(context)?.settings.arguments as Map;
    print('les données renvoyées au fichier souscrire: $client');
    print(client['personne']['photo']);
    AdresseE adres = AdresseE(adresse: "Libreville IAI", paysId: 27, codePostal: '2263', quartier: 'IAI', villeId: 31, telephone: client['personne']['adresse']['telephone'], email: client['personne']['adresse']['email']);

    PersonneE _personne = PersonneE(adresse: adres, resident: client['personne']['resident'], dateNaissance: DateTime.parse(client['personne']['dateNaissance']), paysResidence: client['personne']['paysResidence'], nationalite: client['personne']['nationalite'], civilite: client['personne']['civilite'], nom: client['personne']['nom'],  prenom: client['personne']['prenom'], sexe: client['personne']['sexe'], photo: client['personne']['photo'], etatMatrimoniale: 'CELIBATAIRE');
    ClientE _clt = ClientE(personne: _personne, gestionnaireId: 274,
      typeClientId: 1041,);

    _client = _clt;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),

              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xff4a9e04),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/otp.png',
                  // color: Colors.green,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Entrer l'otp",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5, top:20, bottom: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: true),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Appel à l'api de verification de l'opt.

                          _dialogBuilder(context);
                        },
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(const Color(0xff4a9e04)),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Verifier',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded  (
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Otp non reçu ?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TextButton(
                        onPressed: () {
                          // appel à l'api de generation de code otp
                        },
                        child: const Text(
                          "Renvoyer un autre Otp",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4a9e04),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last}) {
    return SizedBox(
      height: 50,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          obscureText: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Color(0xff4a9e04)),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }


  void popup(BuildContext context, int i){
    print('le statut reçu $i');
    if(i == 201){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        borderSide: const BorderSide(color: Color(0xff4a9e04), width: 2),
        buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
        headerAnimationLoop: false,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Succès',
        desc: 'Soucription éffectuée avec succès!',
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Clients()));
          debugPrint('OnClcik');
        },
      ).show();
    }else{
      if(i==302)
      {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Error',
          desc:'Oops ce client existe déjà',
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red,
        ).show();
      }else{
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Error',
          desc:'Oops un problème est survenu dans la souscription de ce client',
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red,
        ).show();
      }

    }
    global.status = 0;
  }


  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Validation', style: GoogleFonts.adamina(),),
          content: Text('Voulez-vous vraiment souscrire cette personne?', style: GoogleFonts.adamina(),),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Valider', style: TextStyle(color: Color(0xff4a9e04)),),
              onPressed: () async {
                print('le client: $_client');
                // ObjetSous _objetSous = ObjetSous(libelle: _selectionObjet.libelle,
                //     code: 1047,
                //     guid: "35c4cb51-0f41-4553-85bb-ee7b37d77011");
                // print('mon double ${int.parse('40')}');
                // int montant = int.parse(mise.text);
                // String cycle = _selectionProduit['cycle'];
                // postClientParticulier(_objetSous,_client, montant, cycle).then((value) =>
                //     popup(context,value! ));



                // postClientParticulier(_objetSous,_client, montant, cycle).then((value) =>
                //     popup(context,value! ));
              },
            ),
          ],
        );
      },
    );
  }

  }

