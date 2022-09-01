
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detailTransaction.dart';
class Historique extends StatefulWidget {
  const Historique({Key? key}) : super(key: key);

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  final List<String> entries = <String>['PrTrans', 'DxTrans', 'TrTrans','PrTrans', 'DxTrans', 'TrTrans', 'PrTrans', 'DxTrans', 'TrTrans'];
  final List<int> colorCodes = <int>[600, 500, 100];
  bool cliquer = false;
  int elmtCliquer = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Center(
            child:  Text('Historique des transactions', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),),
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: const BoxDecoration(
                // color: Colors.grey,
                // borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                // Container(
                //   height: 70,
                //   width: 70,
                //   // padding: const EdgeInsets.symmetric(vertical: 30),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(100),
                //   ),
                //   child: const Image(image: AssetImage('assets/images/profile_photo.png', ),fit: BoxFit.fill,),
                // ),
                // const SizedBox(width: 20,),
                // Column(
                //   children: const [
                //     Text('Marc', style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold
                //     ),),
                //   ],
                // )
              ],
            ),),
          Expanded(child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  children: [
                InkWell(
                child: Container(
                height: 70,
                  // margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 50,
                          width: 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.purple.shade100
                          ),
                        ),
                        Text('01/09/2022', style: GoogleFonts.sacramento(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: Colors.black
                        ),),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 50,
                          width: 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.yellow
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 70),
                            child: Text(entries[index])),
                        TextButton(onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTransaaction()));

                          setState(() {
                            cliquer = !cliquer;
                            elmtCliquer = index;
                          });
                        },
                        child: const Text('Voir plus'),)
                      ]
                  ),

                )),
                  if(cliquer == true && elmtCliquer==index)
                  Container(
                    height: 100,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Text('text1' + entries[index]),
                        Text('text2' + entries[index]),
                        Text('text3' + entries[index]),
                        Text('text4' + entries[index]),
                      ],
                    ),

                  )]);}, separatorBuilder: (BuildContext context, int index) {return Divider(
            color: Theme.of(context).dividerColor,
          ); },)

        )],
    ));
  }
}
