
import 'package:emf_tontine/data/models/cotisation.dart';
import 'package:emf_tontine/presentation/screens/versementChart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class Versement extends StatelessWidget {
    Versement({Key? key}) : super(key: key);

   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    var largeur = MediaQuery.of(context).size.width;
    final List<Cotisation> data = [

      Cotisation(
        jour: "Janvier",
        montant: 40000,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      Cotisation(
        jour: "Juin",
        montant: 50000,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      Cotisation(
        jour: "Juillet",
        montant: 60000,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      Cotisation(
        jour: "Août",
        montant: 30000,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      Cotisation(
        jour: "Septembre",
        montant: 100000,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(title: const Text('Cloture de la journée')),
      body: Column(
          children: [
            Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50, left: 20),
                    child:   IconButton(onPressed: () {
                      // _scaffoldKey.currentState!.openDrawer();
                      Navigator.pop(context);

                    }, icon: const Icon(Icons.arrow_back_ios_new_outlined,),),
                  ),

                  Expanded(child: Container(
                      margin: const EdgeInsets.only(top: 50, left: 30),
                      child: const Text('TONTINE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xff4a9e04)),)),),
                  Container(
                    margin: const EdgeInsets.only(top: 40, right: 20),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Image(image: AssetImage('assets/images/profile_photo.png'),),
                  ),
                ]),

            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: hauteur,
               height: 20,
              child: const Center(child: Text('Cloture de la journée', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
            ),
            const SizedBox(height: 25,),
            const Center(child: Text('Evolution mensuelle de mes collectes (xaf)')),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: hauteur,
              height: hauteur*0.35,
              child: VersementChart(
              data: data,
                      ),
            ),

            const SizedBox(height: 20,),

            const Center(child: Text('Résumé de l\'activité de la journée', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),

            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Icon(Icons.settings),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20, right: 80),
                        child: const Text('Max à cotiser'),
                      ),
                      const Expanded(
                        child: Text('5.000.000'),  )
                      ,

                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Icon(Icons.settings),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20, right: 80),
                        child: const Text('Cotisations'),
                      ),
                      const Expanded(
                        child: Text('5.000.000'),  )
                      ,

                    ],
                  ),
                  Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 20),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Icon(Icons.person_add),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 20, right: 80),
                      child: const Text('Enrollements'),
                    ),
                    const Expanded(
                      child: Text('10'),
                    )
        ],
      ),
                  Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 20),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Icon(Icons.person_add),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 20, right: 80),
                      child: const Text('Souscriptions'),
                    ),
                    const Expanded(
                      child: Text('10'),
                    )
        ],
      ),
                  const SizedBox(height: 15),
                  // OutlinedButton(
                  //   onPressed: () => _dialogBuilder(context),
                  //   child: const Text('Envoyer les données de la journée', style: TextStyle(color: Colors.black),),
                  //   style: OutlinedButton.styleFrom(
                  //       side: const BorderSide(width: 5.0, color: Color(0xff4a9e04),)
                  //   ),
                  // ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      minimumSize: const Size(125, 40), //////// HERE

                    ),
                    onPressed: () {
                      _dialogBuilder(context);
                    },
                    icon: const Icon(Icons.send_and_archive_outlined),  //icon data for elevated button
                    label: const Text("Envoyer les données de la journée"), //label text
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            )),




            ]
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cloture'),
          content: const Text('Voulez-vous vraiment cloturer votre journée d\'activités ?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Oui'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
