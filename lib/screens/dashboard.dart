
import 'package:emf_tontine/colors/colors.dart';
import 'package:emf_tontine/screens/nav_bar_menu.dart';
import 'package:emf_tontine/screens/registerClient.dart';
import 'package:emf_tontine/screens/scanne.dart';
import 'package:emf_tontine/screens/souscription.dart';
import 'package:emf_tontine/screens/souscrire.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int selectedIndex = 0;
  bool isChecked = false;

  void _onItemTapped(int index){
    setState(() {
      selectedIndex = index;
      print(selectedIndex);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(title: "Home",),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, left: 20),
                child:   IconButton(onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                }, icon: const Icon(Icons.menu),),
              ),

            Expanded(child: Container(),),
            Container(
              margin: const EdgeInsets.only(top: 40, right: 20),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: kWhite,
                  borderRadius: BorderRadius.circular(100),
              ),
              child: const Image(image: AssetImage('assets/images/profile_photo.png'),),
            ),
    ]),
        const SizedBox(height: 10),
          Container(
             margin: const EdgeInsets.only(right: 170),
            // height: 30,
            // width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            //   color: kWhite,
            // ),
            child: const Text('Bonjour Marc', style: TextStyle(
              fontSize: 20
            ),),
          ),
          const SizedBox(height: 20),
          Row(
             children: [
               StreamBuilder<Object>(
                 stream: null,
                 builder: (context, snapshot) {
                   return Container(
                     margin: const EdgeInsets.only(left: 20, right: 5),
                     height: 150,
                     width: (MediaQuery.of(context).size.width - 50)/2,
                     decoration: BoxDecoration(
                       color: Colors.greenAccent.shade400,
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Column(
                       children: [
                         Row(
                           children: [
                             Container(
                               margin: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                               height: 50,
                               width: 50,

                               child: const Icon(Icons.account_balance),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(100)

                               ),
                             ),
                           ],
                         ),
                         Text('Montant Collecté', style: GoogleFonts.acme(
                             fontSize: 15,
                             color: Colors.black
                         ),),
                         Text('165 600 000', style: GoogleFonts.acme(
                             fontSize: 20,
                           color: Colors.black
                         ),),
                         Text('XAF', style: GoogleFonts.acme(
                             fontSize: 18,
                             color: Colors.black
                         ),),
                       ],
                     ),
                   );
                 }
               ),
               Container(
                 margin: const EdgeInsets.only(right: 20, left: 5),
                 height: 150,
                 width: (MediaQuery.of(context).size.width - 50)/2,
                 decoration: BoxDecoration(
                   color: Colors.indigoAccent.shade100,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Column(
                   children: [
                     Container(
                       margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 80),
                       height: 50,
                       width: 50,

                       child: const Icon(Icons.attach_money_rounded),
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(100)

                       ),
                     ),
                     Text('Plafond Collecte', style: GoogleFonts.acme(
                         fontSize: 18
                     ),),
                     Text('165 600 000', style: GoogleFonts.acme(
                         fontSize: 18
                     ),),
                     Text('XAF', style: GoogleFonts.adamina(
                         fontSize: 16
                     ),),
                   ],
                 ),
               ),
             ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 5),
                height: 150,
                width: (MediaQuery.of(context).size.width - 50)/2,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 80),
                      height: 50,
                      width: 50,

                      child: const Icon(Icons.person_add),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)

                      ),
                    ),
                    Text('Nouveaux Enrollés', style: GoogleFonts.acme(
                        fontSize: 18
                    ),),
                    Text('100', style: GoogleFonts.acme(
                        fontSize: 18
                    ),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, left: 5),
                height: 150,
                width: (MediaQuery.of(context).size.width - 50)/2,
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 80),
                      height: 50,
                      width: 50,

                      child: Image.asset("assets/newIcons/ic_document.png", scale: 3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)

                      ),
                    ),
                    Text('Souscriptions', style: GoogleFonts.acme(
                        fontSize: 18
                    ),),
                    Text('16', style: GoogleFonts.abrilFatface(
                        fontSize: 18
                    ),),
                  ],
                ),
              ),

            ],

          ),
          const SizedBox(height: 10,),

              Container(
                margin: const EdgeInsets.only(left: 20),

                  child: const Text('Raccourcis', style: TextStyle(
                    fontSize: 20
                  ), )),

          const SizedBox(height: 20,),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                            margin: const EdgeInsets.only(top: 5, left: 5),
                            height: 40,
                            width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                borderRadius: BorderRadius.circular(10)
                              ),
                          ),
                          InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              height: 30,
                              width: 30,
                              child: Icon(Icons.add, color: Colors.green,),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Souscription()),
                              );
                            },
                          )
                          ],
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 5),
                            child: const Text('Souscription', style: TextStyle(
                              fontSize: 18
                            ),))
                      ],

                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 5, left: 5),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10, left: 10),
                                height: 30,
                                width: 30,
                                child: Icon(Icons.center_focus_weak,),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   Scanner(title: '',)),
                                );
                              },
                            )
                          ],
                        ),

                        Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: const Text('Scanner', style: TextStyle(
                                fontSize: 18
                            ),))
                      ],

                    ),

                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          // Row(
          //   children: [
          //     Container(
          //       margin: const EdgeInsets.only(left: 20),
          //       height: 50,
          //       width: 160,
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(10)),
          //       child: Column(
          //         children: [
          //           Row(
          //             children: [
          //               Stack(
          //                 children: [
          //                   Container(
          //                     margin: const EdgeInsets.only(top: 5, left: 5),
          //                     height: 40,
          //                     width: 40,
          //                     decoration: BoxDecoration(
          //                         color: Colors.indigoAccent,
          //                         borderRadius: BorderRadius.circular(10)
          //                     ),
          //                   ),
          //                   InkWell(
          //                     child: Container(
          //                       margin: const EdgeInsets.only(top: 10, left: 10),
          //                       height: 30,
          //                       width: 30,
          //                        child: Icon(Icons.center_focus_weak,),
          //                       decoration: BoxDecoration(
          //                           color: Colors.white,
          //                           borderRadius: BorderRadius.circular(100)
          //                       ),
          //                     ),
          //                     onTap: (){
          //                       Navigator.push(
          //                         context,
          //                         MaterialPageRoute(builder: (context) =>   Scanner(title: '',)),
          //                       );
          //                     },
          //                   )
          //                 ],
          //               ),
          //
          //               Container(
          //                   margin: const EdgeInsets.only(left: 5),
          //                   child: const Text('Scanner', style: TextStyle(
          //                       fontSize: 18
          //                   ),))
          //             ],
          //
          //           ),
          //
          //         ],
          //       ),
          //     ),
          //     // Row(
          //     //   children: [
          //     //     Stack(
          //     //       children: [
          //     //         Container(
          //     //           margin: const EdgeInsets.only(top: 5, left: 15),
          //     //           height: 40,
          //     //           width: 40,
          //     //           decoration: BoxDecoration(
          //     //               color: Colors.indigoAccent,
          //     //               borderRadius: BorderRadius.circular(10)
          //     //           ),
          //     //         ),
          //     //         InkWell(
          //     //           child: Container(
          //     //             margin: const EdgeInsets.only(top: 10, left: 20),
          //     //             height: 30,
          //     //             width: 30,
          //     //             child: Icon(Icons.money,),
          //     //             decoration: BoxDecoration(
          //     //                 color: Colors.white,
          //     //                 borderRadius: BorderRadius.circular(100)
          //     //             ),
          //     //           ),
          //     //           onTap: (){
          //     //             Navigator.push(
          //     //               context,
          //     //               MaterialPageRoute(builder: (context) =>   Scanner(title: '',)),
          //     //             );
          //     //           },
          //     //         )
          //     //       ],
          //     //     ),
          //     //
          //     //     Container(
          //     //         margin: const EdgeInsets.only(left: 5),
          //     //         child: const Text('Collecter', style: TextStyle(
          //     //             fontSize: 18
          //     //         ),))
          //     //   ],
          //     //
          //     // )
          //   ],
          // )

        ]
      ),

    );
  }
}
