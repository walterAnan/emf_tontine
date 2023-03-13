
import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/data/models/client_particulier.dart';
import 'package:emf_tontine/presentation/screens/profileClients.dart';
import 'package:emf_tontine/presentation/screens/scanne.dart';
import 'package:emf_tontine/presentation/screens/souscrire.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detailsClients.dart';
class ClientsM extends StatefulWidget {
  const ClientsM({Key? key}) : super(key: key);

  @override
  State<ClientsM> createState() => _ClientsMState();
}

class _ClientsMState extends State<ClientsM> {
  final List<int> colorCodes = <int>[600, 500, 100];
  TextEditingController text = TextEditingController();
  bool affiche = false;
  bool isLoading = true;
  int elmt = -1;

  final List<dynamic> _mesclients = [];



  getPersonnes() async {
    List<dynamic> list = await getClientMoral(context);
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
                Text('Mes Clients Entréprises', style: GoogleFonts.acme(
                    fontSize: 26,
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
            Expanded(child: GridView.builder(
              primary: false,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 4.0,
                crossAxisCount: 2,

              ),
              itemCount: _clientTrouve.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> personne = _clientTrouve[index];
                return _buildCard(context, _clientTrouve[index]['personne']['nomComplet'].toString(), 'Available',_clientTrouve.length, personne);
              },
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
                  MaterialPageRoute(builder: (context) =>   const Scanner(title: '',),
                  settings: const RouteSettings(arguments: 'nouveau')));
            },
            child: const Icon(Icons.add),
            backgroundColor: const Color(0xff4a9e04),
          ),
        ));
  }
}


Widget _buildCard(BuildContext context, String name, String Image, int cardIndex, Map<String, dynamic> personne) {
  return InkWell(
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          elevation: 7.0,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 12.0),
              Stack(
                  children: <Widget>[
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff4a9e04),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                // 'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'
                                'https://noonecares.me/wp-content/uploads/2019/04/20190111162956-jessica-alba.jpeg',
                              )
                          )
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left:45.0),
                      height: 15.0,
                      width: 15.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          // color: status == 'Away' ? Colors.amber : Colors.green,
                          color: Color(0xff4a9e04),
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1.0
                          )
                      ),
                    )
                  ]),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  personne['personne']['nomComplet'],
                  style: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
              ),
              // Center(
              //   child: Text(
              //     personne['personne']['nomComplet'],
              //     style: TextStyle(
              //       fontFamily: 'Quicksand',
              //       fontWeight: FontWeight.w300,
              //       fontSize: 12.0,
              //     ),
              //   ),
              // ),
              SizedBox(height: 5.0),
              Text(
                personne['personne']['adresse']['telephone'] ?? 'Pas de telephone',
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.grey
                ),
              ),
              SizedBox(height: 15.0),
              Expanded(
                  child: Container(
                      width: 175.0,
                      decoration: BoxDecoration(
                        // color: status == 'Away' ? Colors.grey: Colors.green,
                        color: Colors.green,
                        borderRadius: BorderRadius.only
                          (
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)
                        ),
                      ),
                      child: Center(
                        child: Text('Détails',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Quicksand'
                          ),
                        ),
                      )
                  )
              )
            ],
          ),
          margin: cardIndex.isEven? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0):EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0)
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DetailsClients(),
                settings: RouteSettings(
                    arguments: personne)));
      });
}
