

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: const Color(0xff4a9e04),
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
          const SizedBox(height: 10,),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: TextField(
                onChanged: (value){
                  // Rechercher(value);
                  // _runFilter(value);
                },
                // controller: text,
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
                          margin: const EdgeInsets.only(right: 10),
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
                          margin: const EdgeInsets.only(right: 10),
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
                        child: (cliquer && elmtCliquer==index)? const Text('Moins'): const Text('Voir Plus'),)
                      ]
                  ),

                )),
                  if(cliquer == true && elmtCliquer==index)
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('text1' + entries[index]),
                            Text('text1' + entries[index]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('text2' + entries[index]),
                            Text('text1' + entries[index]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('text3' + entries[index]),
                            Text('text1' + entries[index]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('text4' + entries[index]),
                            Text('text1' + entries[index]),
                          ],
                        ),
                      ],
                    ),

                  )]);}, separatorBuilder: (BuildContext context, int index) {return Divider(
            color: Theme.of(context).dividerColor,
          ); },)

        )],
    ));
  }
}
