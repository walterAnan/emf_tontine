
import 'package:emf_tontine/screens/registerClient.dart';
import 'package:emf_tontine/screens/souscription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/inputs/input_field_widget.dart';
import 'collecter.dart';
import 'detailsClients.dart';
class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  final List<String> entries = <String>['Premier Client', 'Deuxième Client', 'Troisième Client','Premier Client', 'Deuxième Client', 'Troisième Client', 'Premier Client', 'Deuxième Client', 'Troisième Client', 'Premier Client', 'Deuxième Client', 'Troisième Client'];
  final List<int> colorCodes = <int>[600, 500, 100];
  bool affiche = false;
  int elmt = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text('La Liste des Clients', style: GoogleFonts.sacramento(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
               color: Colors.black
            )
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
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
                // color: Colors.yellow,
                 borderRadius: BorderRadius.circular(5)
            ),
            child: const InputField(icon: Icons.search, hint: 'Rechercher'),
                // Container(
                //   height: 20,
                //   color: Colors.indigo,
                // )
                // InputField(icon: Icons.search, hint: 'hint')

          ),
          // const SizedBox(height: 5,),
          Expanded(child: ListView.separated(
              padding: const EdgeInsets.all(5),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  children: [
                    InkWell(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 50),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                   color: Colors.purple.shade100
                                ),
                                child: Icon(Icons.person),
                              ),
                          Text(entries[index])
                        ]
                           ),
                      ),
                      onTap: (){
                        setState(() {
                          affiche = !affiche;
                          elmt = index;
                        });

                      }
                    ),
                    if(affiche == true && elmt == index)
                      Container(
                        margin: EdgeInsets.only(left: 70),
                      height: 50,
                      color: Colors.grey.shade50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          InkWell(
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.green
                                ),
                                child: Icon(Icons.money)),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Collecter()));
                            },
                          ),
                          InkWell(
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.blueAccent
                                ),
                                child: Icon(Icons.add)),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Souscription()));
                            },
                          ),

                          InkWell(
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey,

                                ),
                                child: Icon(Icons.details, color: Colors.black,)),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsClients()));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                );


              },
              separatorBuilder: (BuildContext context, int index) => const Divider()
              ),
          ),
          const SizedBox(height: 70,)
        ],

      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child:FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder:(context) =>  const RegisterClient()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    ));
  }
}
