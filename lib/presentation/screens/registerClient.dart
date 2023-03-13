
import 'dart:convert';
import 'dart:io';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:emf_tontine/data/models/civilite.dart';
import 'package:emf_tontine/data/models/client_particulier.dart';
import 'package:emf_tontine/presentation/screens/souscrire.dart';
import 'package:emf_tontine/data/apiProviders/enumApi.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Sexe {homme, femme}
enum Residence {OUI, NON}

class RegisterClient extends StatefulWidget {
   RegisterClient({Key? key}) : super(key: key);



  @override
  State<RegisterClient> createState() => _RegisterClientState();
  static final now = DateTime.now();

  final dropdownDatePicker = DropdownDatePicker(
    firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
    lastDate: ValidDate(year: now.year, month: now.month, day: now.day),
    textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
    dropdownColor: Colors.white,
    dateHint: DateHint(year: 'Année', month: 'Mois', day: 'Jour', ),
    ascending: false,
  );
}

class _RegisterClientState extends State<RegisterClient> {

  final _formkey = GlobalKey<FormState>();

  List<GlobalKey<FormState>> _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];

  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _nom = TextEditingController();
  final TextEditingController _prenom = TextEditingController();
  final TextEditingController _dateNaiss = TextEditingController();
  final TextEditingController _professionPreciser = TextEditingController();
  final TextEditingController _telephone = TextEditingController();
  final TextEditingController _adresseMail = TextEditingController();
  final TextEditingController _pieceIdentite = TextEditingController();
  final TextEditingController _numPieceIndentite = TextEditingController();
  final TextEditingController _lieuNaiss = TextEditingController();
  final TextEditingController _villeNaiss = TextEditingController();
  final TextEditingController _paysNaiss = TextEditingController();
  final TextEditingController _adresse = TextEditingController();
  final TextEditingController _paysResidence = TextEditingController();
  final TextEditingController _nationalite = TextEditingController();
  String initialCountry = 'GA';
  PhoneNumber number = PhoneNumber(isoCode: 'GA');

  List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];



  late String dropdown;
  dynamic dropdownValue;

  String? selectedValue;

  final  _prefs = SharedPreferences.getInstance();

  final List<dynamic> _list_pays = [];
  String imageRetourne = '' ;
  late final List<dynamic> _type_piece = [];
  final List<String> _etat_matrimonial = [];
  dynamic _selected_etat_matrimonial;
  dynamic _selected_pays ;
  dynamic _selected_pays_residence;
  final List<Civilite> _civilite =  [];
  final List<dynamic> _ville =  [];
  final List<dynamic> _profession =  [];
  dynamic selected_civilite;
  dynamic _selected_profession;
  dynamic selected_ville;
  dynamic _selected_piece;
  bool select= false;
  List<String> list = ['Pas de type de pièce'];




  var _index= 0;
  var hauteur;
  var largeur;
  var numero;
  bool isLoading = false;
  bool retour = false;
  bool isLoading1 = false;
  bool isLoading2 = false;
  List<String> sexe = ['Homme', 'Femme'];
  Sexe? _sexe = Sexe.homme;
  Residence? _estResident = Residence.OUI;
  ImagePicker picker = ImagePicker();
  late File _image = File('assets/images/profile_photo.png');

  late File imageFile;

  // XFile? image = await picker.pickImage(source: ImageSource.gallery);




  getDataCivilite() async {
    var list = await GetDataProvider().getCivilite(context);
      if(list != null){
        for(int i = 0; i< list.length; i++){
          _civilite.add(list[i]);
          print(list[i].libelle);
        }
        setState(() {
          isLoading = false;
        });

      }else{
        print('Le retour est nul');
      }

  }


  getDataVille() async {
    var list = await GetDataProvider().getVille(context);
    if(list != null){
      for(int i = 0; i< list.length; i++){
        _ville.add(list[i]);
        print(list[i]['nom']);

      }
      setState(() {
        isLoading = false;
      });

    }else{
      print('Le retour est nul');
    }

  }



  getDataProfession() async {
    var list = await GetDataProvider().getprofession(context);
    if(list != null){
      for(int i = 0; i< list.length; i++){
        _profession.add(list[i]);
        print(list[i]['libelle']);

      }
      setState(() {
        isLoading = false;
      });

    }else{
      print('Le retour est nul');
    }

  }

  getDataTypePiece() async {
    isLoading2 = true;
    var list = await GetDataProvider().getTypePiece(context);
    if(list != null){
      for(int i = 0; i< list.length; i++){
        print('les pieces');
        _type_piece.add(list[i].libelle);
        print('pieces après');
        print('liste des piece: $_type_piece');

      }
      setState(() {
        isLoading2 = false;
      });
    }else{
      print('Le retour est nul');
    }

  }

  getDataEtatMatri() async {
    var list = await GetDataProvider().getEtatMatri(context);
      if(list != null){
        for(int i = 0; i< list.length; i++){
          print(list[i]);
          _etat_matrimonial.add(list[i]['libelle']);
          print(list[i]['libelle']);
        }
        setState(() {
          isLoading1 = false;
        });
      }else{
        print('Le retour est nul');
      }

  }


  // onUploadImage() async {
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse("https://api-dev.ventis.group/emftontine/api/v1/piecejointe"),
  //   );
  //   Map<String, String> headers = {"Content-type": "multipart/form-data"};
  //   request.files.add(
  //     http.MultipartFile(
  //       'file',
  //       _image.readAsBytes().asStream(),
  //       _image.lengthSync(),
  //       filename: _image.path.split('/').last,
  //     ),
  //   );
  //   request.headers.addAll(headers);
  //   print("request: " + request.toString());
  //   var res = await request.send();
  //   http.Response response = await http.Response.fromStream(res);
  //   if(response.statusCode ==202){
  //     print(response.body);
  //   }else{
  //     print(response.statusCode);
  //     print(response.body);
  //
  //   }
  // }






  getDataPays() async {
    var list = await GetDataProvider().getPays(context);
    if(list != null){
      for(int i = 0; i< list.length; i++){
        print('pays ${list[i]}');
        _list_pays.add(list[i]);
      }
    }else{
      print('Le retour est nul');
    }


  }



  Future<int> submitSubscription(BuildContext context, File file)async{
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
    var res = await request.send();
    dynamic retour;
    if(res.statusCode == 202){
      res.stream.transform(utf8.decoder).listen((String value) {
        if(value!=null){
          print('valleur type : ${value.runtimeType}');
          var img =  json.decode(value);
          print(img.runtimeType);
          var img1 = img['guid'];
          imageRetourne = img1;
          retourImage = value;
          retour = true;
        }
      });
      print(retour.toString());
      print("This is response:"+res.toString());
    }
    else if(res.statusCode == 401){
      refreshToken(context);
      return submitSubscription(context, file);
    }

    return res.statusCode;
  }


  getDataPiece(BuildContext context) {
    print(submitSubscription(context, File(imageFile.path))) ;
    dynamic image = submitSubscription(context, File(imageFile.path));
    print('image de la valirable image: ${image.toString()}');
    if(image != null){
        retour = true;
    }else{
      print('Le retour est nul');
    }


  }
  bool changerImage = false;
  @override



  _getFrom(source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 180,
      maxHeight: 180,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path) ;
        changerImage = true;
      });
    }
  }


  @override
  void initState() {
    getDataCivilite();
    getDataProfession();
    getDataVille();
    getDataPays();
    getDataEtatMatri();
    getDataTypePiece();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    hauteur = MediaQuery
        .of(context)
        .size
        .height;
    largeur = MediaQuery
        .of(context)
        .size
        .width;

    var _selected ="";


    return Scaffold(
      backgroundColor: const Color(0xff4a9e04),
            body: (isLoading || isLoading1 || isLoading2) ? const Center(child: CircularProgressIndicator()):
            Theme(
                // color: Colors.grey,
                  data: ThemeData(
                      primaryColor: const Color(0xff4a9e04),
                      colorScheme: const ColorScheme.light(
                          primary: Color(0xff4a9e04)
                      )
                  ),
                  child: Form(
                    child: Column(
                      children: [
                             Container(
                               margin: const EdgeInsets.only(top: 50),
                               child: Text(
                                'Enrolement d\'un client', style: GoogleFonts.adamina(
                                 fontSize: 20, color: Colors.white
                               ),
                            ),
                             ),

                        Expanded(
                          child: Container(
                            width: largeur,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                            ),
                            child: Stepper(
                              type: StepperType.horizontal,
                              elevation: 2,
                            currentStep: _index,
                            onStepCancel: () {
                              if (_index > 0) {
                                setState(() {
                                  _index -= 1;
                                });
                              }
                            },
                            onStepContinue: () async {
                          if (formKeys[_index].currentState!.validate()) {
                              if (_index <= 1) {
                                setState(() {
                                  _index += 1;
                                });
                              }else{
                                getDataPiece(context);
                                var date = widget.dropdownDatePicker.getDate('-');
                                await Future.delayed(const Duration(seconds: 3), (){});
                                    AdresseE adres = AdresseE(adresse: _adresse.text, paysId: _selected_pays_residence.code, codePostal: '2263', quartier: _adresse.text, villeId: selected_ville['code'], telephone: _telephone.text, email: _adresseMail.text,);
                                    PersonneE _personne = PersonneE(resident: _estResident==Residence.OUI? true:false, dateNaissance: DateTime.parse(date),
                                        paysResidence: _selected_pays_residence.nom,
                                        nationalite: _nationalite.text,
                                        nom: _nom.text,
                                        prenom: _prenom.text,
                                        sexe: _sexe == Sexe.homme? 'MASCULIN': 'FEMININ',
                                        photo: retour? imageRetourne: '_image',
                                        etatMatrimoniale: _selected_etat_matrimonial,
                                        adresse:adres);

                                    ClientE client = ClientE(personne: _personne);
                                    var _client = client.toMap();
                                    var adresse = adres.toString();
                                    print('je suis le nouveau client avec les nouvelles données: $_client');

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Souscrire(),
                                        settings: RouteSettings(name:adresse ,arguments: _client)));



                              }

                            }},
                            onStepTapped: (int index) {
                              setState(() {
                                _index = index;

                              });
                            },

                              controlsBuilder: (BuildContext context, ControlsDetails details) {
                                return Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      width: MediaQuery.of(context).size.width*0.25,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      child: TextButton(
                                        onPressed: details.onStepContinue,
                                        child: const Text('Suivant', style: TextStyle(color: Colors.white),),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.25,
                                      height: 45,
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey,
                                        ),
                                      child: TextButton(
                                        onPressed: details.onStepCancel,
                                        child: const Text('Retour', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                );
                              },

                              steps: <Step>[
                                Step(
                                  isActive: _index ==0,
                                  title: const Text('Identité'),
                                  content: Form(
                                    key: formKeys[0],
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio<Sexe>(
                                                  activeColor: const Color(0xff4a9e04),
                                                  value: Sexe.homme,
                                                  groupValue: _sexe,

                                                  onChanged: (Sexe? value) {
                                                    setState(() {
                                                      _sexe = value;
                                                    });
                                                  },
                                                ),
                                                const Text('Homme'),
                                                const SizedBox(width: 30,),
                                                Radio<Sexe>(
                                                  value: Sexe.femme,
                                                  groupValue: _sexe,
                                                  onChanged: (Sexe? value) {
                                                    setState(() {
                                                      _sexe = value;
                                                    });
                                                  },
                                                ),
                                                const Text('Femme'),
                                              ],
                                            ),


                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 10),
                                              child: TextFormField(
                                                controller: _nom,
                                                decoration: InputDecoration(
                                                  label: Row(
                                                    children: const [
                                                      Padding(
                                                        padding: EdgeInsets.all(3.0),
                                                      ),
                                                      Text("Nom"),
                                                      Text('*', style: TextStyle(color: Colors.red)),

                                                    ],
                                                  ),
                                                ),
                                                // The validator receives the text that the user has entered.
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Entrer le nom';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 10),
                                              child: TextFormField(
                                                controller: _prenom,
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  label: Row(
                                                    children: const [
                                                      Padding(
                                                        padding: EdgeInsets.all(3.0),
                                                      ),
                                                      Text("Prenom"),
                                                      Text('*', style: TextStyle(color: Colors.red)),

                                                    ],
                                                  ),
                                                ),
                                                // The validator receives the text that the user has entered.
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Entrer le prenom';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),

                                            const SizedBox(height: 5,),
                                            Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width,
                                              margin: const EdgeInsets.all(5),
                                              child: DropdownButtonHideUnderline(
                                                child: GFDropdown(
                                                  hint:  Row(
                                                children: const [
                                                Padding(
                                                padding: EdgeInsets.all(3.0),
                                              ),
                                              Text("Situation Matrimoniale"),
                                              Text('*', style: TextStyle(color: Colors.red)),

                                              ],
                                            ),
                                                  padding: const EdgeInsets.only(left: 15, right: 5),
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: const BorderSide(
                                                      color: Colors.black12, width: 1),
                                                  dropdownButtonColor: Colors.grey[100],
                                                  value: _selected_etat_matrimonial,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _selected_etat_matrimonial = newValue;
                                                    });
                                                  },
                                                  items:_etat_matrimonial
                                                      .map((value) => DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value),
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 5,),
                                            Container(
                                              margin: EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Row(
                                              children: const [
                                              Padding(
                                              padding: EdgeInsets.all(3.0),
                                            ),
                                            Text("Date de Naissance"),
                                            Text('* ', style: TextStyle(color: Colors.red)),

                                          ],
                                        ),
                                                  ),
                                                  Container(child: widget.dropdownDatePicker),
                                                ],
                                              ),
                                            ),
                                            // ElevatedButton(
                                            //   onPressed: () => setState(
                                            //         () => (debugPrint('Rebuild UI.')),
                                            //   ),
                                            //   child: const Text('Print current date.'),
                                            // ),

                                            // Container(
                                            //   margin: const EdgeInsets.symmetric(horizontal: 10),
                                            //   child: TextFormField(
                                            //     decoration: const InputDecoration(
                                            //       icon: Icon(Icons.calendar_today_outlined, color: Color(0xff4a9e04),),
                                            //       labelText: 'Date de Naissance',
                                            //     ),
                                            //     controller: _date,
                                            //     onTap: () async {
                                            //       DateTime? picked = await showDatePicker(
                                            //           context: context,
                                            //           initialDate: DateTime.now(),
                                            //           firstDate: DateTime(1950, 8),
                                            //           lastDate: DateTime(2101));
                                            //       if (picked != null) {
                                            //         // print(DateFormat('yyyy-MM-dd').format(picked));
                                            //         setState(() {
                                            //           _date.text = DateFormat('yyyy-MM-dd').format(picked);
                                            //         });
                                            //       }
                                            //     },
                                            //     validator: (value) {
                                            //       if (value == null || value.isEmpty) {
                                            //         return 'Entrer la date de naissance';
                                            //       }
                                            //       return null;
                                            //     },
                                            //   ),
                                            // ),



                                            // Container(
                                            //   margin: const EdgeInsets.symmetric(horizontal: 10),
                                            //   child: TextFormField(
                                            //     controller: _profession,
                                            //     decoration: const InputDecoration(
                                            //       labelText: 'Profession',
                                            //     ),
                                            //     // The validator receives the text that the user has entered.
                                            //     validator: (value) {
                                            //       if (value == null || value.isEmpty) {
                                            //         return 'Entrer la profession';
                                            //       }
                                            //       return null;
                                            //     },
                                            //   ),
                                            // ),

                                            Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width,
                                              margin: const EdgeInsets.all(5),
                                              child: DropdownButtonHideUnderline(
                                                child: GFDropdown(
                                                  hint: Row(
                                                children: const [
                                                Padding(
                                                padding: EdgeInsets.all(3.0),
                                              ),
                                              Text("Secteur d'activité"),
                                              Text('*', style: TextStyle(color: Colors.red)),

                                              ],
                                            ),
                                                  padding: const EdgeInsets.only(left: 15, right: 5),
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: const BorderSide(
                                                      color: Colors.black12, width: 1),
                                                  dropdownButtonColor: Colors.grey[100],
                                                  value: _selected_profession,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _selected_profession = newValue;
                                                      select = true;
                                                    });
                                                  },
                                                  items:_profession
                                                      .map((value) => DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value['libelle'].toString()),
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 5,),
                                            !select? Container():
                                            (_selected_profession['libelle'].toString() == 'Autre')?Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                                  child: TextField(
                                                    // keyboardType: TextInputType.number,
                                                    // controller: mise,
                                                    decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                      focusedBorder:OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Color(0xff4a9e04), width: 2.0),
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                      hintText: 'Préciser le secteur d\'activité',

                                                    ),
                                                    controller: _professionPreciser
                                                  ),
                                                ),
                                              ],
                                            ):Container(),
                                            const SizedBox(height: 5,),
                                            Column(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Text('Numero de Téléphone'),
                                                    Text('*', style: TextStyle(color: Colors.red),),
                                                  ],
                                                ),
                                                InternationalPhoneNumberInput(
                                                  hintText: '',
                                                  errorMessage: 'Numéro de téléphone incorrecte',
                                                  maxLength: 9,
                                                  onInputChanged: (PhoneNumber number) {
                                                    print(number.phoneNumber);
                                                  },
                                                  onInputValidated: (bool value) {
                                                    print(value);
                                                  },
                                                  selectorConfig: const SelectorConfig(
                                                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                                  ),
                                                  ignoreBlank: false,
                                                  autoValidateMode: AutovalidateMode.disabled,
                                                  selectorTextStyle: const TextStyle(color: Colors.black),
                                                  initialValue: number,
                                                  textFieldController: _telephone,
                                                  formatInput: false,
                                                  keyboardType:
                                                  const TextInputType.numberWithOptions(signed: true, decimal: true),
                                                  inputBorder: const OutlineInputBorder(),
                                                  onSaved: (PhoneNumber number) {
                                                    print('On Saved: $number');
                                                  },
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 2,
                                              color: Colors.black12,
                                            ),
                                            const SizedBox(height: 5,),
                                            // Container(
                                            //   margin: const EdgeInsets.symmetric(horizontal: 10),
                                            //   child: TextFormField(
                                            //     controller: _adresseMail,
                                            //     decoration: const InputDecoration(
                                            //       labelText: 'Adresse Mail',
                                            //     ),
                                            //     // The validator receives the text that the user has entered.
                                            //     validator: (value) {
                                            //       if (value == null || value.isEmpty) {
                                            //         return 'Please enter some text';
                                            //       }
                                            //       return null;
                                            //     },
                                            //   ),
                                            // ),

                                            Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width,
                                              margin: const EdgeInsets.all(5),
                                              child: DropdownButtonHideUnderline(
                                                child: GFDropdown(
                                                  hint: Row(
                                                    children: const [
                                                      Padding(
                                                        padding: EdgeInsets.all(3.0),
                                                      ),
                                                      Text("Type de pièce"),
                                                      Text('*', style: TextStyle(color: Colors.red)),

                                                    ],
                                                  ),
                                                  padding: const EdgeInsets.only(left: 15, right: 5),
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: const BorderSide(
                                                      color: Colors.black12, width: 1),
                                                  dropdownButtonColor: Colors.grey[100],
                                                  value: _selected_piece,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _selected_piece = newValue;
                                                    });
                                                  },
                                                  items:_type_piece
                                                      .map((value) => DropdownMenuItem(
                                                    value: value,
                                                    child: _type_piece.isEmpty? const Text('Liste de pièce vide'):Text(value['libelle']),
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 5,),
                                            // Container(
                                            //   margin: const EdgeInsets.symmetric(horizontal: 10),
                                            //   child: TextFormField(
                                            //     controller: _pieceIdentite,
                                            //     decoration: const InputDecoration(
                                            //       labelText: 'Pièce d\'identité',
                                            //     ),
                                            //     // The validator receives the text that the user has entered.
                                            //     validator: (value) {
                                            //       if (value == null || value.isEmpty) {
                                            //         return 'Please enter some text';
                                            //       }
                                            //       return null;
                                            //     },
                                            //   ),
                                            // ),
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 10),
                                              child: TextFormField(
                                                controller: _numPieceIndentite,
                                                decoration: InputDecoration(
                                                  label:Row(
                                                    children: const [
                                                      Padding(
                                                        padding: EdgeInsets.all(3.0),
                                                      ),
                                                      Text("Numéro de la pièce"),
                                                      Text('*', style: TextStyle(color: Colors.red)),

                                                    ],
                                                  ),
                                                ),
                                                // The validator receives the text that the user has entered.
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                Step(
                                  isActive: _index ==1,
                                  title: const Text('Adresse'),
                                  content: Form(
                                    key: formKeys[1],
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text('Est-il(elle) Résident(te)'),
                                            Text('*', style: TextStyle(color: Colors.red,),)
                                          ],
                                        ),
                                        Center(
                                          child: Row(
                                            children: [
                                              Radio<Residence>(
                                                value: Residence.OUI,
                                                groupValue: _estResident,
                                                onChanged: (Residence? value) {
                                                  setState(() {
                                                    _estResident = value;
                                                  });
                                                },
                                              ),
                                              const Text('OUI'),
                                              const SizedBox(width: 30,),
                                              Radio<Residence>(
                                                value: Residence.NON,
                                                groupValue: _estResident,
                                                onChanged: (Residence? value) {
                                                  setState(() {
                                                    _estResident = value;
                                                  });
                                                },
                                              ),
                                              const Text('NON'),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          child: TextFormField(
                                            controller: _lieuNaiss,
                                            decoration: InputDecoration(
                                              label: Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.all(3.0),
                                                  ),
                                                  Text("Lieu de Naissance"),
                                                  Text('*', style: TextStyle(color: Colors.red)),

                                                ],
                                              ),
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),

                                        Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.all(5),
                                          child: DropdownButtonHideUnderline(
                                            child: GFDropdown(
                                              hint: Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.all(3.0),
                                                  ),
                                                  Text("Ville de Naissance"),
                                                  Text('*', style: TextStyle(color: Colors.red)),

                                                ],
                                              ),
                                              padding: const EdgeInsets.only(left: 15, right: 5),
                                              borderRadius: BorderRadius.circular(10),
                                              border: const BorderSide(
                                                  color: Colors.black12, width: 1),
                                              dropdownButtonColor: Colors.grey[100],
                                              value: selected_ville,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selected_ville = newValue;
                                                });
                                              },
                                              items:_ville
                                                  .map((value) => DropdownMenuItem(
                                                value: value,
                                                child: _ville.isEmpty? const Text('Pas de ville disponible') : Text(value['nom']),
                                              ))
                                                  .toList(),
                                            ),
                                          ),
                                        ),

                                        // Container(
                                        //   margin: const EdgeInsets.symmetric(horizontal: 10),
                                        //   child: TextFormField(
                                        //     controller: _villeNaiss,
                                        //     decoration: const InputDecoration(
                                        //       labelText: 'Ville de Naissance',
                                        //     ),
                                        //     // The validator receives the text that the user has entered.
                                        //     validator: (value) {
                                        //       if (value == null || value.isEmpty) {
                                        //         return 'Please enter some text';
                                        //       }
                                        //       return null;
                                        //     },
                                        //   ),
                                        // ),
                                        // const SizedBox(height: 5,),
                                        //
                                        // Container(
                                        //   height: 50,
                                        //   width: MediaQuery.of(context).size.width,
                                        //   margin: const EdgeInsets.all(5),
                                        //   child: DropdownButtonHideUnderline(
                                        //     child: GFDropdown(
                                        //       hint: const Text('Type d\'adresse'),
                                        //       padding: const EdgeInsets.only(left: 15, right: 5),
                                        //       borderRadius: BorderRadius.circular(10),
                                        //       border: const BorderSide(
                                        //           color: Colors.black12, width: 1),
                                        //       dropdownButtonColor: Colors.grey[100],
                                        //       value: _selected_pays_residence,
                                        //       onChanged: (newValue) {
                                        //         setState(() {
                                        //           _selected_pays_residence = newValue;
                                        //         });
                                        //       },
                                        //       items:_list_pays
                                        //           .map((value) => DropdownMenuItem(
                                        //         value: value,
                                        //         child: Text(value),
                                        //       ))
                                        //           .toList(),
                                        //     ),
                                        //   ),
                                        // ),

                                        // Container(
                                        //   height: 50,
                                        //   width: MediaQuery.of(context).size.width,
                                        //   margin: const EdgeInsets.all(5),
                                        //   child: DropdownButtonHideUnderline(
                                        //     child: GFDropdown(
                                        //       hint: const Text('choix du pays de naissance'),
                                        //       padding: const EdgeInsets.only(left: 15, right: 5),
                                        //       borderRadius: BorderRadius.circular(10),
                                        //       border: const BorderSide(
                                        //           color: Colors.black12, width: 1),
                                        //       dropdownButtonColor: Colors.grey[100],
                                        //       value: _selected_pays,
                                        //       onChanged: (newValue) {
                                        //         setState(() {
                                        //           _selected_pays = newValue;
                                        //         });
                                        //       },
                                        //       items:_list_pays
                                        //           .map((value) => DropdownMenuItem(
                                        //         value: value,
                                        //         child: Text(value),
                                        //       ))
                                        //           .toList(),
                                        //     ),
                                        //   ),
                                        // ),


                                        // Container(
                                        //   height: 50,
                                        //   width: MediaQuery.of(context).size.width,
                                        //   margin: const EdgeInsets.all(5),
                                        //   child: DropdownButtonHideUnderline(
                                        //     child: GFDropdown(
                                        //       hint: const Text('Pays de Naissance'),
                                        //       padding: const EdgeInsets.only(left: 15, right: 5),
                                        //       borderRadius: BorderRadius.circular(10),
                                        //       border: const BorderSide(
                                        //           color: Colors.black12, width: 1),
                                        //       dropdownButtonColor: Colors.grey[100],
                                        //       value: _selected_pays,
                                        //       onChanged: (newValue) {
                                        //         setState(() {
                                        //           _selected_pays = newValue;
                                        //         });
                                        //       },
                                        //       items:_list_pays
                                        //           .map((value) => DropdownMenuItem(
                                        //         value: value,
                                        //         child: Text(value),
                                        //       ))
                                        //           .toList(),
                                        //     ),
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   height: 55,
                                        //   width: largeur,
                                        //   child: AwesomeDropDown(
                                        //     isPanDown: _isPanDown,
                                        //     dropDownBorderRadius: 1,
                                        //     dropDownBottomBorderRadius: 1,
                                        //     dropDownTopBorderRadius: 2,
                                        //     dropDownList: _list_pays,
                                        //     elevation: 1,
                                        //     padding: 0,
                                        //     isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                                        //     selectedItem: _selected_pays,
                                        //     onDropDownItemClick: (selectedItem) {
                                        //       _selected_pays = selectedItem;
                                        //       // data['produit'] = _selectedItem;
                                        //     },
                                        //     dropStateChanged: (isOpened) {
                                        //       if (!isOpened) {
                                        //         _isBackPressedOrTouchedOutSide = false;
                                        //       }
                                        //     },
                                        //   ),
                                        // ),
                                        const SizedBox(height: 5,),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          child: TextFormField(
                                            controller: _adresse,
                                            decoration: InputDecoration(
                                              label:Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.all(3.0),
                                                  ),
                                                  Text("Adresse"),
                                                  Text('*', style: TextStyle(color: Colors.red)),

                                                ],
                                              ),
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 70,
                                        //   child: AwesomeDropDown(
                                        //     isPanDown: _isPanDown,
                                        //     dropDownBorderRadius: 20,
                                        //     dropDownBottomBorderRadius: 20,
                                        //     dropDownTopBorderRadius: 20,
                                        //      dropDownList: _types_addresses,
                                        //     isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                                        //     selectedItem: _selected_type_adresses,
                                        //     onDropDownItemClick: (selectedItem) {
                                        //       _selected_type_adresses = selectedItem;
                                        //       // data['produit'] = _selected_type_adresses;
                                        //     },
                                        //     dropStateChanged: (isOpened) {
                                        //       _isDropDownOpened = isOpened;
                                        //       if (!isOpened) {
                                        //         _isBackPressedOrTouchedOutSide = false;
                                        //       }
                                        //     },
                                        //   ),
                                        // ),
                                        const SizedBox(height: 25),
                                        // Container(
                                        //   margin: const EdgeInsets.symmetric(horizontal: 10),
                                        //   child: TextFormField(
                                        //     controller: _paysResidence,
                                        //     decoration: const InputDecoration(
                                        //       labelText: 'Pays de Résidence',
                                        //     ),
                                        //     // The validator receives the text that the user has entered.
                                        //     validator: (value) {
                                        //       if (value == null || value.isEmpty) {
                                        //         return 'Please enter some text';
                                        //       }
                                        //       return null;
                                        //     },
                                        //   ),
                                        // ),

                                        Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.all(5),
                                          child: DropdownButtonHideUnderline(
                                            child: GFDropdown(
                                              hint: Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.all(3.0),
                                                  ),
                                                  Text("Pays de résidence"),
                                                  Text('*', style: TextStyle(color: Colors.red)),

                                                ],
                                              ),
                                              padding: const EdgeInsets.only(left: 15, right: 5),
                                              borderRadius: BorderRadius.circular(10),
                                              border: const BorderSide(
                                                  color: Colors.black12, width: 1),
                                              dropdownButtonColor: Colors.grey[100],
                                              value: _selected_pays_residence,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _selected_pays_residence = newValue;
                                                });
                                              },
                                              items:_list_pays
                                                  .map((value) => DropdownMenuItem(
                                                value: value,
                                                child: Text(value.nom),
                                              ))
                                                  .toList(),
                                            ),
                                          ),
                                        ),



                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          child: TextFormField(
                                            controller: _nationalite,
                                            decoration: const InputDecoration(
                                              labelText: 'Nationalité',
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                ),

                                Step(title: const Text('Photo'),
                                    isActive: _index ==2,
                                    content: Form(
                                      key: formKeys[2],
                                      child: Column(
                                        children: [
                                          Text('Charger la photo'),
                                          SizedBox(height: 20,),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height*0.4,
                                            width: MediaQuery.of(context).size.width*0.8,
                                            child: (changerImage == true )?Image(image: FileImage(File(imageFile.path)),
                                            fit: BoxFit.cover,):Container(
                                              color: Colors.grey,),
                                          ),
                                          SizedBox(height: 20,),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                MaterialButton(
                                                    color: Colors.lightBlueAccent,
                                                    child: const Text(
                                                        "Depuis la gallery",
                                                        style: TextStyle(
                                                            color: Colors.white70, fontWeight: FontWeight.bold
                                                        )
                                                    ),
                                                    onPressed: () {
                                                      _getFrom(ImageSource.gallery);
                                                    }
                                                ),
                                                MaterialButton(
                                                    color: Colors.lightBlueAccent,
                                                    child: const Text(
                                                        "Depuis la camera",
                                                        style: TextStyle(
                                                            color: Colors.white70, fontWeight: FontWeight.bold
                                                        )
                                                    ),
                                                    onPressed: () {
                                                      _getFrom(ImageSource.camera);
                                                    }
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                

                              ],


                            )),


              )]),
                  )));


  }
 
}


class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {Key? key, required this.icon, required this.color, required this.text, required this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}


class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}


// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Center(
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton2(
//           isExpanded: true,
//           hint: Text(
//             'Select Item',
//             style: TextStyle(
//               fontSize: 14,
//               color: Theme.of(context).hintColor,
//             ),
//           ),
//           items: items
//               .map((item) => DropdownMenuItem<String>(
//             value: item,
//             child: Text(
//               item,
//               style: const TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           ))
//               .toList(),
//           value: selectedValue,
//           onChanged: (value) {
//             setState(() {
//               selectedValue = value as String;
//             });
//           },
//           buttonHeight: 40,
//           buttonWidth: 200,
//           itemHeight: 40,
//           dropdownMaxHeight: 200,
//           searchController: textEditingController,
//           searchInnerWidget: Padding(
//             padding: const EdgeInsets.only(
//               top: 8,
//               bottom: 4,
//               right: 8,
//               left: 8,
//             ),
//             child: TextFormField(
//               controller: textEditingController,
//               decoration: InputDecoration(
//                 isDense: true,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 8,
//                 ),
//                 hintText: 'Search for an item...',
//                 hintStyle: const TextStyle(fontSize: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//           searchMatchFn: (item, searchValue) {
//             return (item.value.toString().contains(searchValue));
//           },
//           //This to clear the search value when you close the menu
//           onMenuStateChange: (isOpen) {
//             if (!isOpen) {
//               textEditingController.clear();
//             }
//           },
//         ),
//       ),
//     ),
//   );
// }