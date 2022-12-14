
import 'package:emf_tontine/data/apiProviders/enumApi.dart';
import 'package:emf_tontine/presentation/screens/bottom.dart';
import 'package:emf_tontine/presentation/screens/registerClient.dart';
import 'package:emf_tontine/presentation/screens/registerClientMorale.dart';
import 'package:flutter/material.dart';




class ChoixClient extends StatelessWidget {
  const ChoixClient({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // var fido = const Adherent(
    //   id: 0,
    //   name: 'Fido',
    //   age: 35,
    // );

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Container(
            height: 250,
            width: width,
            padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
            color: Colors.grey,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_outlined),
                        onPressed: () {
                          Navigator.pop(context);
                        },),
                    const SizedBox(width: 15,),
                    const Text('Choix du type de personne', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                  ],
                ),
                const SizedBox(height: 50,),
                const Text('Choisissez le type de personne à enrégistrer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
              ],
            ),
          ),

          Container(
                  width: width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                     borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                    child: Column(
                     children: [
                       Stack(
                         children: [
                           Container(
                             // color: Colors.red,
                           )
                         ],
                       ),
                      const SizedBox(height:80),
                      const  Center(child: Text('Personnes', style: TextStyle(
                         fontSize: 25,
                         fontWeight: FontWeight.w600
                       ),)),
                       // Container(
                       //   color: Colors.green,
                       //   ),
                     ],
                    ),
                  // child: Column(
                  //   children: [
                  //     Text(''),
                  //     Row(
                  //       children: const [
                  //         InkWell(),
                  //       ],
                  //     )
                  //   ],
                  // ),
                ),
          // SizedBox(height: 30,),
          Expanded(
            child: Container(
              // padding: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: Row(
                 children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right:10),
                    width: width/2-40,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ]

                    ),
                    child: InkWell(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage('assets/images/personne_physique.png',),
                                    fit: BoxFit.fill
                                )
                            ),
                          ),
                          const Text('Personne physique'),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterClient()),
                        );
                      },
                    ),
                  ),
                   Container(
                     margin: const EdgeInsets.all(20),
                     width: width/2-40,
                     height: 180,
                     decoration: BoxDecoration(
                         color: Colors.white,
                       borderRadius: const BorderRadius.all(Radius.circular(20)),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.withOpacity(0.5),
                             spreadRadius: 5,
                             blurRadius: 7,
                             offset: const Offset(0, 3), // changes position of shadow
                           ),
                         ]
                     ),
                     child: InkWell(
                       child: Column(
                         children: [
                           Container(
                             height: 150,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 image: const DecorationImage(
                                     image: AssetImage('assets/images/personne_morale.png'),
                                     fit: BoxFit.fill
                                 )
                             ),
                           ),
                           const Text('Personne morale'),
                         ],
                       ),
                       onTap: (){
                         // DataHelper.insertAdherent(fido) ;
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) =>  const ClientMoral()),
                         );
                       },
                     ),
                   )
                ],
               ),
            ),
          )
        ],
      ),
    );
  }
}
