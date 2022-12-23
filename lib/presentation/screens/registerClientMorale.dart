import 'package:emf_tontine/presentation/screens/registerClient.dart';
import 'package:emf_tontine/presentation/screens/souscrire.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ClientMoral extends StatefulWidget {
  const ClientMoral({Key? key}) : super(key: key);

  @override
  State<ClientMoral> createState() => _ClientMoralState();


}

class _ClientMoralState extends State<ClientMoral> {


  final TextEditingController _date = TextEditingController();
  late String dropdown;
  bool _isBackPressedOrTouchedOutSide = false,
      _isPanDown = false;
  bool _isDropDownOpened = false;
  late final List<String> _list = ["Abc", "DEF", "GHI", "JKL", "MNO", "PQR"];
  String _selectedItem = '';
  List<String> Adresse = [''];
  List<String> Civilite = [''];

  var _index= 0;
  var hauteur;
  var largeur;
  var numero;
  bool isLoading = false;
  Residence? _estResident = Residence.OUI;


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
        body: Column(
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
              child: Theme(data: ThemeData(
              accentColor: Color(0xff4a9e04),
              // primarySwatch: Color(0xff4a9e04),
              colorScheme: ColorScheme.light(
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Souscrire()));
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
                                      decoration: const InputDecoration(
                                        labelText: 'Téléphone',
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Entrer le numéro de télephone';
                                        }
                                        return null;
                                      },
                                    ),


                                    TextFormField(
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
                                      controller: _date,
                                      onTap: () async {
                                        DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950, 8),
                                            lastDate: DateTime(2101));
                                        if (picked != null) {
                                          print(DateFormat('yyyy-MM-dd').format(picked));
                                          setState(() {
                                            _date.text = DateFormat('yyyy-MM-dd').format(picked);
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
                                    const SizedBox(height: 5,),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Pays',
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Entrer le pays';
                                        }
                                        return null;
                                      },
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


                                    TextFormField(
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
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Ville',
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Entrer la ville';
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

                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Pays de Residence',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
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
