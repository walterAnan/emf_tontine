import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:flutter/material.dart';
class DetailsProduit extends StatefulWidget {
  const DetailsProduit({Key? key}) : super(key: key);

  @override
  State<DetailsProduit> createState() => _DetailsProduitState();
}

class _DetailsProduitState extends State<DetailsProduit> {

  @override
  Widget build(BuildContext context) {
    final dynamic produit = ModalRoute.of(context)?.settings.arguments as dynamic;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(produit['nomProduit'])
      ),
    );
  }
}
