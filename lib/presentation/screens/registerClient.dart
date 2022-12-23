
import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/data/models/clientPhysique.dart';
import 'package:emf_tontine/presentation/screens/souscrire.dart';
import 'package:emf_tontine/data/apiProviders/enumApi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum Sexe {homme, femme}
enum Residence {OUI, NON}

class RegisterClient extends StatefulWidget {
  const RegisterClient({Key? key}) : super(key: key);


  @override
  State<RegisterClient> createState() => _RegisterClientState();
}

class _RegisterClientState extends State<RegisterClient> {

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _nom = TextEditingController();
  final TextEditingController _prenom = TextEditingController();
  final TextEditingController _dateNaiss = TextEditingController();
  final TextEditingController _profession = TextEditingController();
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

  late String dropdown;
  bool _isBackPressedOrTouchedOutSide = false,
      _isPanDown = false;
  late List<String> _list_pays = ["", "", "", "", ""];
  String _selected_pays = '';
  List<String> _civilite =  [];
  List<String> _paysNaisList = ['GABON'];
  String _selected_civilite = 'selectionner le civilité';

  var _index= 0;
  var hauteur;
  var largeur;
  var numero;
  bool isLoading = false;
  List<String> sexe = ['Homme', 'Femme'];
  Sexe? _sexe = Sexe.homme;
  Residence? _estResident = Residence.OUI;


  getDataCivilite() async {
    var list = await GetDataProvider().getCivilite();
      if(list != null){
        for(int i = 0; i< list.length; i++){
          _civilite.add(list[i].libelle);
          print(list[i].libelle);
        }
      }

  }


  getDataPays() async {
    var list = await GetDataProvider().getPays();
    print('les civilités: $list');
    print(list is List);
    return list;
  }

  @override
  void initState() {
    _selected_pays = 'Selection le pays';
      Future.delayed(Duration.zero, ()async {
        getDataCivilite();
         // var _pay = List<String>.from(await getDataCivilite());

      });

    super.initState();
    isLoading = true;

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

    _displayDialog(BuildContext context) async {
      _selected = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
              child: SimpleDialog(
                title: const Text('Option d\'ajout de la photo'),
                children:[
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, "Pizza"); },
                    child: Row(
                      children: const [
                        Icon(Icons.camera_alt_outlined),
                        SizedBox(width: 20,),
                        Text('Camera')
                      ],
                    )
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, "Burger");
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.file_copy_outlined),
                        SizedBox(width: 20,),
                        Text('Galerie')
                      ],
                    ),
                  ),
                ],
                elevation: 10,
                //backgroundColor: Colors.green,
              ),
          );
        },
      );

      if(_selected != null)
      {
        setState(() {
          _selected = _selected;
        });
      }
    }


    return Scaffold(
            body: Theme(
                // color: Colors.grey,
                  data: ThemeData(
                      accentColor: const Color(0xff4a9e04),
                      colorScheme: const ColorScheme.light(
                          primary: Color(0xff4a9e04)
                      )
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                             Container(
                               margin: const EdgeInsets.only(top: 50),
                               child: Text(
                                'Enrollement d\'un client', style: GoogleFonts.adamina(
                                 fontSize: 20
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
                            onStepContinue: () {
                              if (_index <= 0) {
                                print('le sexe selectionné: ${_sexe}');
                                print('la civilité: $_selected_civilite');
                                print('la date: ${_date.text}');
                                print('le nom: ${_nom.text}');
                                print('le prenom: ${_prenom.text}');
                                print('la profession: ${_profession.text}');
                                print('le telephone: ${_telephone.text}');
                                print('adresseMail: ${_adresseMail.text}');
                                print('piece: ${_pieceIdentite.text}');
                                print('numero piece identite: ${_numPieceIndentite.text}');

                                setState(() {
                                  _index += 1;

                                });
                              }else{
                                Adresse adres = Adresse(adresse: 'Libreville IAI', paysId: 1, codePostal: '2263', quartier: 'IAI', villeId: 1, telephone: _telephone.text, email: _adresseMail.text);
                                PersonnePersonne personne = PersonnePersonne(nomComplet: _nom.text+' '+_prenom.text,
                                    telephone: _telephone.text,
                                    email: _adresseMail.text,
                                    adresse: adres,
                                    resident: _estResident == Residence.OUI? true:false,
                                    dateNaissance: DateTime.parse(_date.text),
                                    paysResidence: _selected_pays,
                                    nationalite: _nationalite.text,
                                   );
                                var personnne = personne.toMap();
                                var adresse = adres.toString();

                                print(personnne['email']);
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> const Souscrire(),
                                //     settings: RouteSettings(name:adresse ,arguments: personnne)));

                                Navigator.of(context).pushNamed('/souscrire', arguments: {
                                  'nom': _nom.text,
                                  'prenom': _prenom.text,
                                  'paysNaiss': _paysNaiss.text,
                                  'telephone':_telephone.text,
                                  'addressMAil': _adresseMail.text,
                                  'estResident':_estResident == Residence.OUI? true:false,
                                  'dateNaiss':DateTime.parse(_date.text),
                                  'pays':_selected_pays,
                                  'nationalite': _nationalite.text,

                                });
                              }
                            },
                            onStepTapped: (int index) {
                              setState(() {
                                _index = index;
                              });
                            },
                              steps: <Step>[
                                Step(
                                  isActive: _index ==0,
                                  title: const Text('Identité'),
                                  content: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Column(

                                        children: [
                                          Row(
                                            children: [
                                              Radio<Sexe>(
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
                                          const SizedBox(height: 15,),
                                          SizedBox(
                                            height: 55,
                                            width: largeur,
                                            child: AwesomeDropDown(
                                              isPanDown: _isPanDown,
                                              dropDownBorderRadius: 1,
                                              dropDownBottomBorderRadius: 1,
                                              dropDownTopBorderRadius: 2,
                                              dropDownList: _civilite,
                                              elevation: 1,
                                              padding: 0,
                                              isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                                              selectedItem: _selected_civilite,
                                              onDropDownItemClick: (selectedItem) {
                                                _selected_civilite = selectedItem;
                                              },
                                              dropStateChanged: (isOpened) {
                                                if (!isOpened) {
                                                  _isBackPressedOrTouchedOutSide = false;
                                                }
                                              },
                                            ),
                                          ),

                                          const SizedBox(height: 5,),
                                          TextFormField(
                                            controller: _nom,
                                            decoration: const InputDecoration(
                                              labelText: 'Nom',
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Entrer le nom';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 5,),
                                          TextFormField(
                                            controller: _prenom,
                                            decoration: const InputDecoration(
                                              labelText: 'Prenom',
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Entrer le prenom';
                                              }
                                              return null;
                                            },
                                          ),

                                          TextFormField(
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.calendar_today_outlined, color: Color(0xff4a9e04),),
                                              labelText: 'Date de Naissance',
                                            ),
                                            controller: _date,
                                            onTap: () async {
                                              DateTime? picked = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950, 8),
                                                  lastDate: DateTime(2101));
                                              if (picked != null) {
                                                // print(DateFormat('yyyy-MM-dd').format(picked));
                                                setState(() {
                                                  _date.text = DateFormat('yyyy-MM-dd').format(picked);
                                                });
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Entrer la date de naissance';
                                              }
                                              return null;
                                            },
                                          ),
                                          TextFormField(
                                            controller: _profession,
                                            decoration: const InputDecoration(
                                              labelText: 'Profession',
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Entrer la profession';
                                              }
                                              return null;
                                            },
                                          ),

                                          const SizedBox(height: 5,),
                                          TextFormField(
                                            controller: _telephone,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              labelText: 'Telephone',
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),

                                          const SizedBox(height: 5,),
                                          TextFormField(
                                            controller: _adresseMail,
                                            decoration: const InputDecoration(
                                              labelText: 'Adresse Mail',
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),

                                          const SizedBox(height: 5,),
                                          TextFormField(
                                            controller: _pieceIdentite,
                                            decoration: const InputDecoration(
                                              labelText: 'Pièce d\'identité',
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),
                                          TextFormField(
                                            controller: _numPieceIndentite,
                                            decoration: const InputDecoration(
                                              labelText: 'Numéro de la pièce',
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          )],
                                      )),
                                ),
                                Step(
                                  isActive: _index ==1,
                                  title: const Text('Naissance & Résidence'),
                                  content: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Est-il(elle) Résident(te)'),
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

                                      TextFormField(
                                        controller: _lieuNaiss,
                                        decoration: const InputDecoration(
                                          labelText: 'Lieu de Naissance',
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),

                                      TextFormField(
                                        controller: _villeNaiss,
                                        decoration: const InputDecoration(
                                          labelText: 'Ville de Naissance',
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 5,),
                                      SizedBox(
                                        height: 55,
                                        width: largeur,
                                        child: AwesomeDropDown(
                                          isPanDown: _isPanDown,
                                          dropDownBorderRadius: 1,
                                          dropDownBottomBorderRadius: 1,
                                          dropDownTopBorderRadius: 2,
                                          dropDownList: _list_pays,
                                          elevation: 1,
                                          padding: 0,
                                          isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                                          selectedItem: _selected_pays,
                                          onDropDownItemClick: (selectedItem) {
                                            _selected_pays = selectedItem;
                                            // data['produit'] = _selectedItem;
                                          },
                                          dropStateChanged: (isOpened) {
                                            if (!isOpened) {
                                              _isBackPressedOrTouchedOutSide = false;
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      TextFormField(
                                        controller: _adresse,
                                        decoration: const InputDecoration(
                                          labelText: 'Adresse',
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: _paysResidence,
                                        decoration: const InputDecoration(
                                          labelText: 'Pays de Résidence',
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
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
                                      )

                                    ],
                                  ),
                                ),
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