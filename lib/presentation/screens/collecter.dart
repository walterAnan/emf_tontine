import 'package:emf_tontine/presentation/screens/collectte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class Collecter extends StatefulWidget {
  var montant;
  var produit;
  Collecter({Key? key, this.montant, this.produit,}) : super(key: key);

  @override
  State<Collecter> createState() => _CollecterState();


}

class _CollecterState extends State<Collecter> {

  var value = '0';

  String _produit = '';
  TextEditingController client = TextEditingController();
  TextEditingController montantCollecter = TextEditingController();
  // TextEditingController montant = TextEditingController();
  TextEditingController dixMille = TextEditingController();
  TextEditingController cinqMille = TextEditingController();
  TextEditingController deuxMille = TextEditingController();
  TextEditingController mille = TextEditingController();
  TextEditingController cinqCent = TextEditingController();
  TextEditingController cent = TextEditingController();
  TextEditingController cinquante = TextEditingController();

  var mDixMille = 0.0;
  var mCinqMile = 0.0;
  var mDeuxMille = 0.0;
  var mMille = 0.0;
  var mCinqCent = 0.0;
  var mCent = 0.0;
  var mCinquante = 0.0;
  var mTotal = 0.0;
  var mMontant = 0.0;
  var montant = 0.0;

  final df = new DateFormat('dd-MM-yyyy');
  List<String> adherent = ['Client1', 'Client2', 'Client3', 'client4'];
  String? selectionAdherent = 'Client1';
  //
  List<String> formule = ['Classique', 'Standard', 'Formule3', 'Formule4'];
  String? selectionFormule = 'Classique';
  // final TextEditingController _date = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    mTotal=mDixMille+mCinqMile+mDeuxMille+mMille+mCinqCent+mCent+mCinquante;
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    mTotal = mTotal;
  }
  @override
  Widget build(BuildContext context) {
    var longueur = MediaQuery.of(context).size.height;
    var largeur = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(left: 30),
            child: Text('Billetage', style: GoogleFonts.adamina(fontSize: 22, fontWeight: FontWeight.w700),)),
        elevation: 0,
        backgroundColor: const Color(0xff4a9e04),
      ),
      body: Form(
        child:Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
              children: [
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: TextField(
                        keyboardType: TextInputType.number,
                    controller: montantCollecter,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff4a9e04), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Entrer le montant à collecter',
                      // errorText: !_validate ? 'La mise doit superieure à 1.000 F' : null,

                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text('Définir le billetage', style: GoogleFonts.adamina(fontSize: 22, fontWeight: FontWeight.w700), ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nombre', style: GoogleFonts.adamina(fontSize: 16, fontWeight: FontWeight.w700),),
                    Text('Coupure', style: GoogleFonts.adamina(fontSize: 16, fontWeight: FontWeight.w700),),
                    Text('Montant(xaf)', style: GoogleFonts.adamina(fontSize: 16, fontWeight: FontWeight.w700),),


                  ],),
                const SizedBox(height: 10),

                Expanded(child: SingleChildScrollView(child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: largeur*0.2,
                          height: 40,
                          color: Colors.cyan,
                          child: TextFormField(
                            controller: dixMille,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) value ='0';
                                  mDixMille = double.parse(value)*10000;
                                  mTotal = mDixMille+mCinqMile+mDeuxMille+mMille+mCinqCent+mCent+mCinquante;
                                });

                            },

                          ),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child:  const Center(child: Text('B. 10.000', style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: Center(child: Text(mDixMille.toString(), style: const TextStyle(fontWeight: FontWeight.bold),)),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: largeur*0.2,
                          height: 40,
                          color: Colors.cyan,
                          child: Center(
                            child: TextField(
                              controller: cinqMille,
                                keyboardType: TextInputType.number,
                              onChanged: (value) {
                                // print('First text field: $text');
                                setState(() {
                                  if (value.isEmpty) value ='0';
                                  mCinqMile= double.parse(value)*5000;
                                  mTotal = mDixMille+mCinqMile+mDeuxMille+mMille+mCinqCent+mCent+mCinquante;
                                });

                              },
                            ),
                          ),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: const Center(child: Text('B. 5.000', style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child:  Center(child: Text(mCinqMile.toString())),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: largeur*0.2,
                          height: 40,
                          color: Colors.cyan,
                          child: TextField(
                            controller: deuxMille,
                              keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // print('First text field: $text');
                              setState(() {
                                if(value.isEmpty) value = '0';
                                mDeuxMille = double.parse(value)*2000;
                                mTotal = mDixMille+mCinqMile+mDeuxMille+mMille+mCinqCent+mCent+mCinquante;
                              });

                            },
                          ),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: const Center(child: Text('B. 2.000', style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: Center(child: Text(mDeuxMille.toString())),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: largeur*0.2,
                          height: 40,
                          color: Colors.cyan,
                          child: TextField(
                            controller: mille,
                              keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // print('First text field: $text');
                              setState(() {
                                if(value.isEmpty) value = '0';
                                mMille = double.parse(value)*1000;
                                mTotal = mDixMille+mCinqMile+mDeuxMille+mMille+mCinqCent+mCent+mCinquante;
                              });

                            },
                          ),
                        ),
                        Container(
                          width: largeur*0.3-15,
                          height: 40,
                          color: Colors.cyan,
                          child: const Center(child: Text('B. 1.000', style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: Center(child: Text(mMille.toString())),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: largeur*0.2,
                          height: 40,
                          color: Colors.cyan,
                          child: TextField(
                              controller: cinqCent,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                // print('First text field: $text');
                                setState(() {
                                  if(value.isEmpty) value = '0';
                                  mCinqCent = double.parse(value)*500;
                                  mTotal = mDixMille+mCinqMile+mDeuxMille+mMille+mCinqCent+mCent+mCinquante;
                                });

                              }
                          ),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: const Center(child: Text('B. 500', style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: Center(child: Text(mCinqCent.toString())),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: largeur*0.2,
                          height: 40,
                          color: Colors.cyan,
                          child: TextField(
                            controller: cinqCent,
                              keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // print('First text field: $text');
                              setState(() {
                                if(value.isEmpty) value = '0';
                                mCinqCent = double.parse(value)*500;
                                mTotal = mDixMille+mCinqMile+mDeuxMille+mMille+mCinqCent+mCent+mCinquante;
                              });

                            }
                          ),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: const Center(child: Text('P. 500', style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: Center(child: Text(mCinqCent.toString())),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: largeur*0.2,
                          height: 40,
                          color: Colors.cyan,
                          child: TextField(
                            controller: cent,
                              keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // print('First text field: $text');
                              setState(() {
                                if(value.isEmpty) value = '0';
                                mCent = double.parse(value)*100;
                                mTotal = mDixMille+mCinqMile+mDeuxMille+mMille+mCinqCent+mCent+mCinquante;
                              });

                            },
                          ),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: const Center(child: Text('P. 100', style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: Center(child: Text(mCent.toString())),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: largeur*0.2,
                          height: 40,
                          color: Colors.cyan,
                          child: TextField(
                            controller: cinquante,
                              keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // print('First text field: $text');
                              setState(() {
                                if(value.isEmpty) value = '0';
                                mCinquante = double.parse(value)*50;
                                mTotal = mDixMille+mCinqMile+mDeuxMille+mMille+mCinqCent+mCent+mCinquante;
                              });

                            },
                          ),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: const Center(child: Text('P. 50', style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        Container(
                          width: largeur*0.3 -15,
                          height: 40,
                          color: Colors.cyan,
                          child: Center(child: Text(mCinquante.toString())),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: largeur*0.4,
                          height: 40,
                          color: Colors.cyan,
                          child: Center(child: Text('Total collecté', style: GoogleFonts.adamina(fontSize: 18, fontWeight: FontWeight.w700), )),
                        ),
                        Container(
                          width: largeur*0.35,
                          height: 40,
                          color: Colors.cyan,
                          child: Center(child: Text(mTotal.toString())),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                  //
                  // Text(double.parse(texte).toString()),
                  //   Text('montant total: $mTotal'),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          minimumSize: const Size(125, 40), //////// HERE

                        ),
                        onPressed: () {
                          print('montant: ${montantCollecter.text}');
                          print('produit: $_produit');
                          print('le montant converti: ${double.parse(montantCollecter.text)}');
                          setState(() {
                            (mTotal > 0.0)?_dialogBuilder(context): showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content: Text('Spécifier un billetage svp', style: GoogleFonts.adamina(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.red), ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('OK', style: TextStyle(color: Color(0xff4a9e04)),),
                                  ),
                                ],
                              ),
                            );
                          });

                          },
                        icon: const Icon(Icons.save),  //icon data for elevated button
                        label: Text("Verifier", style: GoogleFonts.adamina(fontSize: 16, fontWeight: FontWeight.w700), ), //label text
                      ),
                    ),const SizedBox(height: 20,)


                  ],
                ),),)




              ]

          ),

        ),

      ),
    );
  }
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resumé de la collecte', style: GoogleFonts.adamina(),),
          content: Text((mTotal==  double.parse(montantCollecter.text) )? 'Tout est correcte \n Total Billetage : $mTotal \n Montant: ${montantCollecter.text}.0': ' Vierifier le montant ou le \n bielletage  \n Total Billetage : $mTotal \n Montant: ${montantCollecter.text}.0',
              style: GoogleFonts.adamina(color: (mTotal == double.parse(montantCollecter.text))? const Color(0xff4a9e04): Colors.red),),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
            if(mTotal==  double.parse(montantCollecter.text) )TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Valider', style: TextStyle(color: Color(0xff4a9e04)),),
              onPressed: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Collecte()));

                  //API D'ENVOIE DES DONNEES DE LA COLLECTE
                  // texte = '' ;
                  // adherent = '' as List<String> ;
                  // widget.montant = '';
                });

              },
            ),
          ],
        );
      },
    );
  }
}
