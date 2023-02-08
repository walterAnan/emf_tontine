

import 'dart:io';

import 'package:emf_tontine/data/models/cotisation.dart';
import 'package:emf_tontine/presentation/screens/loginPage.dart';
import 'package:emf_tontine/presentation/screens/versementChart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool changerImage = false;

  late XFile _image = XFile('assets/images/profile_photo.png');
  _getFrom(source) async {
    var pickedFile = (await ImagePicker().pickImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    ));
    if (pickedFile != null) {
       setState(() {
         print('je suis ici ');
         _image = pickedFile ;
         changerImage = true;
         print('je suis image $_image');
       });
    }
  }

  void sauvegarde(lien) async {
    SharedPreferences imageSauvergarder = await SharedPreferences.getInstance();
    imageSauvergarder.setString('imageS', lien);
  }

  final List<Cotisation> data = [
    Cotisation(
      jour: "Janvier",
      montant: 40000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    Cotisation(
      jour: "Juin",
      montant: 50000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    Cotisation(
      jour: "Juillet",
      montant: 60000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    Cotisation(
      jour: "Août",
      montant: 30000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    Cotisation(
      jour: "Septembre",
      montant: 100000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          Container(
            color: const Color(0xff4a9e04),
            padding: const EdgeInsets.only(top: 35),
            height: height*0.101,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white, size: 30,)),
                Text('Profile',style:GoogleFonts.abhayaLibre(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    // fontStyle: FontStyle.italic,
                    color: Colors.white
                )),

                IconButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                }, icon: const Icon(Icons.logout, color: Colors.white, size: 30,)),

              ],
            ),

          ),
          Container(
            height: height*0.22,
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [

                    Container(
                      padding: const EdgeInsets.all(4),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(75),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: (!changerImage)?Image.network(
                            'https://relayeur.files.wordpress.com/2015/05/d7cb2e4a29656d1a73663685bca6732d.jpeg?w=620'):Image(image: FileImage(File(_image.path))),
                      ),
                    ),
                      Positioned(
                        bottom: 4,
                          right: 0,
                          left: 40,
                          child: ClipOval(
                            child: Container(
                              height: 40,
                              width: 40,
                              color: const Color(0xff4a9e04),
                              child: IconButton(icon: const Icon(Icons.add_a_photo_outlined, color: Colors.white,),
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 100,
                                        color: Colors.white,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ElevatedButton(
                                                child: const Text('Galery'),
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff4a9e04)),),
                                                onPressed: () => _getFrom(ImageSource.gallery),
                                              ),

                                              ElevatedButton(
                                                child: const Text('Camera'),
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff4a9e04)),),
                                                onPressed: () => _getFrom(ImageSource.camera),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },),
                            ),

                          )
                      )]),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 5,),
                   child: Text('Marc', style:GoogleFonts.abhayaLibre(
                       fontSize: 28,
                       fontWeight: FontWeight.w700,
                       // fontStyle: FontStyle.italic,
                       color: Colors.black
                   ),),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 2,),
                    child: Text('marc@gmail.com', style:GoogleFonts.hanuman(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        color: Colors.black
                    ),),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 1,
                  color: Colors.blueGrey,
                ),
              ],

            ),
          ),
          const SizedBox(height: 5,),
          Center(
            child: Column(
              children: [
                Text('1.000.000', style: GoogleFonts.hanuman(
                    fontWeight: FontWeight.w700, color: Colors.red
                ),),
                const Text('Plafond')
              ],
            ),
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  height: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('10', style: GoogleFonts.hanuman(
                        fontWeight: FontWeight.w700
                      ),),
                      const Text('Clients'),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('500.000',  style: GoogleFonts.hanuman(
                      fontWeight: FontWeight.w700)),
                      const Text('Cotisations'),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('15',  style: GoogleFonts.hanuman(
                          fontWeight: FontWeight.w700)),
                      const Text('Souscriptions'),
                    ],
                  ),
                ),

                // Container(
                //   margin: EdgeInsets.only(right: 20),
                //   height: 70,
                //   width: width*0.40,
                //   color: Colors.green,
                // ),
                // Container(
                //   margin: EdgeInsets.only(right: 20),
                //   height: 70,
                //   width: width*0.25,
                //   color: Colors.deepPurpleAccent,
                // )
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                const Center(child: Text('Evolution mensuelle de mes collectes (xaf)')),
                Container(
                  width: width,
                  height: height*0.35,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: VersementChart(
                    data: data,
                  ),
                ),
              ],
            ),
          ),
          //     child: Container(
          //   margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          //   decoration: const BoxDecoration(
          //       color: Colors.white,
          //     borderRadius: BorderRadius.vertical(top: Radius.circular(20))
          //   ),
          //   child: Column(
          //         children: [
          //           InkWell(
          //             onTap: (){
          //
          //             },
          //             child: Row(
          //               children: [
          //                 Container(
          //                   margin: const EdgeInsets.only(top: 20, left: 20),
          //                   height: 50,
          //                   width: 50,
          //                   decoration: BoxDecoration(
          //                     color: Colors.grey.shade200,
          //                     borderRadius: BorderRadius.circular(10)
          //                   ),
          //                   child: const Icon(Icons.settings),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(top: 20, left: 20, right: 80),
          //                   child: const Text('Paramétrages'),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(top: 20, left: 20),
          //                   child: const Icon(Icons.arrow_forward_ios_outlined),
          //                 )
          //               ],
          //             ),
          //           ),
          //           InkWell(
          //             onTap: (){
          //
          //             },
          //             child: Row(
          //               children: [
          //                 Container(
          //                   margin: const EdgeInsets.only(top: 20, left: 20),
          //                   height: 50,
          //                   width: 50,
          //                   decoration: BoxDecoration(
          //                       color: Colors.grey.shade200,
          //                       borderRadius: BorderRadius.circular(10)
          //                   ),
          //                   child: const Icon(Icons.info_rounded),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(top: 20, left: 20, right: 50),
          //                   child: const Text('Plus d\'informations'),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(top: 20, left: 20),
          //                   child: const Icon(Icons.arrow_forward_ios_outlined),
          //                 )
          //               ],
          //             ),
          //           ),
          //           InkWell(
          //             onTap: (){
          //
          //             },
          //             child: Row(
          //               children: [
          //                 Container(
          //                   margin: const EdgeInsets.only(top: 20, left: 20),
          //                   height: 50,
          //                   width: 50,
          //                   decoration: BoxDecoration(
          //                       color: Colors.grey.shade200,
          //                       borderRadius: BorderRadius.circular(10)
          //                   ),
          //                   child: const Icon(Icons.logout),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(top: 20, left: 20, right: 80),
          //                   child: const Text('Deconnexion'),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(top: 20, left: 20),
          //                   child: const Icon(Icons.arrow_forward_ios_outlined),
          //                 )
          //               ],
          //             ),
          //           ),
          //           // Row(
          //           //   children: [
          //           //     Container(
          //           //       margin: EdgeInsets.only(top: 20, left: 20),
          //           //       height: 50,
          //           //       width: 50,
          //           //       decoration: BoxDecoration(
          //           //           color: Colors.grey.shade200,
          //           //           borderRadius: BorderRadius.circular(10)
          //           //       ),
          //           //       child: Icon(Icons.settings),
          //           //     ),
          //           //     Container(
          //           //       margin: EdgeInsets.only(top: 20, left: 20, right: 80),
          //           //       child: Text('Paramétrages'),
          //           //     ),
          //           //     Container(
          //           //       margin: EdgeInsets.only(top: 20, left: 20),
          //           //       child: IconButton(icon: const Icon(Icons.arrow_forward_ios_outlined), onPressed: (){
          //           //
          //           //       }, ),
          //           //     )
          //           //   ],
          //           // )
          //         ],
          //   ),
           )
        ],
      ),
      // fit: StackFit.expand,
      // children: [
      //   Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [
      //           Color.fromRGBO(4, 9, 35, 1),
      //           Color.fromRGBO(39, 105, 171, 1),
      //         ],
      //         begin: FractionalOffset.bottomCenter,
      //         end: FractionalOffset.topCenter,
      //       ),
      //     ),
      //   ),
      //   Scaffold(
      //     backgroundColor: Colors.transparent,
      //     body: SingleChildScrollView(
      //       physics: const BouncingScrollPhysics(),
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
      //         child: Column(
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 InkWell(
      //                   child: const Icon(
      //                     AntDesign.arrowleft,
      //                     color: Colors.white,
      //                   ),
      //                   onTap: (){
      //                     Navigator.pop(context);
      //                   },
      //                 ),
      //                 // const Icon(
      //                 //   AntDesign.logout,
      //                 //   color: Colors.white,
      //                 // ),
      //               ],
      //             ),
      //             const SizedBox(
      //               height: 5,
      //             ),
      //             const Text(
      //               'Mon\nProfile',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 34,
      //                 fontFamily: 'Nisebuschgardens',
      //               ),
      //             ),
      //             Container(
      //               height: height * 0.4,
      //               child: LayoutBuilder(
      //                 builder: (context, constraints) {
      //                   double innerHeight = constraints.maxHeight;
      //                   double innerWidth = constraints.maxWidth;
      //                   return Stack(
      //                     fit: StackFit.expand,
      //                     children: [
      //                       Positioned(
      //                         bottom: 0,
      //                         left: 0,
      //                         right: 0,
      //                         child: Container(
      //                           height: innerHeight*0.9,
      //                           width: innerWidth,
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(20),
      //                             color: Colors.white,
      //                           ),
      //                           child: Column(
      //                             children: [
      //                               const SizedBox(
      //                                 height: 50,
      //                               ),
      //                               const Text(
      //                                 'Marc',
      //                                 style: TextStyle(
      //                                   color: Color.fromRGBO(39, 105, 171, 1),
      //                                   fontFamily: 'Nunito',
      //                                   fontSize: 27,
      //                                 ),
      //                               ),
      //                               const SizedBox(
      //                                 height: 5,
      //                               ),
      //                               Row(
      //                                 mainAxisAlignment:
      //                                 MainAxisAlignment.center,
      //                                 children: [
      //                                   Column(
      //                                     children: [
      //                                       Text(
      //                                         'Portefeuille',
      //                                         style: TextStyle(
      //                                           color: Colors.grey[700],
      //                                           fontFamily: 'Nunito',
      //                                           fontSize: 25,
      //                                         ),
      //                                       ),
      //                                       const Text(
      //                                         '10',
      //                                         style: TextStyle(
      //                                           color: Color.fromRGBO(
      //                                               39, 105, 171, 1),
      //                                           fontFamily: 'Nunito',
      //                                           fontSize: 25,
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                   Padding(
      //                                     padding: const EdgeInsets.symmetric(
      //                                       horizontal: 25,
      //                                       vertical: 8,
      //                                     ),
      //                                     child: Container(
      //                                       height: 50,
      //                                       width: 3,
      //                                       decoration: BoxDecoration(
      //                                         borderRadius:
      //                                         BorderRadius.circular(100),
      //                                         color: Colors.grey,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                   Column(
      //                                     children: [
      //                                       Text(
      //                                         'Plafond',
      //                                         style: TextStyle(
      //                                           color: Colors.grey[700],
      //                                           fontFamily: 'Nunito',
      //                                           fontSize: 25,
      //                                         ),
      //                                       ),
      //                                       const Text(
      //                                         '165 000 000',
      //                                         style: TextStyle(
      //                                           color: Color.fromRGBO(
      //                                               39, 105, 171, 1),
      //                                           fontFamily: 'Nunito',
      //                                           fontSize: 25,
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ],
      //                               )
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       // Positioned(
      //                       //   top: 110,
      //                       //   right: 20,
      //                       //   child: Icon(
      //                       //     // AntDesign.setting,
      //                       //     color: Colors.grey[700],
      //                       //     size: 30,
      //                       //   ),
      //                       // ),
      //                       Positioned(
      //                         top: 0,
      //                         left: 0,
      //                         right: 0,
      //                         child: Center(
      //                           child: Container(
      //                             child: Image.asset(
      //                               'assets/images/profile_photo.png',
      //                               width: innerWidth * 0.25,
      //                               fit: BoxFit.fitWidth,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   );
      //                 },
      //               ),
      //             ),
      //             // const SizedBox(
      //             //   height: 30,
      //             // ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   )
      // ],
    );
  }
}
