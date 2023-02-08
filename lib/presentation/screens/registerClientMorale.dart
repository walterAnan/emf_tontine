import 'package:emf_tontine/data/apiProviders/enumApi.dart';
import 'package:emf_tontine/data/models/civilite.dart';
import 'package:emf_tontine/presentation/screens/registerClient.dart';
import 'package:emf_tontine/presentation/screens/souscrireM.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ClientMoral extends StatefulWidget {
  const ClientMoral({Key? key}) : super(key: key);

  @override
  State<ClientMoral> createState() => _ClientMoralState();


}

class _ClientMoralState extends State<ClientMoral> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _raisonSociale = TextEditingController();
  final TextEditingController _formeJuridique = TextEditingController();
  final TextEditingController _nomRespo = TextEditingController();
  final TextEditingController _prenomRespo = TextEditingController();
  final TextEditingController _dateCreation =  TextEditingController();
  final TextEditingController _telephone = TextEditingController();
  final TextEditingController _adresseMail = TextEditingController();
  final TextEditingController _quartier = TextEditingController();
  final TextEditingController _nationalite = TextEditingController();
  String initialCountry = 'GA';
  PhoneNumber number = PhoneNumber(isoCode: 'GA');
  late String dropdown;
  List<String> Adresse = [''];
  List<Civilite> _civilite = [];

  var _index= 0;
  var hauteur;
  var largeur;
  var numero;
  bool isLoading = false;
  Residence? _estResident = Residence.OUI;

  dynamic dropdownValue;

  String? selectedValue;

  final List<dynamic> _list_pays = [];
  late final List<dynamic> _type_piece = [];
  final List<String> _etat_matrimonial = [];
  dynamic _selected_pays_residence;
  dynamic _selected_pays_localisation;
  final List<dynamic> _ville =  [];
  final List<dynamic> _profession =  [];
  dynamic selected_civilite;
  dynamic selected_ville;

  bool select= false;
  List<String> list = ['Pas de type de pièce'];

  bool isLoading1 = false;
  bool isLoading2 = false;
  List<String> sexe = ['Homme', 'Femme'];
  Sexe? _sexe = Sexe.homme;



  getDataCivilite() async {
    var list = await GetDataProvider().getCivilite();
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
    var list = await GetDataProvider().getVille();
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
    var list = await GetDataProvider().getprofession();
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
    var list = await GetDataProvider().getTypePiece();
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
    var list = await GetDataProvider().getEtatMatri();
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


  getDataPays() async {
    var list = await GetDataProvider().getPays();
    if(list != null){
      for(int i = 0; i< list.length; i++){
        print('pays ${list[i]}');
        _list_pays.add(list[i]);
      }
    }else{
      print('Le retour est nul');
    }


  }

  @override
  void initState() {
    isLoading = true;
    Future.delayed(Duration.zero, ()async {
      getDataCivilite();
      getDataEtatMatri();
      getDataPays();
      getDataTypePiece();
      getDataVille();
      getDataProfession();

    });

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

    return Scaffold(
      backgroundColor: const Color(0xff4a9e04),
        body: Column(
            children: [
              Container(
                color: const Color(0xff4a9e04),
                margin: const EdgeInsets.only(top: 50),
                child: Text(
                  'Enrollement d\'un client moral', style: GoogleFonts.adamina(
                    fontSize: 19,
                  color: Colors.white
                ),
                ),
              ),

              Expanded(
              child: Theme(data: ThemeData(
              accentColor: const Color(0xff4a9e04),
              // primarySwatch: Color(0xff4a9e04),
              colorScheme: const ColorScheme.light(
              primary: Color(0xff4a9e04)
              )
              ),
                child: Form(
                  child: Container(
                      width: largeur,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                      ),
                      child: Stepper(
                         // type: StepperType.horizontal,
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
                          if (_index <= 1) {
                            setState(() {
                              _index += 1;
                            });
                          }else{
                            dynamic clientMoral = {
                              "adress": _quartier.text,
                              "quarier": _quartier.text,
                              "ville": selected_ville,
                              "telephone": _telephone.text,
                              "email": _adresseMail.text,
                              "resident": _estResident,
                              "dateCreation": _dateCreation.text,
                              "paysResidence":_selected_pays_residence,
                              "nationalite": _nationalite.text,
                              "raisonSociale": _raisonSociale.text,
                              "nomRespon":_nomRespo.text,
                              "prenomRespon":_prenomRespo.text,
                              "formeJuridique":_formeJuridique.text

                            };

                            print('les infos du client mora: $clientMoral');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SouscrireM(),
                                settings: RouteSettings(arguments: clientMoral)));
                          }
                        },
                        onStepTapped: (int index) {
                          setState(() {
                            _index = index;
                          });
                        },
                        controlsBuilder: (BuildContext context, ControlsDetails details) {
                          return Row(
                            children: <Widget>[
                              Container(
                                color: Colors.green,
                                margin: const EdgeInsets.all(5),
                                child: TextButton(
                                  onPressed: details.onStepContinue,
                                  child: const Text('Suivant', style: TextStyle(color: Colors.white),),
                                ),
                              ),
                              Container(
                                color: Colors.grey,
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
                            title: const Text('Société'),
                            content: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    const SizedBox(width: 30,),
                                    const Text('Résidente? ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
                                    const SizedBox(width: 30,),
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
                                    const SizedBox(height: 5,),
                                    TextFormField(
                                      controller: _raisonSociale,
                                      decoration: const InputDecoration(
                                        labelText: 'Raison sociale',
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Entrer la raison sociale';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 5,),

                                    TextFormField(
                                      controller: _formeJuridique,
                                      decoration: const InputDecoration(
                                        labelText: 'Forme juridique',
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Entrer la forme juridique';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 5,),
                                    // TextFormField(
                                    //   decoration: const InputDecoration(
                                    //     labelText: 'Téléphone',
                                    //   ),
                                    //   // The validator receives the text that the user has entered.
                                    //   validator: (value) {
                                    //     if (value == null || value.isEmpty) {
                                    //       return 'Entrer le numéro de télephone';
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),

                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      // child: TextFormField(
                                      //   controller: _telephone,
                                      //   keyboardType: TextInputType.number,
                                      //   decoration: const InputDecoration(
                                      //     labelText: 'Telephone',
                                      //   ),
                                      //   // The validator receives the text that the user has entered.
                                      //   validator: (value) {
                                      //     if (value == null || value.isEmpty) {
                                      //       return 'Please enter some text';
                                      //     }
                                      //     return null;
                                      //   },
                                      // ),
                                      child: InternationalPhoneNumberInput(
                                        hintText: 'Téléphone',
                                        errorMessage: 'Numéro de téléphone incorrecte',
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
                                    ),

                                    Container(
                                      height: 2,
                                      color: Colors.black12,
                                    ),


                                    TextFormField(
                                      controller: _adresseMail,
                                      decoration: const InputDecoration(
                                        labelText: 'Adresse Mail',
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Entrer le numéro de l\'adresse mail';
                                        }
                                        return null;
                                      },
                                    ),

                                    TextFormField(

                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.calendar_today_outlined),
                                        labelText: 'Date de Creation',
                                      ),
                                      controller: _dateCreation,
                                      onTap: () async {
                                        DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950, 8),
                                            lastDate: DateTime(2101));
                                        if (picked != null) {
                                          print(DateFormat('yyyy-MM-dd').format(picked));
                                          setState(() {
                                            _dateCreation.text = DateFormat('yyyy-MM-dd').format(picked);
                                          });
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Entrer la date de création';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                )),
                          ),

                          Step(
                            isActive: _index ==1,
                            title: const Text('Adresse'),
                            content: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _quartier,
                                      decoration: const InputDecoration(
                                        labelText: 'Quartier',
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Entrer le quartier';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 5,),

                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.all(5),
                                      child: DropdownButtonHideUnderline(
                                        child: GFDropdown(
                                          hint: const Text('Ville de naissance'),
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


                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.all(5),
                                      child: DropdownButtonHideUnderline(
                                        child: GFDropdown(
                                          hint: const Text('Pays de localisation'),
                                          padding: const EdgeInsets.only(left: 15, right: 5),
                                          borderRadius: BorderRadius.circular(10),
                                          border: const BorderSide(
                                              color: Colors.black12, width: 1),
                                          dropdownButtonColor: Colors.grey[100],
                                          value: _selected_pays_localisation,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selected_pays_localisation = newValue;
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
                                    const SizedBox(height: 5,),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Code Postal',
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Entrer le numéro de télephone';
                                        }
                                        return null;
                                      },
                                    ),




                                  ],
                                )),
                          ),
                          Step(
                            isActive: _index ==2,
                            title: const Text('Responsable'),
                            content: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: _nomRespo,
                                  decoration: const InputDecoration(
                                    labelText: 'Nom du Responsable',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ' Nom Responsable';
                                    }
                                    return null;
                                  },
                                ),

                                TextFormField(
                                  controller: _prenomRespo,
                                  decoration: const InputDecoration(
                                    labelText: 'Prenom du Responsable',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ' Nom du responsable';
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
                                ),

                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(5),
                                  child: DropdownButtonHideUnderline(
                                    child: GFDropdown(
                                      hint: const Text('Pays de Résidence'),
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



                              ],
                            ),
                          ),

                          Step(
                            isActive: _index ==3,
                            title: const Text('FIN'), content: Container(),

                          ),
                        ],


                      )),
                ),)


              )]));;
  }
}
