import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:emf_tontine/presentation/screens/collecter.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';



class ProfileClient extends StatefulWidget {
  const ProfileClient({Key? key}) : super(key: key);

  @override
  State<ProfileClient> createState() => _ProfileClientState();
}

class _ProfileClientState extends State<ProfileClient> {
  TextEditingController montant = TextEditingController();
  bool _validate = false;
  bool isLoading = true;
  late String dropdown;
  bool _isBackPressedOrTouchedOutSide = false,
      _isDropDownOpened = false,
      _isPanDown = false;
  late List<dynamic> _list = [];
  dynamic _selectedItem;
  Map data = {};

  getDataProduit() async {
    List<dynamic> list = await getProdriut(context);
    if(list != null){
      for(int i = 0; i< list.length; i++){
        _list.add(list[i]);
        print(_list[i]['code']);
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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    var largeur = MediaQuery.of(context).size.width;
    final Object? client = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            // margin: const EdgeInsets.only(top: 32),
            height: hauteur*0.4,
            width: largeur,
            decoration: const BoxDecoration(
                color: Color(0xff4a9e04),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),

            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 35, right: 20),
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,)),
                        IconButton(onPressed: (){

                        }, icon: const Icon(Icons.more_vert, color: Colors.white),)
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Container(
                         margin: const EdgeInsets.only(top: 3),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Image(image: AssetImage("assets/newIcons/ic_newProfile.png"),),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ID: ', style: GoogleFonts.abhayaLibre(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300),),
                        const SizedBox(width: 3,),
                        Text('00032', style:GoogleFonts.abhayaLibre(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              // fontStyle: FontStyle.italic,
                              color: Colors.black
                          ),),

                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Nom: ', style: GoogleFonts.abhayaLibre(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300),),
                        const SizedBox(width: 3,),
                        Text('$client', style:GoogleFonts.abhayaLibre(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            // fontStyle: FontStyle.italic,
                            color: Colors.black
                        ),),

                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Mise: ', style: GoogleFonts.abhayaLibre(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300),),
                        const SizedBox(width: 3,),
                        Text('1000', style:GoogleFonts.abhayaLibre(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            // fontStyle: FontStyle.italic,
                            color: Colors.black
                        ),),

                      ],
                    ),
                  ),
                ),
                Expanded(child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        boxShadow: [BoxShadow(
                          color: Color(0xff4a9e04),
                          // blurRadius: 1.0,
                            offset: Offset(0.0, 0.75)
                        ),]
                    ),))
              ],
            ),
          ),

          const SizedBox(height: 40,),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                      child:Text('Choisir le produit pour la collecte', style:GoogleFonts.abhayaLibre(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          // fontStyle: FontStyle.italic,
                          color: const Color(0xff4a9e04)
                      ),),

                  ),

                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10),
                  child: DropdownButtonHideUnderline(
                    child: GFDropdown(
                      hint: const Text('choisir un produit'),
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      borderRadius: BorderRadius.circular(10),
                      border: const BorderSide(
                          color: Colors.black12, width: 1),
                      dropdownButtonColor: Colors.grey[100],
                      value: _selectedItem,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedItem = newValue;
                          data['produit'] = _selectedItem;
                        });
                      },
                      items:_list
                          .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value['nomProduit']),
                      ))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Text('Montant de la collecte', style:GoogleFonts.abhayaLibre(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    // fontStyle: FontStyle.italic,
                    color: const Color(0xff4a9e04)
                ),),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: montant,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff4a9e04), width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: 'Entrer le montant',
                      errorText: !_validate ? 'Le montant de la collecte superieur à 1.000 F' : null,

                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4a9e04),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minimumSize: const Size(125, 40), //////// HERE

                      ),
                      onPressed: () {
                        setState(() {
                          double.parse(montant.text) >= 1000.0 ? _validate = true : _validate = false;
                          data['montant'] = montant.text;
                          print('donnée: $data');
                          (_validate)?Navigator.push(
                            context,
                            MaterialPageRoute(builder: (
                                context) =>  Collecter(montant: montant.text, produit: _selectedItem), ),
                          ): null;
                        });

                        },
                      icon: const Icon(Icons.save),  //icon data for elevated button
                      label: const Text("Valider", style: TextStyle(fontSize: 20),), //label text
                    ),
                  ),
                ),const SizedBox(height: 20,),

              ],
            ),
          ))
        ],
      ),
    );
  }
}
