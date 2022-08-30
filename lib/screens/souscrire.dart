
import 'dart:ui';

import 'package:flutter/material.dart';



class Souscrire extends StatefulWidget {
  const Souscrire({Key? key}) : super(key: key);

  @override
  State<Souscrire> createState() => _SouscrireState();
}

class _SouscrireState extends State<Souscrire> {
  List<String> frequences = ['Journalier', 'Hebdomadaire', 'Mensuel'];
  List<String> produits = ['Produit1', 'Produit2', 'Produit'];
  String? selection = 'Journalier';
  String? produitSelection = 'Produit1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 00,
        title: const Text('Souscrire un client'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                width: MediaQuery.of(context).size.width-20,
                height: 60,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                       margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Image(image: AssetImage('assets/images/profile_photo.png', ),fit: BoxFit.fill,),
                    ),
                    SizedBox(width: 15,),
                    const Text('Marc', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),)

                  ],
                ),
              ),

              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20),
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   height: 60,
              //   decoration: BoxDecoration(
              //       color: Colors.grey.shade200,
              //       borderRadius: BorderRadius.circular(10)
              //   ),
              //   child: const TextField(
              //     obscureText: false,
              //     decoration: InputDecoration(
              //       border: InputBorder.none,
              //       focusedBorder: InputBorder.none,
              //       enabledBorder: InputBorder.none,
              //       errorBorder: InputBorder.none,
              //       disabledBorder: InputBorder.none,
              //       // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
              //     ),
              //   ),
              // ),

            ],
          ),
          const SizedBox(height: 20),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text('PRODUITS TONTINE', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),)),
          Column(
            children: [
              // Container(
              //   margin: EdgeInsets.only(left: 20),
              //   child: Row(
              //     children: const [
              //       Text('Frequence', style: TextStyle(
              //           fontSize: 18
              //       ),),
              //       Text('*', style: TextStyle(color: Colors.red),)
              //     ],
              //   ),
              // ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: DropdownButton<String>(
                      value: produitSelection,
                      isExpanded: true,
                      items: produits.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(
                              fontSize: 22
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

          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text('INFORMAATIONS SUR LA TONTINE', style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),)),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: const [
                    Text('Frequence', style: TextStyle(
                      fontSize: 18
                    ),),
                    Text('*', style: TextStyle(color: Colors.red),)
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: DropdownButton<String>(
                      value: selection,
                      isExpanded: true,
                      items: frequences.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(
                            fontSize: 22
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


          const SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 65,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)
            ),
            child: const TextField(
              obscureText: false,
              style: TextStyle(
                fontSize: 30
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                // border: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) )),
                labelText: 'Mise',
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 35),
                child: ElevatedButton(
                  child: const Text('Ajouter'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   // MaterialPageRoute(builder: (context) =>  const Bottom()),
                    // );
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>  const Bottom()),
                    // );
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
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
