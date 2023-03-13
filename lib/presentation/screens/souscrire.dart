

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/data/apiProviders/enumApi.dart';
import 'package:emf_tontine/data/models/client_particulier.dart';
import 'package:emf_tontine/data/models/objet.dart';
import 'package:emf_tontine/presentation/screens/clients.dart';
import 'package:emf_tontine/presentation/screens/otp.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emf_tontine/globals.dart' as global;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




class Souscrire extends StatefulWidget {
  const Souscrire({Key? key}) : super(key: key);

  @override
  State<Souscrire> createState() => _SouscrireState();
}

class _SouscrireState extends State<Souscrire> {

  final  _prefs = SharedPreferences.getInstance();

  bool isLoading = true;
  bool isLoading1 = true;
  bool selected = false;
  bool selectedCycle = false;

  double prixVenteCarnet = 0;
  dynamic carnet;

  dynamic _selectionProduit;
  late final List<Objet> _objets = [];
  late final List<dynamic> _produits = [];
  late final List<dynamic> _cycle = [];
  dynamic _selected_cycle;
  dynamic _selectionObjet;
  TextEditingController autreObjet = TextEditingController();
  TextEditingController mise = TextEditingController();
  final bool _validate = false;
  late ClientE _client;


  late String dropdown;
  String _selectedItem = '';
  Map data = {};


  getDataObjet() async {
    var list = await GetDataProvider().getObjet(context);
    if(list != null){
      for(int i = 0; i< list.length; i++){
        print('objet ${list[i].libelle}');
        _objets.add(list[i]);
        setState(() {
          isLoading = false;
        });
      }
    }else{
      print('Le retour est nul');
    }


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

    print('afficher les données: $myData');
    print('afficher les données1: $myData');
    print('afficher les données2: $myData');

    // var donnee = json.encode(myData, toEncodable: myDateSerializer);
    String lienClients = '$lienDev''clients/retail/souscription/create';
    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');

    print('envoyées: ${jsonEncode(myData)}');
    try {
      print('nouveau: $myData');
      final response = await http.post(Uri.parse(lienClients),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
            'Authorization': 'Bearer $accessToken'},
          body: jsonEncode(myData));
      print('le statut du retour avant ${response.statusCode}');
      if(response.body.isNotEmpty){
        print('le statut du retour avant0 ${response.statusCode}');
        if (response.statusCode == 201) {
          global.status = response.statusCode;
          print('le statut du retour avant1 ${response.statusCode}');

          return response.statusCode;
        } else if(response.statusCode == 401){
          refreshToken(context);
          return postClientParticulier( context,  objetSous, client,  montantMise,  cycle);
        }  else {
          return response.statusCode;
        }
      }
    } catch (e) {
      print('error: ${(e.toString())}');
    }
    return null;

  }

  getDataProduit() async {
    List<dynamic> list = await getProdriut(context);
    if(list != null){
      for(int i = 0; i< list.length; i++){
        _produits.add(list[i]);
        print(_produits[i]['code']);
        setState(() {
          isLoading1 = false;
        });
      }
    }else{
      print('Le retour est nul');
    }


  }

  getDataPrix(String cycle) async {
    carnet = await getCarnet(context, cycle);
    if(carnet != null){
      prixVenteCarnet = carnet['prixVente'];
    }else{
      print('Le retour est nul');
    }


  }

  getDataCycle() async {
    List<dynamic> list = await GetDataProvider().getCycle(context);
    if(list != null){
      for(int i = 0; i< list.length; i++){
        _cycle.add(list[i]);
        setState(() {
          isLoading1 = false;
        });
      }
    }else{
      print('Le retour est nul');
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    getDataObjet();
    getDataProduit();
    getDataCycle();

    super.initState();
  }

  @override
  void setState(VoidCallback fn) async {
    // TODO: implement setState
    super.setState(fn);
    _selectedItem=_selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    // final Object? client = ModalRoute.of(context)?.settings.arguments;
    final Map client = ModalRoute.of(context)?.settings.arguments as Map;

    print(client);

    return Scaffold(
      appBar: AppBar(
        elevation: 00,
        backgroundColor: const Color(0xff4a9e04),
        title: const Text('Souscrisption à un produit'),
      ),
      body:(isLoading || isLoading1) ? const Center(child: CircularProgressIndicator()):
      Column(
        children: [
         const SizedBox(height: 10,),
          Container(
            color: Colors.white,
            child: Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: Container(
                  // margin: const EdgeInsets.only(top: 40, right: 20),
                  height: 80,
                  width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1,
                            color: Colors.grey
                        ),
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/newIcons/ic_newProfile.png")
                        ))
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ID: ', style: GoogleFonts.abhayaLibre(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300),),
                  const SizedBox(width: 3,),
                  Text('00032', style:GoogleFonts.abhayaLibre(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      // fontStyle: FontStyle.italic,
                      color: Colors.black
                  ),),

                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nom: ', style: GoogleFonts.abhayaLibre(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300),),
                  const SizedBox(width: 3,),
                ],
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Center(
                      child: Text('Choix du produit tontine', style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),),
                    )),

                const SizedBox(height: 30),

                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10),
                  child: DropdownButtonHideUnderline(
                    child: GFDropdown(
                      hint: const Text('choisir un produit'),
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      borderRadius: BorderRadius.circular(10),
                      border: const BorderSide(
                          color: Colors.black12, width: 1),
                      dropdownButtonColor: Colors.grey[100],
                      value: _selectionProduit,
                      onChanged: (newValue) {
                        setState(() {
                          _selectionProduit = newValue;
                          data['produit'] = _selectionProduit;
                        });
                      },
                      items:_produits
                          .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value['nomProduit']),
                      ))
                          .toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                Container(
                  padding: const EdgeInsets.only(left: 10),
                    child: Text(selected?'Frequence de collecte':'')),

                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                                color: Colors.black12,
                                width: 1.0,
                                ),
                        color: Colors.grey[100],
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: !selected? 'Fréquence collecte': _selectionProduit['freqCollecte']['libelle'],
                        border: InputBorder.none,
                    )
                  ),
                ),
                const SizedBox(height: 20,),


                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10),
                  child: DropdownButtonHideUnderline(
                    child: GFDropdown(
                      hint: const Text('Cycle'),
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      borderRadius: BorderRadius.circular(10),
                      border: const BorderSide(
                          color: Colors.black12, width: 1),
                      dropdownButtonColor: Colors.grey[100],
                      value: _selected_cycle,
                      onChanged: (newValue) {
                        setState(() {
                          _selected_cycle = newValue;
                          carnet = getDataPrix(_selected_cycle['libelle']);
                          selectedCycle = true;

                        });
                      },
                      items:_cycle
                          .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value['libelle']),
                      ))
                          .toList(),
                    ),
                  ),
                ),

                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(selectedCycle?'Prix carnet':'')),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.0,
                    ),
                    color: Colors.grey[100],
                  ),
                  child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: prixVenteCarnet.toString(),
                        border: InputBorder.none
                      )
                  ),
                ),
                const SizedBox(height: 20,),

                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10),
                  child: DropdownButtonHideUnderline(
                    child: GFDropdown(
                      hint: const Text('Objet de la tontine'),
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      borderRadius: BorderRadius.circular(10),
                      border: const BorderSide(
                          color: Colors.black12, width: 1),
                      dropdownButtonColor: Colors.grey[100],
                      value: _selectionObjet,
                      onChanged: (newValue) {
                        setState(() {
                          _selectionObjet = newValue as Objet;
                          data['produit'] = _selectionObjet.value;
                        });
                      },
                      items:_objets
                          .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.libelle),
                      ))
                          .toList(),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 70,
                //   child: AwesomeDropDown(
                //     isPanDown: _isPanDown,
                //     dropDownBorderRadius: 20,
                //     dropDownBottomBorderRadius: 20,
                //     dropDownTopBorderRadius: 20,
                //     dropDownList: _objets,
                //     isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                //     selectedItem: _selectionObjet,
                //     onDropDownItemClick: (selectedItem) {
                //       _selectionObjet = selectedItem;
                //       data['objet'] = _selectionObjet;
                //       setState(() {
                //         _selectionObjet =_selectionObjet;
                //       });
                //     },
                //     dropStateChanged: (isOpened) {
                //       if (!isOpened) {
                //         _isBackPressedOrTouchedOutSide = false;
                //       }
                //     },
                //   ),
                // ),

                const SizedBox(height: 20,),
                if(_selectionObjet == 'autre')Column(
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
                          hintText: 'Préciser l\'objet',

                        ),
                        controller: autreObjet,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20,),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Mise', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300
                    ),)),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: mise,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff4a9e04), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Entrer le montant',
                      errorText: !_validate ? 'La mise doit superieure à 1.000 F' : null,

                    ),
                  ),
                ),


                const SizedBox(height: 20,),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          minimumSize: const Size(125, 40), //////// HERE

                        ),
                        onPressed: () {
                        Navigator.pop(context);
                        },
                        icon: const Icon(Icons.cancel, color: Colors.red,),  //icon data for elevated button
                        label: const Text("Annuler", style: TextStyle(fontSize: 20),), //label text
                      ),
                    ),
                    const SizedBox(width: 20,),

                    Expanded(child: Container(),),
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4a9e04),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          minimumSize: const Size(125, 40), //////// HERE

                        ),

                        onPressed: () {
                          client['produit']= _selectionProduit;
                          autreObjet.text == ''? _selectionObjet : _selectionObjet = autreObjet.value as Objet;
                          client['objet'] = _selectionObjet.libelle;
                          print('objet de la souscription : ${_selectionObjet.libelle}');
                          print('frequence de collecte: ${_selectionProduit['freqCollecte']['value']}');
                          print('cycle de collecte: ${_selectionProduit['cycle']}');
                          data['objet'] = _selectionProduit['freqCollecte']['libelle'];
                          print('data: $data');
                          int montant = int.parse(mise.text);
                          print('print le montant: $montant');
                          client['mise'] = montant;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Otp(),
                          settings: RouteSettings(arguments: client),));
                        },
                        icon: const Icon(Icons.save),  //icon data for elevated button
                        label: const Text("Valider", style: TextStyle(fontSize: 20),), //label text
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ))

        ],
      ),
    );

  }

}
