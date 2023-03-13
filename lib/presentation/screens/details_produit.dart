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
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.15,
            child:  Container(
              color: Color(0xff4a9e04),
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text('Détails du produit', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  color: Colors.white
                ),),
              ),
            ),),
          // const Text('Changer carnet'),
          // Text('les donnnées: $donnee'),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  // height: MediaQuery.of(context).size.height*0.85,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: const Text('Nom du produit')),
                            Container(
                              padding: const EdgeInsets.only(left: 50),
                              child: Text('${produit['nomProduit']}', style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                            )
                          ],
                        ),),
                      Container(height: 1,
                        color: Colors.grey,),
                      SizedBox(height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: const Text('Fréquence  de collecte')),
                              Container(
                                padding: EdgeInsets.only(left: 50),
                                child: Text('${produit['freqCollecte']['value']}', style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          )),
                      Container(height: 1,
                        color: Colors.grey,),
                      SizedBox(height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: const Text('Cycle')),
                              Container(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text('${produit['cycle']}', style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          )),
                      Container(height: 1,
                        color: Colors.grey,),
                      SizedBox(height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: const Text('Montant minimum')),
                            Container(
                              padding: const EdgeInsets.only(left: 50),
                              child: Text('${produit['mntMinCotisable']}', style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                            )
                          ],
                        ),),
                      Container(height: 1, color: Colors.grey,),
                      SizedBox(height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: const Text('Montant maximum')),
                              Container(
                                padding: EdgeInsets.only(left: 50),
                                child: Text('${produit['mntMaxCotisable']}', style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          )),
                      Container(height: 1,
                        color: Colors.grey,),

                      SizedBox(height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: const Text('Description')),
                              Container(
                                padding: EdgeInsets.only(left: 50),
                                child: Text('${produit['description']}', style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          )),

                      Container(height: 1, color: Colors.grey,),
                      SizedBox(height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: const Text('Statut')),
                              Container(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text('${produit['statut']['libelle']}', style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          )),
                      Container(
                        height: 40,
                        width: 100,
                        margin: const EdgeInsets.only(left: 50),
                        child: ElevatedButton(
                          child: const Text('Retour'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(height: 30,)

                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
