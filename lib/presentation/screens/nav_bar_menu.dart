
import 'package:emf_tontine/presentation/screens/changerMDP.dart';
import 'package:emf_tontine/presentation/screens/clients.dart';
import 'package:emf_tontine/presentation/screens/clients_moral.dart';
import 'package:emf_tontine/presentation/screens/historique.dart';
import 'package:emf_tontine/presentation/screens/loginPage.dart';
import 'package:emf_tontine/presentation/screens/mes_produits.dart';
import 'package:emf_tontine/presentation/screens/payement.dart';
import 'package:emf_tontine/presentation/screens/profile.dart';
import 'package:emf_tontine/presentation/screens/registerClient.dart';
import 'package:emf_tontine/presentation/screens/scanne.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyDrawer extends StatefulWidget {
  String title;
  MyDrawer({Key? key, required this.title}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState(title: title);
}

class _MyDrawerState extends State<MyDrawer> {
  String title;
  _MyDrawerState({required this.title});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.7,
      child: Drawer(
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              // const SizedBox(height: 0,),
              //Profile Scetion
              InkWell(
                onTap: () {
                  if (title == "Profile") {
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    // Navigator.of(context).push(
                    //     SlidePageRoute(page: Profile()));
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 140,
                  color: Color(0xff4a9e04),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      //Prof Img
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1,
                                color: Colors.grey
                            ),
                            image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/newIcons/ic_newProfile.png")
                            )
                        ),
                        child: Stack(
                          children: [
                            Positioned.directional(
                              textDirection: Directionality.of(context),
                              end: 1.5,
                              bottom: 1,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey
                                    ),
                                    color: Colors.grey,
                                    shape: BoxShape.circle
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(width: 10,),
                      //Prof Name
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 70,),
                            Container(
                              child: const Text("Marc",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'medium',
                                  color: Colors.white
                                ),),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: const Text("Hors line",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'medium'
                                    ),),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              //items
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        //Home
                        InkWell(
                          onTap: (){
                            if(title=="Home"){
                              Navigator.pop(context);
                            }else {
                              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              //     // builder: (context) => MyOrders()
                              // ), (route) => false);
                            }
                          },
                          child: Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.account_balance, color: Colors.black45,),
                                // Image.asset("assets/newIcons/ic_home.png",scale: 5,
                                //   color: Theme.of(context).iconTheme.color,),
                                SizedBox(width: 8,),
                                Container(
                                  child: const Text("Tableau de bord",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),
                        //My profile
                        InkWell(
                          onTap: (){
                            if(title=="Profile"){
                              Navigator.pop(context);
                            }else {
                              Navigator.pop(context);
                              // Navigator.of(context).push(SlidePageRoute(page: Profile()));
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                            }
                          },
                          child: Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/newIcons/ic_profile.png",scale: 5,
                                  color: Colors.black45,),
                                const SizedBox(width: 8,),
                                Container(
                                  child: const Text("Mon Profile",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),

                        //Documents
                        InkWell(
                          onTap: (){
                            if(title=="Client"){
                              Navigator.pop(context);
                            }else {
                              Navigator.pop(context);
                              Navigator.push(context,MaterialPageRoute(builder: (context) => const Scanner(title: 'title'),
                              settings: const RouteSettings(arguments: 'nouveau0')));
                            }
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.person_add, color: Colors.black45,),
                                const SizedBox(width: 8,),
                                Container(
                                  child: const Text("Nouveau Client",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                        color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),

                      //payement
                        InkWell(
                          onTap: (){
                            if(title=="Client"){
                              Navigator.pop(context);
                            }else {
                              Navigator.pop(context);
                              Navigator.push(context,MaterialPageRoute(builder: (context) => const Payement(),
                                  ));
                            }
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                const FaIcon(FontAwesomeIcons.moneyBill, color: Colors.grey,),
                                const SizedBox(width: 8,),
                                Container(
                                  child: const Text("Payement d'un client",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),

                        //Liste de clients

                        InkWell(
                          onTap: (){
                            if(title=="Clients"){
                              Navigator.pop(context);
                            }else {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Clients()));
                            }
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.person, color: Colors.black45,),
                                SizedBox(width: 8,),
                                Container(
                                  child: const Text("Mes clients particuliers",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                        color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            if(title=="Tous les Clients"){
                              Navigator.pop(context);
                            }else {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Clients()));
                            }
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.person, color: Colors.black45,),
                                SizedBox(width: 8,),
                                Container(
                                  child: const Text("Tous les particuliers",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),


                        InkWell(
                          onTap: (){
                            if(title=="Clients"){
                              Navigator.pop(context);
                            }else {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Clients()));
                            }
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.person, color: Colors.black45,),
                                SizedBox(width: 8,),
                                Container(
                                  child: const Text("Mes entréprise",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            if(title=="ClientR"){
                              Navigator.pop(context);
                            }else {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ClientsM()));
                            }
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.person, color: Colors.black45,),
                                SizedBox(width: 8,),
                                Container(
                                  child: const Text("Toutes les entréprises",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            if(title=="Mes produits"){
                              Navigator.pop(context);
                            }else {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Produits()));
                            }
                          },
                          child: Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.production_quantity_limits_outlined, color: Colors.black45,),
                                SizedBox(width: 8,),
                                Container(
                                  child: const Text("Mes produits",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),
                        //Clients avec du retard de cotissation

                        //History
                        InkWell(
                          onTap: (){
                            if(title=="History"){
                              Navigator.pop(context);
                            }else {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const HistoriqueCollecte()));
                            }
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Colors.green,
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/newIcons/ic_history.png",scale: 5,
                                  color: Colors.black45,),
                                SizedBox(width: 8,),
                                Container(
                                  child: const Text("Historique",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),
                        //Setting
                        InkWell(
                          onTap: (){
                            if(title=="Setting"){
                              Navigator.pop(context);
                            }else {
                              Navigator.push(context, MaterialPageRoute( builder: (context) => const ChangerMDP(),
                              ));
                              // Navigator.pop(context);
                              // Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: ChangerMDP()));
                            }
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/newIcons/ic_setting.png",scale: 5,
                                  color: Colors.black45,),
                                SizedBox(width: 8,),
                                Container(
                                  child: const Text("Changer mot de passe",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'medium',
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),
                        //Logout
                        InkWell(
                          onTap: (){
                            _logout(context);
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xff4a9e04),
                                    )
                                )
                            ),
                            child: Row(
                              children: [
                                Image.asset("assets/newIcons/ic_logout.png",scale: 5,
                                  color: Colors.black45,),
                                const SizedBox(width: 8,),
                                Container(
                                  child: const Text("Deconnexion",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'medium',
                                      color: Colors.black,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Version

              SizedBox(height: 20,),
              Container(
                  padding: EdgeInsets.only(bottom: 25),
                  alignment: Alignment.bottomCenter,
                  child: const Text("V 1.0",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'medium',
                      color: Colors.grey,
                    ),),
                ),

            ],
          ),
        ),
      ),
    );
  }

  //Logout dialouge
static void _logout(context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx){
        return   Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2)
          ),
          child: Container(
            height: 95,
            padding: EdgeInsets.only(left: 20,right: 16,top: 15,bottom: 9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("Voulez-vous vous deconnecter?",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "medium",
                      color: Colors.grey,
                    ),),
                ) ,
                //CANCEL AND LOGOUT BUTTON
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: const Text("Annuler",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontFamily: "medium"
                            ),),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context)=>LoginPage()
                          ), (route) => false);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text("Déconnecter",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontFamily: "medium"
                            ),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
