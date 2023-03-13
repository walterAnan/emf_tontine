import 'package:flutter/material.dart';
class AjouterProduit extends StatefulWidget {
  const AjouterProduit({Key? key}) : super(key: key);

  @override
  State<AjouterProduit> createState() => _AjouterProduitState();
}

class _AjouterProduitState extends State<AjouterProduit> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> donnee = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: Center(child: Column(
        children: [
          Text('Ajouter produit'),
          Text('Données: $donnee'),
        ],
      )),
    );
  }
}
