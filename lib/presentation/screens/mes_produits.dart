import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/presentation/screens/clients.dart';
import 'package:emf_tontine/presentation/screens/clients_moral.dart';
import 'package:emf_tontine/presentation/screens/details_produit.dart';
import 'package:emf_tontine/presentation/screens/scanne.dart';
import 'package:flutter/material.dart';
class Produits extends StatefulWidget {
  const Produits({Key? key}) : super(key: key);


  @override
  State<Produits> createState() => _ProduitsState();


}

class _ProduitsState extends State<Produits> {


  TextEditingController text = TextEditingController();
  final List<dynamic> _produits = [];

  bool isLoading = true;
  List<dynamic> _mesProduitsTrouves = [];
  getDataProduit() async {
    List<dynamic> list = await getProdriut(context);
    if(list != null){
      for(int i = 0; i< list.length; i++){
        _produits.add(list[i]);
        print(_produits[i]['code']);
        setState(() {
          isLoading = false;
        });
      }
    }else{
      print('Le retour est nul');
    }


  }


  void _runFilter(String entree) {
    List<dynamic> results = [];
    if (entree.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _produits;
      print('je suis dans le if $results');
    } else {
      results = _produits
          .where((produit) =>
          produit['nomProduit'].toLowerCase().contains(entree.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    print('je suis dans le else $results');
    setState(() {
      _mesProduitsTrouves = results;
    });

  }

  @override
  void initState() {
    getDataProduit();
    _mesProduitsTrouves =_produits;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> clt = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4a9e04),
        title: const Text('Liste des produits'),
      ),
      body: isLoading ? Builder(
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        }
      ):
          Column(
            children: [
              const SizedBox(height: 20,),
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
                      hintText: 'Rechercher le produit',

                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _mesProduitsTrouves.length,
                    itemBuilder: (context, index) => Card(
                      // color: Colors.red,
                      elevation: 5,
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.production_quantity_limits_outlined),
                        ),
                        title: Text(_mesProduitsTrouves[index]['nomProduit']),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) =>
                          [
                            PopupMenuItem(child: TextButton(
                              child:  Text('Ajouter le : ${_mesProduitsTrouves[index]['nomProduit']}'),
                              onPressed: (){
                                if(clt==null){
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Ajout d\'un produit'),
                                      content: const Text('Choissez d\'abord le client', style: TextStyle(
                                        color: Colors.amber
                                      ),),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                          child: const Text('Annuler'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                       Navigator.push(context, MaterialPageRoute(builder:(context)=>const Clients()));
                                       // Navigator.pop(context, 'Cancel');
                                            },

                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );


                                }else{
                                  Map<String, dynamic> envoie = {
                                    'arg1': clt,
                                    'arg2': _mesProduitsTrouves[index]
                                  };
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>   const Scanner(title: ''),
                                          settings: RouteSettings(arguments: envoie)
                                      ));
                                  Navigator.pop(context);
                                }

                              },)),
                            PopupMenuItem(child: TextButton(
                              child:  Text('Détails: ${_mesProduitsTrouves[index]['nomProduit']}'),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsProduit(),
                                settings: RouteSettings(arguments: _mesProduitsTrouves[index])));
                              },)),
                          ],
                        )
                      ),

                    )),
              ),
            ],
          ),

    );
  }
}
