

import 'dart:ui';

import 'package:emf_tontine/screens/dashboard.dart';
import 'package:emf_tontine/screens/souscrire.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RegisterClient extends StatefulWidget {
  const RegisterClient({Key? key}) : super(key: key);

  @override
  State<RegisterClient> createState() => _RegisterClientState();
}

class _RegisterClientState extends State<RegisterClient> {
  var hauteur;
  var largeur;
  bool isLoading = false;

  void initState() {
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
    var _radioValue1;
    var _handleRadioValueChange1;
   List<String> situationMatris = ['Célibataire', 'Marié', 'Divorcé', 'Concubinage'];
   List<String> commune = ['Estuaire', 'Owendo', 'Akanda'];
   List<String> frequences = ['Journalier', 'Hebdomadaire', 'Mensuel'];
   String? selection = 'Célibataire';
   String? selectionCommune = 'Estuaire';
   String? selectionFrequence = 'Journalier';
    DateTime selectedDate = DateTime.now();
    TextEditingController _date = TextEditingController();
    var _selected ="";

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    _displayDialog(BuildContext context) async {
      _selected = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
              child: SimpleDialog(
                title: Text('Option d\'ajout de la photo'),
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
          // appBar: AppBar(
          //   backgroundColor: Colors.grey,
          //   elevation: 0,
          //   leading: Container(
          //     margin: EdgeInsets.all(5),
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(100)
          //     ),
          //     child: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined),
          //       onPressed: () {  },),
          //   ),
          //   title: Center(child: Text('Souscription', style: TextStyle(color: Colors.black45),)),
          // ),
          //   backgroundColor: Colors.transparent,
            body: Container(
                // color: Colors.grey,
                  child: Column(
                    children: [
                           Container(
                             margin: const EdgeInsets.only(top: 20),
                             child: Text(
                              'Enrollement', style: GoogleFonts.adamina(
                               fontSize: 20
                             ),
                          ),
                           ),

                      Expanded(
                        child: Container(
                          width: largeur,
                          margin: EdgeInsets.only(top: 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                          ),
                          child: ListView(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 0,
                                    groupValue: _radioValue1,
                                    onChanged: _handleRadioValueChange1,
                                  ),
                                  const Text(
                                    'Homme',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(width: 25),
                                  Radio(
                                    value: 1,
                                    groupValue: _radioValue1,
                                    onChanged: _handleRadioValueChange1,
                                  ),
                                  const Text(
                                    'Femme',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: const [
                                        Text('Nom du client'),
                                        Text('*', style: TextStyle(color: Colors.red),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: const TextField(
                                      obscureText: false,
                                      style: TextStyle(
                                          fontSize: 24
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                                        labelText: 'Cliquez pour saisir',
                                      ),
                                    ),
                                  )
                                ],

                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: const [
                                        Text('Prenom du client'),
                                        Text('*', style: TextStyle(color: Colors.red),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: const TextField(
                                      obscureText: false,
                                      style: TextStyle(
                                          fontSize: 24
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                                        labelText: 'Cliquez pour saisir',
                                      ),
                                    ),
                                  )
                                ],

                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: const [
                                        Text('Situation matrimoniale'),
                                        Text('*', style: TextStyle(color: Colors.red),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10)
                                    ),

                                    child: Container(
                                      width: largeur,
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      child: DropdownButton<String>(
                                        value: selection,
                                        isExpanded: true,
                                        items: situationMatris.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value, style: TextStyle(
                                                fontSize: 24
                                            ),),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selection = value;
                                          });

                                        },
                                      ),
                                    )
                                    // child: const TextField(
                                    //   obscureText: false,
                                    //   decoration: InputDecoration(
                                    //     border: InputBorder.none,
                                    //     focusedBorder: InputBorder.none,
                                    //     enabledBorder: InputBorder.none,
                                    //     errorBorder: InputBorder.none,
                                    //     disabledBorder: InputBorder.none,
                                    //     // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                                    //     labelText: 'Cliquez pour saisir',
                                    //   ),
                                    //
                                    // ),
                                  )
                                ],

                              ),

                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: const [
                                        Text('Date de naissance'),
                                        Text('*', style: TextStyle(color: Colors.red),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 20),
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(10)
                                      ),

                                      child: Container(
                                        width: largeur,
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        child: TextField(
                                          controller: _date,
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.calendar_today_outlined, color: Colors.blue,),
                                            labelText: 'Selectionez la date'
                                          ),
                                          onTap: () async {
                                            DateTime? dateChoisi = await showDatePicker(context: context,
                                              lastDate: DateTime(2030),
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950));
                                            if(dateChoisi != null){
                                              setState(() {
                                                // _date.text = DateFormat('yyyy-MM-dd').format()
                                                _date.text = dateChoisi as String;
                                              });
                                            }
                                          },
                                        ),
                                      )
                                    // child: const TextField(
                                    //   obscureText: false,
                                    //   decoration: InputDecoration(
                                    //     border: InputBorder.none,
                                    //     focusedBorder: InputBorder.none,
                                    //     enabledBorder: InputBorder.none,
                                    //     errorBorder: InputBorder.none,
                                    //     disabledBorder: InputBorder.none,
                                    //     // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                                    //     labelText: 'Cliquez pour saisir',
                                    //   ),
                                    //
                                    // ),
                                  )
                                ],

                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: const [
                                        Text('Lieu de naissance'),
                                        Text('*', style: TextStyle(color: Colors.red),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: const TextField(
                                      obscureText: false,
                                      style: TextStyle(
                                          fontSize: 24
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                                        labelText: 'Cliquez pour saisir',
                                      ),
                                    ),
                                  )
                                ],

                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: const [
                                        Text('Nationalité'),
                                        Text('*', style: TextStyle(color: Colors.red),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: const TextField(
                                      obscureText: false,
                                      style: TextStyle(
                                          fontSize: 24
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                                        labelText: 'Cliquez pour saisir',
                                      ),
                                    ),
                                  )
                                ],

                              ),
                              // const SizedBox(height: 10),
                              // Column(
                              //   children: [
                              //     Container(
                              //       margin: EdgeInsets.only(left: 20),
                              //       child: Row(
                              //         children: const [
                              //           Text('Nom du père'),
                              //           Text('*', style: TextStyle(color: Colors.red),)
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //       margin: EdgeInsets.symmetric(horizontal: 20),
                              //       padding: EdgeInsets.symmetric(horizontal: 20),
                              //       height: 60,
                              //       decoration: BoxDecoration(
                              //           color: Colors.grey.shade200,
                              //           borderRadius: BorderRadius.circular(10)
                              //       ),
                              //       child: const TextField(
                              //         obscureText: false,
                              //         style: TextStyle(
                              //             fontSize: 24
                              //         ),
                              //         decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           focusedBorder: InputBorder.none,
                              //           enabledBorder: InputBorder.none,
                              //           errorBorder: InputBorder.none,
                              //           disabledBorder: InputBorder.none,
                              //           // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                              //           labelText: 'Cliquez pour saisir',
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              //
                              // // ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: const [
                                        Text('Téléphone'),
                                        Text('*', style: TextStyle(color: Colors.red),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: const TextField(
                                      obscureText: false,
                                      style: TextStyle(
                                          fontSize: 24
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                                        labelText: 'Cliquez pour saisir',
                                      ),
                                    ),
                                  )
                                ],

                              ),
                              const SizedBox(height: 10),
                              // Column(
                              //   children: [
                              //     Container(
                              //       margin: EdgeInsets.only(left: 20),
                              //       child: Row(
                              //         children: const [
                              //           Text('Commune'),
                              //           Text('*', style: TextStyle(color: Colors.red),)
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //         margin: EdgeInsets.symmetric(horizontal: 20),
                              //         padding: EdgeInsets.symmetric(horizontal: 20),
                              //         height: 60,
                              //         decoration: BoxDecoration(
                              //             color: Colors.grey.shade200,
                              //             borderRadius: BorderRadius.circular(10)
                              //         ),
                              //
                              //         child: Container(
                              //           width: largeur,
                              //           margin: EdgeInsets.symmetric(horizontal: 20),
                              //           child: DropdownButton<String>(
                              //             value: selectionCommune,
                              //             items: commune.map((String value) {
                              //               return DropdownMenuItem<String>(
                              //                 value: value,
                              //                 child: Text(value, style: TextStyle(
                              //                     fontSize: 24
                              //                 ),),
                              //               );
                              //             }).toList(),
                              //             onChanged: (value) {
                              //               setState(() {
                              //                 selection = value;
                              //               });
                              //
                              //             },
                              //           ),
                              //         )
                              //       // child: const TextField(
                              //       //   obscureText: false,
                              //       //   decoration: InputDecoration(
                              //       //     border: InputBorder.none,
                              //       //     focusedBorder: InputBorder.none,
                              //       //     enabledBorder: InputBorder.none,
                              //       //     errorBorder: InputBorder.none,
                              //       //     disabledBorder: InputBorder.none,
                              //       //     // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                              //       //     labelText: 'Cliquez pour saisir',
                              //       //   ),
                              //       //
                              //       // ),
                              //     )
                              //   ],
                              //
                              // ),
                              // const SizedBox(height: 10),
                              // Column(
                              //   children: [
                              //     Container(
                              //       margin: const EdgeInsets.only(left: 20),
                              //       child: Row(
                              //         children: const [
                              //           Text('Revenu'),
                              //           Text('*', style: TextStyle(color: Colors.red),)
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //       margin: const EdgeInsets.symmetric(horizontal: 20),
                              //       padding: const EdgeInsets.symmetric(horizontal: 20),
                              //       height: 60,
                              //       decoration: BoxDecoration(
                              //           color: Colors.grey.shade200,
                              //           borderRadius: BorderRadius.circular(10)
                              //       ),
                              //       child: const TextField(
                              //         obscureText: false,
                              //         style: TextStyle(
                              //             fontSize: 24
                              //         ),
                              //         decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           focusedBorder: InputBorder.none,
                              //           enabledBorder: InputBorder.none,
                              //           errorBorder: InputBorder.none,
                              //           disabledBorder: InputBorder.none,
                              //           // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                              //           labelText: 'Cliquez pour saisir',
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              //
                              // ),
                              // SizedBox(height: 10),
                              // Column(
                              //   children: [
                              //     Container(
                              //       margin: EdgeInsets.only(left: 20),
                              //       child: Row(
                              //         children: const [
                              //           Text('Source de revenu'),
                              //           Text('*', style: TextStyle(color: Colors.red),)
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //       margin: EdgeInsets.symmetric(horizontal: 20),
                              //       padding: EdgeInsets.symmetric(horizontal: 20),
                              //       height: 60,
                              //       decoration: BoxDecoration(
                              //           color: Colors.grey.shade200,
                              //           borderRadius: BorderRadius.circular(10)
                              //       ),
                              //       child: const TextField(
                              //         obscureText: false,
                              //         style: TextStyle(
                              //             fontSize: 24
                              //         ),
                              //         decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           focusedBorder: InputBorder.none,
                              //           enabledBorder: InputBorder.none,
                              //           errorBorder: InputBorder.none,
                              //           disabledBorder: InputBorder.none,
                              //           // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                              //           labelText: 'Cliquez pour saisir',
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              //
                              // ),
                              // const SizedBox(height: 10),
                              // Column(
                              //   children: [
                              //     Container(
                              //       margin: EdgeInsets.only(left: 20),
                              //       child: Row(
                              //         children: const [
                              //           Text('Frequence'),
                              //           Text('*', style: TextStyle(color: Colors.red),)
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //         margin: EdgeInsets.symmetric(horizontal: 20),
                              //         padding: EdgeInsets.symmetric(horizontal: 20),
                              //         height: 60,
                              //         decoration: BoxDecoration(
                              //             color: Colors.grey.shade200,
                              //             borderRadius: BorderRadius.circular(10)
                              //         ),
                              //
                              //         child: Container(
                              //           width: largeur,
                              //           margin: EdgeInsets.symmetric(horizontal: 20),
                              //           child: DropdownButton<String>(
                              //             value: selectionFrequence,
                              //             isExpanded: true,
                              //             items: frequences.map((String value) {
                              //               return DropdownMenuItem<String>(
                              //                 value: value,
                              //                 child: Text(value, style: TextStyle(
                              //                     fontSize: 24
                              //                 ),),
                              //               );
                              //             }).toList(),
                              //             onChanged: (value) {
                              //               setState(() {
                              //                 selection = value;
                              //               });
                              //
                              //             },
                              //           ),
                              //         )
                              //       // child: const TextField(
                              //       //   obscureText: false,
                              //       //   decoration: InputDecoration(
                              //       //     border: InputBorder.none,
                              //       //     focusedBorder: InputBorder.none,
                              //       //     enabledBorder: InputBorder.none,
                              //       //     errorBorder: InputBorder.none,
                              //       //     disabledBorder: InputBorder.none,
                              //       //     // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                              //       //     labelText: 'Cliquez pour saisir',
                              //       //   ),
                              //       //
                              //       // ),
                              //     )
                              //   ],
                              //
                              // ),
                              // SizedBox(height: 10),
                              // Column(
                              //   children: [
                              //     Container(
                              //       margin: EdgeInsets.only(left: 20),
                              //       child: Row(
                              //         children: const [
                              //           Text('Mise'),
                              //           Text('*', style: TextStyle(color: Colors.red),)
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //       margin: EdgeInsets.symmetric(horizontal: 20),
                              //       padding: EdgeInsets.symmetric(horizontal: 20),
                              //       height: 60,
                              //       decoration: BoxDecoration(
                              //           color: Colors.grey.shade200,
                              //           borderRadius: BorderRadius.circular(10)
                              //       ),
                              //       child: const TextField(
                              //         obscureText: false,
                              //         style: TextStyle(
                              //             fontSize: 24
                              //         ),
                              //         decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           focusedBorder: InputBorder.none,
                              //           enabledBorder: InputBorder.none,
                              //           errorBorder: InputBorder.none,
                              //           disabledBorder: InputBorder.none,
                              //           // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                              //           labelText: 'Cliquez pour saisir',
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              //
                              // ),

                              const SizedBox(height: 20,),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10, right: 10),
                                    child: TextButton(child: const Text('Ajouter une photo', style: TextStyle(
                                      fontSize: 18
                                    )), onPressed: (){
                                      _displayDialog(context);
                                    },),
                                  ),




                                  Expanded(child: Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    height: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ))
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 35),
                                    child: ElevatedButton(
                                      child: const Text('Souscrire'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  const Souscrire()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          textStyle:
                                          const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  SizedBox(width: 20,),

                                  Expanded(child: Container(),),
                                  Container(
                                    margin: EdgeInsets.only(right: 30),
                                    child: ElevatedButton(
                                      child: const Text('Annuler'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  const Dashboard()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.grey,
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          textStyle:
                                          const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

              ),
        )
     ;
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
