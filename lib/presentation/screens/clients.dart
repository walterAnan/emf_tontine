
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
  // List<String> _entries = <String>['Premier Client', 'Deuxième Client', 'Troisième Client','Premier Client', 'Deuxième Client', 'Troisième Client', 'Premier Client', 'Deuxième Client', 'Troisième Client', 'Premier Client', 'Deuxième Client', 'Troisième Client'];
  // List<String> _clientTrouve = <String>[];
  final List<int> colorCodes = <int>[600, 500, 100];
  TextEditingController text = TextEditingController();
  bool affiche = false;
  int elmt = -1;


  final List<Map<String, dynamic>> _clients = [
  {"id": 1, "name": "Andy", "age": 29},
  {"id": 2, "name": "Aragon", "age": 40},
  {"id": 3, "name": "Bob", "age": 5},
  {"id": 4, "name": "Barbara", "age": 35},
  {"id": 5, "name": "Candy", "age": 21},
  {"id": 6, "name": "Colin", "age": 55},
  {"id": 7, "name": "Audra", "age": 30},
  {"id": 8, "name": "Banana", "age": 14},
  {"id": 9, "name": "Caversky", "age": 100},
  {"id": 10, "name": "Becky", "age": 32},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _clientTrouve = [];
  @override
  initState() {

    _clientTrouve = _clients;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String entree) {
    List<Map<String, dynamic>> results = [];
    if (entree.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _clients;
      print('je suis dans le if $results');
    } else {
      results = _clients
          .where((user) =>
          user["name"].toLowerCase().contains(entree.toLowerCase()))
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
          child: Text('La Liste des Clients', style: GoogleFonts.sacramento(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
               color: Colors.black
            )
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
      body: Column(
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
                                Center(child: Text(_clientTrouve[index]['name'].toString())),
                                Text(_clientTrouve[index]['age'].toString(), style: const TextStyle(fontWeight: FontWeight.w700),),
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
                                    settings: RouteSettings(arguments: _clientTrouve[index]['name'])));
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
                                  settings: RouteSettings(arguments: _clients[index]['name'])));
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
                                  settings: RouteSettings(arguments: _clients[index]['name'])));
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
