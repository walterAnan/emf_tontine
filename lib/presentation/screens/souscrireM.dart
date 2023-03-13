

import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/data/apiProviders/enumApi.dart';
import 'package:emf_tontine/data/models/client_morale_sous.dart';
import 'package:emf_tontine/data/models/client_particulier.dart';
import 'package:emf_tontine/data/models/objet.dart';
import 'package:emf_tontine/presentation/screens/registerClient.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';




class SouscrireM extends StatefulWidget {
  const SouscrireM({Key? key}) : super(key: key);

  @override
  State<SouscrireM> createState() => _SouscrireMState();
}

class _SouscrireMState extends State<SouscrireM> {
  bool isLoading = true;
  bool isLoading1 = true;
  bool selected = false;

  dynamic _selectionProduit;
  late final List<Objet> _objets = [];
  late final List<dynamic> _produits = [];
  late AdresseM _adres ;
  dynamic _selectionObjet;
  late Map _clientMoral;
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

  @override
  void initState() {
    // TODO: implement initState
    getDataObjet();
    getDataProduit();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _selectedItem=_selectedItem;
  }
  @override
  Widget build(BuildContext context) {
    // final Object? client = ModalRoute.of(context)?.settings.arguments;
    _clientMoral = ModalRoute.of(context)?.settings.arguments as Map;


    _adres = AdresseM(adresse: _clientMoral['adress'], paysId: _clientMoral['ville']['pays']['code'], codePostal: '2263', quartier: _clientMoral['quartier'], villeId: _clientMoral['ville']['code'], telephone: _clientMoral['telephone'], email: _clientMoral['email']);
    print('client moral: $_clientMoral');
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
                  Text('Nom: Morale', style: GoogleFonts.abhayaLibre(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300),),
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
                          selected = true;
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


                // Container(
                //   height: 50,
                //   width: MediaQuery.of(context).size.width,
                //   margin: const EdgeInsets.all(10),
                //   child: DropdownButtonHideUnderline(
                //     child: GFDropdown(
                //       hint: const Text('fréquence de collecte'),
                //       padding: const EdgeInsets.only(left: 15, right: 5),
                //       borderRadius: BorderRadius.circular(10),
                //       border: const BorderSide(
                //           color: Colors.black12, width: 1),
                //       dropdownButtonColor: Colors.grey[100],
                //       value: _selectionFrequence,
                //       onChanged: (newValue) {
                //         setState(() {
                //           _selectionFrequence = newValue;
                //           data['produit'] = _selectionFrequence;
                //         });
                //       },
                //       items:_frequences
                //           .map((value) => DropdownMenuItem(
                //         value: value,
                //         child: Text(value),
                //       ))
                //           .toList(),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20,),

                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(selected?'Frequence de collecte morale':'')),

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
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(selected?'Cycle':'')),

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
                          hintText: !selected? 'Cycle': _selectionProduit['cycle'],
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
                          autreObjet.text == ''? _selectionObjet : _selectionObjet = autreObjet.value as Objet;
                          // _souscriptionM = SouscriptionM(produit: _selectionProduit, periodicite: _selectionFrequence, objet: _selectionObjet, mise: mise.text);
                          data['objet'] = _selectionObjet.libelle;
                          print('objet de la souscription : ${_selectionObjet.libelle}');
                          print('frequence de collecte: ${_selectionProduit['freqCollecte']['value']}');
                          print('cycle de collecte: ${_selectionProduit['cycle']}');
                          data['objet'] = _selectionProduit['freqCollecte']['libelle'];
                          print('data: $data');
                          int montant = int.parse(mise.text);
                          print('print le montant: $montant');
                          print('print le sexe: $montant');
                          _dialogBuilder(context);
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


  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Validation', style: GoogleFonts.adamina(),),
          content: Text('Voulez-vous vraiment persister ces données?', style: GoogleFonts.adamina(),),
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
              onPressed: () {
                setState(() {
                  Map produit = {
                    'cycle': _selectionProduit['cycle']?? 'UN_MOIS',
                    'cInterneProduit': _selectionProduit['cInterne'],
                    'produitId': _selectionProduit['code'],
                  };

                  PersonneM _personneM = PersonneM(adresse: _adres, resident: _clientMoral['resident'] == Residence.OUI? true:false, dateNaissance: DateTime.parse(_clientMoral['dateCreation']), paysResidence: _clientMoral['paysResidence'], nationalite: _clientMoral['nationalite'], raisonSociale: _clientMoral['raisonSociale'], nif: '21005014-T', nomGerant: _clientMoral['nomRespon']+' '+_clientMoral['prenomRespon'], formeJuridique: 'EI');
                  
                  ClientM _clientM = ClientM(personne: _personneM, gestionnaireId: 274, typeClientId: 1041);
                  ObjetSous _objetSous = ObjetSous(libelle: _selectionObjet.libelle,
                      code: 1047,
                      guid: "35c4cb51-0f41-4553-85bb-ee7b37d77011");

                  int montant = int.parse(mise.text);
                  print('produit tous  : $produit');
                  print('produit : ${produit['code']}');

                  dynamic clientMoraleSous = {'montantMise': montant, 'cycleCarte': produit['cycle'], 'objetSous': _objetSous, 'cInterneProduit': produit['cInterneProduit'], 'produitId': produit['produitId'], 'deviseId': _clientMoral['ville']['pays']['devise']['code'], 'agenceId': 02, 'statut': 'ACTIF'};
                  postClientMoral(context,_clientM, _clientMoral,clientMoraleSous);
                });

              },
            ),
          ],
        );
      },
    );
  }
}
