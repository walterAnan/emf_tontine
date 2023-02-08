
import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/data/models/client_particulier.dart';
import 'package:emf_tontine/presentation/screens/profileClients.dart';
import 'package:emf_tontine/presentation/screens/scanne.dart';
import 'package:emf_tontine/presentation/screens/souscrire.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detailsClients.dart';
class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  final List<int> colorCodes = <int>[600, 500, 100];
  TextEditingController text = TextEditingController();
  bool affiche = false;
  bool isLoading = true;
  int elmt = -1;

  final List<dynamic> _mesclients = [];



  getPersonnes() async {
    List<dynamic> list = await getClientParticulier();
    if(list != null){
      for(int i = 0; i< list.length; i++){
        print(list[i]);
        _mesclients.add(list[i]);
      }
      setState(() {
        isLoading = false;
      });
    }else{
      print('Le retour est nul');
    }

  }

  List<dynamic> _clientTrouve = [];
  @override
  initState() {
    getPersonnes();
    _clientTrouve = _mesclients;
    super.initState();
  }
  // This function is called whenever the text field changes
  void _runFilter(String entree) {
    List<dynamic> results = [];
    if (entree.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _mesclients;
      print('je suis dans le if $results');
    } else {
      results = _mesclients
          .where((user) =>
          user["personne"]['nomComplet'].toLowerCase().contains(entree.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    print('je suis dans le else $results');
    setState(() {
      _clientTrouve = results;
    });

  }

  //
  // void Rechercher(String entree) {
  //   List<String> results = [];
  //   results.addAll(_entries);
  //   if (entree.isNotEmpty) {
  //     List<String> dummyListData = <String>[];
  //     results.forEach((item) {
  //       if(item.contains(entree)) {
  //         dummyListData.add(item);
  //       }
  //     });
  //     setState(() {
  //       _clientTrouve.clear();
  //       _clientTrouve.addAll(dummyListData);
  //     });
  //     return;
  //   } else {
  //
  //     setState(() {
  //       _clientTrouve.clear();
  //       _clientTrouve.addAll(_entries);
  //     });
  //   }
  //
  //
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _clientTrouve = _entries;
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {

    var hauteur = MediaQuery.of(context).size.height;
    var largeur = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4a9e04),
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text('La Liste des Clients', style: GoogleFonts.acme(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                   color: Colors.white
                )
              ),
              Container(height: 20,)
            ],
          ),
        ),
        actions: const [
          // Container(
          //   margin: const EdgeInsets.only(right: 20),
          //   child: InkWell(
          //     // child: Icon(Icons.person_add, color: Colors.blue, size: 36,),
          //     onTap: (){},
          //     ),
          // ),

        ],
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()):
      Column(
        children: [
          const SizedBox(height: 10,),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: TextField(
                onChanged: (value){
                  // Rechercher(value);
                  _runFilter(value);
                },
                controller: text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff4a9e04), width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Rechercher',

                ),
              ),
            ),
          ),

        const SizedBox(height: 10,),
          Expanded(child: ListView.separated(
              padding: const EdgeInsets.all(5),
              itemCount: _clientTrouve.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  children: [
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey
                                    ),
                                    image: const DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage("assets/newIcons/ic_newProfile.png")
                                    ))
                              ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Text('Marc', style: TextStyle(fontWeight: FontWeight.w700),),
                                Center(child: Text(_clientTrouve[index]['personne']['nomComplet'].toString())),
                                Text(_clientTrouve[index]['personne']['adresse']['telephone'].toString(), style: const TextStyle(fontWeight: FontWeight.w700),),
                              ],
                            ),
                          )
                        ]
                           ),
                      ),
                      onTap: (){
                        setState(() {
                          affiche = !affiche;
                          elmt = index;
                        });

                      }
                    ),
                    if(affiche == true && elmt == index)
                      Container(
                        margin: const EdgeInsets.only(left: 70),
                      height: 50,
                      color: Colors.grey.shade50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          InkWell(
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                ),
                                child: const FaIcon(FontAwesomeIcons.moneyBill), ),
                            onTap: (){
                              setState(() {
                                affiche = !affiche;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileClient(),
                                    settings: RouteSettings(arguments: _clientTrouve[index]['personne']['nomComplet'])));
                              });

                            },
                          ),
                          InkWell(
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(Icons.production_quantity_limits_outlined)),
                            onTap: (){
                              setState(() {
                                affiche = !affiche;
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Souscrire(),
                                  settings: RouteSettings(arguments: _mesclients[index]['personne']['nomComplet'])));
                            },
                          ),

                          InkWell(
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),

                                ),
                                child: const Icon(Icons.more_horiz,)),
                            onTap: (){
                              setState(() {
                                affiche = !affiche;
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsClients(),
                                  settings: RouteSettings(arguments: _mesclients[index]['personne']['nomComplet'])));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                );


              },
              separatorBuilder: (BuildContext context, int index) => const Divider()
              ),
          ),
          const SizedBox(height: 5,)
        ],

      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child:FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>   const Scanner(title: '',)));
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff4a9e04),
      ),
    ));
  }
}
