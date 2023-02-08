import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/presentation/screens/details_produit.dart';
import 'package:flutter/material.dart';
class Produits extends StatefulWidget {
  const Produits({Key? key}) : super(key: key);


  @override
  State<Produits> createState() => _ProduitsState();


}

class _ProduitsState extends State<Produits> {


  late final List<dynamic> _produits = [];

  bool isLoading = true;
  List produits = [
    {
      'nomProduit': 'Produit1',
      'cycleProduit': 'Mensuel',
      'montantMin': '100.000'
    },
    {
      'nomProduit': 'Produit2',
      'cycleProduit': 'Trimestriel',
      'montantMin': '500.000'
    },
    {
      'nomProduit': 'Produit3',
      'cycleProduit': 'Semestriel',
      'montantMin': '200.000'
    },
    {
      'nomProduit': 'Produit1',
      'cycleProduit': 'Mensuel',
      'montantMin': '100.000'
    },
    {
      'nomProduit': 'Produit2',
      'cycleProduit': 'Trimestriel',
      'montantMin': '500.000'
    },
    {
      'nomProduit': 'Produit3',
      'cycleProduit': 'Semestriel',
      'montantMin': '200.000'
    },
    {
      'nomProduit': 'Produit1',
      'cycleProduit': 'Mensuel',
      'montantMin': '100.000'
    },
    {
      'nomProduit': 'Produit2',
      'cycleProduit': 'Trimestriel',
      'montantMin': '500.000'
    },
    {
      'nomProduit': 'Produit3',
      'cycleProduit': 'Semestriel',
      'montantMin': '200.000'
    },
    {
      'nomProduit': 'Produit1',
      'cycleProduit': 'Mensuel',
      'montantMin': '100.000'
    },
    {
      'nomProduit': 'Produit2',
      'cycleProduit': 'Trimestriel',
      'montantMin': '500.000'
    },
    {
      'nomProduit': 'Produit3',
      'cycleProduit': 'Semestriel',
      'montantMin': '200.000'
    }
  ];

  getDataProduit() async {
    List<dynamic> list = await getProdriut();
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

  @override
  void initState() {
    getDataProduit();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading ? Builder(
        builder: (context) {
          return const CircularProgressIndicator();
        }
      ):SafeArea(
        child: ListView.builder(
          itemCount: _produits.length,
            itemBuilder: (context, index) => Card(
              // color: Colors.red,
              elevation: 5,
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.production_quantity_limits_outlined),
                ),
                title: Text(_produits[index]['nomProduit']),
                // subtitle: Text(produits[index]['description']),
                trailing: IconButton(icon: const Icon(Icons.details_rounded),
                onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsProduit(),
                      settings: RouteSettings(arguments: _produits[index])));
                },),
              ),

            )),
      ),
    );
  }
}
