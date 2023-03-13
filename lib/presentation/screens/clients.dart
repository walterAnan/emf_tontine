
import 'dart:typed_data';

import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/presentation/screens/scanne.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'detailsClients.dart';
class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {

  final  _prefs = SharedPreferences.getInstance();

  final List<int> colorCodes = <int>[600, 500, 100];
  TextEditingController text = TextEditingController();
  bool affiche = false;
  bool isLoading = true;
  bool imageCharge= false;
  int elmt = -1;
  final String nouveau = 'nouveau';

  Uint8List image = Uint8List(1);
  List<String> listUuidImage = [];
  List<Uint8List> listImage = [];

  List<dynamic> produitsSouscrit = [];

  //list des clients
  final List<dynamic> _mesclients = [];
//liste des clients correspondants
  List<dynamic> _clientTrouve = [];
  // liste des produits souscrits
  List<dynamic> ps = [];

  getPersonnes() async {
    List<dynamic> list = await getClientParticulier(context);
    if(list != null){
      for(int i = 0; i< list.length; i++){
        print(list[i]);
        _mesclients.add(list[i]);
        produitsSouscrit.add(await getProdriutSousctionClient(context, list[i]['guid']));
      }
      setState(() {
        isLoading = false;
      });
      _clientTrouve = _mesclients;
      chargerPhoto();
    }else{
      print('Le retour est nul');
    }

  }


  void getPs(context, client)  async {
    var psouscrit = await getProdriutSousctionClient(context, client);
    if(psouscrit!=null){
      for(int i = 0; i<psouscrit.length; i ++){
        ps.add(psouscrit[i]);
      }
    }
    setState(() {
      isLoading = false;
    });

    print(isLoading);
  }


  Future<Uint8List> uploadImage(String uuid)async{
    String lienPiece = '$lienDev''piecejointe/retreive';

    final SharedPreferences prefs = await _prefs;
    var accessToken = prefs.getString('ACCESS_TOKEN_KEY');
    final response = await http.get( Uri.parse(lienPiece+'/$uuid'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken'});

    print('$uuid');
    if (response.statusCode == 200) {

      image = response.bodyBytes;
      return image;
    } else {
      print(response.body);
      return  response.bodyBytes;

    }


  }



  chargerPhoto() async {
    _clientTrouve = _mesclients;
      for(int i=0; i<_clientTrouve.length; i++){
        listUuidImage.add(_clientTrouve[i]['personne']['photo']);
        var uuidCourant = listUuidImage[i];
        if(uuidCourant != null && !(uuidCourant.toString() == '')) {
          listImage.add(await uploadImage(listUuidImage[i]));

        if(i==_clientTrouve.length-1){
          setState(() {
            imageCharge= true;
          });
        }


        } else{
          listImage.length++;

          if(i==_clientTrouve.length-1){
            setState(() {
              imageCharge= true;
            });
          }
        }

    }


  }

  @override
  initState() {
    getPersonnes();
    _clientTrouve = _mesclients;
    super.initState();
  }

  void _runFilter(String entree) {
    List<dynamic> results = [];
    if (entree.isEmpty) {
      results = _mesclients;
    } else {
      results = _mesclients
          .where((user) =>
          user["personne"]['nomComplet'].toLowerCase().contains(entree.toLowerCase()))
          .toList();
    }

    print('je suis dans le else $results');
    setState(() {
      _clientTrouve = results;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4a9e04),
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text('Mes Clients particuliers', style: GoogleFonts.acme(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                   color: Colors.white
                )
              ),
              Container(height: 20,)
            ],
          ),
        ),
        actions: const [

        ],
      ),
      body: (isLoading ||!imageCharge)? const Center(child: CircularProgressIndicator()):
      Column(
        children: [
          const SizedBox(height: 10,),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: TextField(
                onChanged: (value){
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
          Expanded(child:
              GridView.builder(
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
                 var ps = produitsSouscrit[index];
                 personne['produitsS'] = ps;
                  return _buildCard(context, _clientTrouve[index]['personne']['nomComplet'].toString(), listImage[index],_clientTrouve.length, personne);
                },
              )
              ),
         ]
          ),
          // _buildCard('Tom', 'Available', 1)


      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child:FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>   const Scanner(title: '',),
              settings: RouteSettings(arguments: nouveau)));
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff4a9e04),
      ),
    ));
  }
}



Widget _buildCard(BuildContext context, String name, Uint8List image, int cardIndex, Map<String, dynamic> personne) {
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
                  (image != null)?
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.green,

                    ),
                    child: ClipOval(child: Image.memory(image, fit: BoxFit.cover)),
                  ):
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.green,
                        image:  const DecorationImage(
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
                        color: Colors.green,
                        border: Border.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1.0
                        )
                    ),
                  )
                ]),
            const SizedBox(height: 8.0),
            Center(
              child: Text(
                personne['personne']['nom'],
                style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                ),
              ),
            ),
            Center(
              child: Text(
                personne['personne']['prenom'],
                style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              personne['personne']['adresse']['telephone'] ?? 'Pas de telephone',
              style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey
              ),
            ),
            const SizedBox(height: 15.0),
            Expanded(
                child: Container(
                    width: 175.0,
                    decoration: const BoxDecoration(
                      // color: status == 'Away' ? Colors.grey: Colors.green,
                      color: Colors.green,
                      borderRadius: BorderRadius.only
                        (
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)
                      ),
                    ),
                    child: const Center(
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
        margin: cardIndex.isEven? const EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0):const EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0)
    ),
  onTap: () async{
      personne['photo']= image;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DetailsClients(),
              settings: RouteSettings(
                  arguments: personne)));
  });
}

