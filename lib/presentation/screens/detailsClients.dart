

import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/presentation/screens/collecter.dart';
import 'package:emf_tontine/presentation/screens/mes_produits.dart';
import 'package:emf_tontine/presentation/screens/scanne.dart';
import 'package:emf_tontine/presentation/utils/keycloak_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class DetailsClients extends StatefulWidget {
  const DetailsClients({Key? key}) : super(key: key);

  @override
  State<DetailsClients> createState() => _DetailsClientsState();
}

class _DetailsClientsState extends State<DetailsClients> {
  List ps = [];
  bool taped = false;
  int elmt = -1;
  final String carnet = 'carnet';
  final String produit = 'produit';
  bool isLoading = true;

  void getPs(context, client)  async {
    ps = await getProdriutSousctionClient(context, client);
    setState(() {
      isLoading = false;
    });

    print(isLoading);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
@override



  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> client = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var largeur = MediaQuery.of(context).size.width;

     final List produitSoucrits = client['produitsS'];


    final List<String> _myList = List.generate(3, (index) => 'Product $index');
    return  Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xff4a9e04),
        title: const Text('Détails du client'),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Stack(
              children: [
                (client['photo']!= null)?
                Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.green,

                  ),
                  child: ClipOval(child: Image.memory(client['photo'], fit: BoxFit.cover)),
                ):
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
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
                  width: 25,
                  height: 25,
                  margin: const EdgeInsets.only(left: 80),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 2.0
                    )
                  ),
                )
              ],
            ),

          ),
          Column(
            children: [
              Text('${client['personne']['nomComplet']}',
                style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 60,
                width: largeur*0.45,
                child: Center(child: Column(
                  children: [
                    Text('Produits souscrits'),
                    Text(produitSoucrits.length.toString(), style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),)
                  ],
                )),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 60,
                width: largeur*0.45,
                child: Center(child: Column(
                  children:  [
                    Text('Produits souscrits'),
                    Text(produitSoucrits.length.toString(), style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),)
                  ],
                )),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          const Text('Liste des produits du clients', style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,

          ),),
          const SizedBox(height: 10,),
         Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30))
              ),
              child: ListView.separated(
                  itemCount: produitSoucrits.length,
                  // The list items
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.production_quantity_limits_outlined),
                      title: Text(produitSoucrits[index]['objetSous']['libelle'],
                        style: const TextStyle(fontSize: 18),),
                       trailing: PopupMenuButton(
                         itemBuilder: (context) =>
                         [
                           PopupMenuItem(child: TextButton(
                               child:  Text('Changer le carnet: ${produitSoucrits[index]['objetSous']['libelle']}'),
                           onPressed: (){
                                 dynamic produit = produitSoucrits[index];
                                 Map<String, dynamic> envoie = {
                                   'arg1': carnet,
                                   'arg2': client,
                                   'arg3': produit
                                 };
                                 Navigator.pop(context);
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>   const Scanner(title: 'carnet',),
                                settings: RouteSettings(arguments: envoie)));
                           },)),
                           PopupMenuItem(child: TextButton(
                             child:  Text('Changer la mise: ${produitSoucrits[index]['objetSous']['libelle']}'),
                             onPressed: (){
                               Navigator.pop(context);
                             },)),
                           PopupMenuItem(child: TextButton(
                             child:  Text('Collecter: ${produitSoucrits[index]['objetSous']['libelle']}'),
                             onPressed: (){
                               Navigator.pop(context);
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>Collecter()));
                             },)),
                         ],
                       )

                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.green,
                );
              },
                  // The separators
              ),
            )

          )
        ],
      ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child:FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   const Produits(),
                    settings: RouteSettings(arguments: client['personne'])
                  ));
            },
            child: const Icon(Icons.add),
            backgroundColor: const Color(0xff4a9e04),
          ),
        ));

  }
}
