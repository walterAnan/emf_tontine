

import 'package:emf_tontine/data/colors/colors.dart';
import 'package:emf_tontine/presentation/screens/nav_bar_menu.dart';
import 'package:emf_tontine/presentation/screens/scanne.dart';
import 'package:emf_tontine/presentation/screens/versement.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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
    var ht = MediaQuery.of(context).size.height;
    var wt = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(title: "Home",),
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(

        children: [
          Container(
            height: 40,
            color: Color(0xff4a9e04),
          ),
          Row(
            children: [
              Container(
                // margin: const EdgeInsets.only(top: 50, left: 20),
                child:   IconButton(onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                }, icon: const Icon(Icons.menu, color: Color(0xff4a9e04),),),
              ),

            Expanded(child: Container(
              margin: const EdgeInsets.only(left: 30),
                child: const Text('TONTINE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xff4a9e04)),)),),
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
                       color: const Color(0xff1DCD9D),
                       borderRadius: BorderRadius.circular(10),
                         // boxShadow: [
                         //   BoxShadow(
                         //     color: Colors.grey.withOpacity(0.5),
                         //     spreadRadius: 5,
                         //     blurRadius: 7,
                         //     offset: Offset(0, 3), // changes position of shadow
                         //   ),
                         // ]
                     ),
                     child: Column(
                       children: [
                         Row(
                           children: [
                             Container(
                               margin: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                               height: 50,
                               width: 50,

                               child: const Icon(Icons.account_balance, color:Color(0xff1DCD9D)),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(100),
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.grey.withOpacity(0.5),
                                       spreadRadius: 5,
                                       blurRadius: 7,
                                       offset: const Offset(0, 3), // changes position of shadow
                                     ),
                                   ]

                               ),
                             ),
                           ],
                         ),
                         Text('Montant Collecté', style: GoogleFonts.acme(
                             fontSize: 15,
                             color: const Color(0xffFFFFFF)
                         ),),
                         Text('165 600 000', style: GoogleFonts.acme(
                             fontSize: 20,
                           color: const Color(0xffFFFFFF)
                         ),),
                         Text('XAF', style: GoogleFonts.acme(
                             fontSize: 18,
                             color: const Color(0xffFFFFFF)
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
                   color: const Color(0xff456EFB),
                   borderRadius: BorderRadius.circular(10),
                     // boxShadow: [
                     //   BoxShadow(
                     //     color: Colors.grey.withOpacity(0.5),
                     //     spreadRadius: 5,
                     //     blurRadius: 7,
                     //     offset: Offset(0, 3), // changes position of shadow
                     //   ),
                     // ]
                 ),
                 child: Column(
                   children: [
                     Container(
                       margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 80),
                       height: 45,
                       width: 45,

                       child: const Icon(Icons.attach_money_rounded, color: Color(0xff456EFB),),
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(100)

                       ),
                     ),
                     Text('Plafond Collecte', style: GoogleFonts.acme(
                         fontSize: 18,
                       color: const Color(0xffFFFFFF)
                     ),),
                     Text('165 600 000', style: GoogleFonts.acme(
                         fontSize: 18,
                       color: const Color(0xffFFFFFF)
                     ),),
                     Text('XAF', style: GoogleFonts.adamina(
                         fontSize: 16,
                         color: const Color(0xffFFFFFF)
                     ),),
                   ],
                 ),
               ),
             ],
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 5),
                height: 150,
                width: (MediaQuery.of(context).size.width - 50)/2,
                decoration: BoxDecoration(
                  color: const Color(0xffFF6850),
                  borderRadius: BorderRadius.circular(10),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 5,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 3), // changes position of shadow
                    //   ),
                    // ]
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 80),
                      height: 50,
                      width: 50,

                      child: const Icon(Icons.person_add, color: Color(0xffFF6850),),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)

                      ),
                    ),
                    Text('Nouveaux Enrollés', style: GoogleFonts.acme(
                        fontSize: 18,
                      color: const Color(0xffFFFFFF)
                    ),),
                    Text('100', style: GoogleFonts.acme(
                        fontSize: 18,
                      color: const Color(0xffFFFFFF)
                    ),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, left: 5),
                height: 150,
                width: (MediaQuery.of(context).size.width - 50)/2,
                decoration: BoxDecoration(
                  color: const Color(0xffFFA11F),
                  borderRadius: BorderRadius.circular(10),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 5,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 3), // changes position of shadow
                    //   ),
                    // ]
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 80),
                      height: 50,
                      width: 50,

                      child: Image.asset("assets/newIcons/ic_document.png", scale: 3, color: const Color(0xffFFA11F),),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)

                      ),
                    ),
                    Text('Souscriptions', style: GoogleFonts.acme(
                        fontSize: 18,
                      color: const Color(0xffFFFFFF)
                    ),),
                    Text('16', style: GoogleFonts.abrilFatface(
                        fontSize: 18,
                      color: const Color(0xffFFFFFF)
                    ),),
                  ],
                ),
              ),

            ],

          ),
          const SizedBox(height: 15,),

              Container(
                margin: const EdgeInsets.only(left: 20),

                  child: const Text('Raccourcis', style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff4a9e04)
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
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10, left: 10),
                                height: 30,
                                width: 30,
                                child: const Center(child: FaIcon(FontAwesomeIcons.moneyBill, color: Colors.green,)),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  Versement()),
                                );
                              },
                            )
                          ],
                        ),

                        Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: const Text('Versement', style: TextStyle(
                                fontSize: 18
                            ),))
                      ],

                    ),

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
                                  color: const Color(0xffFFA11F),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10, left: 10),
                                height: 30,
                                width: 30,
                                child: const Icon(Icons.center_focus_weak, color: Color(0xff4a9e04),),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                              ),
                              onTap: (){
                                print('les dimensions :'+ wt.toString() + ht.toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>   const Scanner(title: '',)),
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

          const SizedBox(height: 5,),
          Row(
            children: [

              // Row(
              //   children: [
              //     Stack(
              //       children: [
              //         Container(
              //           margin: const EdgeInsets.only(top: 5, left: 15),
              //           height: 40,
              //           width: 40,
              //           decoration: BoxDecoration(
              //               color: Colors.indigoAccent,
              //               borderRadius: BorderRadius.circular(10)
              //           ),
              //         ),
              //         InkWell(
              //           child: Container(
              //             margin: const EdgeInsets.only(top: 10, left: 20),
              //             height: 30,
              //             width: 30,
              //             child: Icon(Icons.money,),
              //             decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 borderRadius: BorderRadius.circular(100)
              //             ),
              //           ),
              //           onTap: (){
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(builder: (context) =>   Scanner(title: '',)),
              //             );
              //           },
              //         )
              //       ],
              //     ),
              //
              //     Container(
              //         margin: const EdgeInsets.only(left: 5),
              //         child: const Text('Collecter', style: TextStyle(
              //             fontSize: 18
              //         ),))
              //   ],
              //
              // )
            ],
          )

        ]
      ),

    );
  }
}
