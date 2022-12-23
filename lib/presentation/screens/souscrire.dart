
import 'dart:convert';

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/data/models/clientPhysique.dart';
import 'package:emf_tontine/data/models/souscription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class Souscrire extends StatefulWidget {
  const Souscrire({Key? key}) : super(key: key);

  @override
  State<Souscrire> createState() => _SouscrireState();
}

class _SouscrireState extends State<Souscrire> {
  List<String> _frequences = ['Journalier', 'Hebdomadaire', 'Mensuel'];
  String _selectionFrequence = 'Journalier';
  final List<String> _produits = ['Produit1', 'Produit2', 'Produit'];
  String _selectionProduit = 'Produit1';
  final List<String> _objets = ['objet1', 'objet2', 'objet3', 'autre'];
  String _selectionObjet = 'objet1';
  TextEditingController autreObjet = TextEditingController();
  TextEditingController mise = TextEditingController();
  bool _validate = false;
  late PersonnePersonne _personne;
  late SouscriptionM _souscriptionM;

  late String dropdown;
  bool _isBackPressedOrTouchedOutSide = false,
      _isDropDownOpened = false,
      _isPanDown = false;
  late final List<String> _list = ["Abc", "DEF", "GHI", "JKL", "MNO", "PQR"];
  String _selectedItem = '';
  Map data = {};

  @override
  void initState() {
    // TODO: implement initState
    data['produit'] = _selectionProduit;
    data['frequence'] = _selectionFrequence;
    data['objet'] = _selectionObjet;
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
    final Map client = ModalRoute.of(context)?.settings.arguments as Map;
    var nomComplet = client['nom']+ ' '+client['prenom'];
    Adresse adres = Adresse(adresse: 'Libreville IAI', paysId: 1, codePostal: '2263', quartier: 'IAI', villeId: 1, telephone: client['telephone'], email: client['addressMAil']);
    _personne = PersonnePersonne(nomComplet: nomComplet, telephone: client['telephone'], email: client['addressMAil'], adresse: adres, resident: client['estresident'], dateNaissance: client['dateNaissance'], paysResidence: client['paysResidence'], nationalite: client['nationalite']);
    return Scaffold(
      appBar: AppBar(
        elevation: 00,
        backgroundColor: const Color(0xff4a9e04),
        title: const Text('Souscrisption à un produit'),
      ),
      body: Column(
        children: [
          // Text('donne: ${jsonEncode(client['non'])}'),
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
                    child: const Text('Choisir un produit tontine', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),)),
                SizedBox(
                  height: 70,
                  child: AwesomeDropDown(
                    isPanDown: _isPanDown,
                    dropDownBorderRadius: 20,
                    dropDownBottomBorderRadius: 20,
                    dropDownTopBorderRadius: 20,
                    dropDownList: _produits,
                    isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                    selectedItem: _selectionProduit,
                    onDropDownItemClick: (selectedItem) {
                      _selectionProduit = selectedItem;
                      data['produit'] = _selectionProduit;
                    },
                    dropStateChanged: (isOpened) {
                      _isDropDownOpened = isOpened;
                      if (!isOpened) {
                        _isBackPressedOrTouchedOutSide = false;
                      }
                    },
                  ),
                ),

                const SizedBox(height: 30),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('INFORMAATIONS SUR LA TONTINE', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),)),
                const SizedBox(height: 10),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Preciser la périodicité', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300
                    ),)),
                SizedBox(
                  height: 70,
                  child: AwesomeDropDown(
                    isPanDown: _isPanDown,
                    dropDownBorderRadius: 20,
                    dropDownBottomBorderRadius: 20,
                    dropDownTopBorderRadius: 20,
                    dropDownList: _frequences,
                    isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                    selectedItem: _selectionFrequence,
                    onDropDownItemClick: (selectedItem) {
                      _selectionFrequence = selectedItem;
                      data['produit'] = _selectionFrequence;
                    },
                    dropStateChanged: (isOpened) {
                      _isDropDownOpened = isOpened;
                      if (!isOpened) {
                        _isBackPressedOrTouchedOutSide = false;
                      }
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Object de la souscription', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300
                    ),)),
                SizedBox(
                  height: 70,
                  child: AwesomeDropDown(
                    isPanDown: _isPanDown,
                    dropDownBorderRadius: 20,
                    dropDownBottomBorderRadius: 20,
                    dropDownTopBorderRadius: 20,
                    dropDownList: _objets,
                    isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                    selectedItem: _selectionObjet,
                    onDropDownItemClick: (selectedItem) {
                      _selectionObjet = selectedItem;
                      data['objet'] = _selectionObjet;
                      setState(() {
                        _selectionObjet =_selectionObjet;
                      });
                    },
                    dropStateChanged: (isOpened) {
                      _isDropDownOpened = isOpened;
                      if (!isOpened) {
                        _isBackPressedOrTouchedOutSide = false;
                      }
                    },
                  ),
                ),

                const SizedBox(height: 10,),

                if(_selectionObjet == 'autre')Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text('Preciser l\'objet', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                        ),)),

                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      child: TextField(
                        // keyboardType: TextInputType.number,
                        // controller: mise,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xff4a9e04), width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'Préciser l\'objet',

                        ),
                        controller: autreObjet,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20,),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Entrer la mise', style: TextStyle(
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
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff4a9e04), width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: 'Entrer le montant',
                      errorText: !_validate ? 'Le mise doit superieure à 1.000 F' : null,

                    ),
                  ),
                ),


                const SizedBox(height: 20,),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35),
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
                        icon: const Icon(Icons.save),  //icon data for elevated button
                        label: const Text("Annuler", style: TextStyle(fontSize: 20),), //label text
                      ),
                    ),
                    SizedBox(width: 20,),

                    Expanded(child: Container(),),
                    Container(
                      margin: EdgeInsets.only(right: 30),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff4a9e04),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          minimumSize: const Size(125, 40), //////// HERE

                        ),
                        onPressed: () {
                          autreObjet.text == ''? _selectionObjet : _selectionObjet = autreObjet.text;
                          _souscriptionM = SouscriptionM(produit: _selectionProduit, periodicite: _selectionFrequence, objet: _selectionObjet, mise: mise.text);
                          data['objet'] = _selectionObjet;
                          print('data: $data');
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
                  //API D'ENVOIE DES DONNEES DE LA SOUSCRIPTION
                  // texte = '' ;
                  // adherent = '' as List<String> ;
                  // widget.montant = '';
                  postClientsPhysique(_personne, _souscriptionM);
                });

              },
            ),
          ],
        );
      },
    );
  }
}
