

import 'dart:convert';

import 'package:emf_tontine/presentation/screens/details_collete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';


class HistoriqueCollecte extends StatefulWidget {
  const HistoriqueCollecte({Key? key}) : super(key: key);

  @override
  State<HistoriqueCollecte> createState() => _HistoriqueCollecteState();
}

class _HistoriqueCollecteState extends State<HistoriqueCollecte> {
  final List<String> entries = <String>['PrTrans', 'DxTrans', 'TrTrans','PrTrans', 'DxTrans', 'TrTrans', 'PrTrans', 'DxTrans', 'TrTrans'];
  final List<int> colorCodes = <int>[600, 500, 100];
  bool cliquer = false;
  int elmtCliquer = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xff4a9e04),
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
                    // borderSide: BorderSide(color: Color(0xff4a9e04), width: 2.0),
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
                return ListTile(
                    leading: const Icon(Icons.production_quantity_limits_outlined),
                    title: Text(entries[index],
                      style: const TextStyle(fontSize: 18),),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) =>
                      [
                        PopupMenuItem(child: TextButton(
                          child:  Text('Changer le carnet: ${entries[index]}'),
                          onPressed: (){
                            dynamic produit = entries[index];
                            Map<String, dynamic> envoie = {
                              'arg1': 'Imprimer',
                              'arg3': produit
                            };
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>   const DetailsCollecte(),
                                    settings: RouteSettings(arguments: envoie)));
                          },)),

                        PopupMenuItem(child: TextButton(
                          child:  Text('Imprimer: ${entries[index]}'),
                          onPressed: (){
                            Navigator.pop(context);
                            _print();
                            // print();
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Impression(title: 'Collecte',)));
                          },)),
                      ],
                    )

                );}, separatorBuilder: (BuildContext context, int index) {return Divider(
            color: Theme.of(context).dividerColor,
          ); },)

        )],
    ));
  }

  void _print() async {
    // Test regular text
    SunmiPrinter.hr();
    SunmiPrinter.text(
      'Test Sunmi Printer',
      styles: SunmiStyles(align: SunmiAlign.center),
    );
    SunmiPrinter.hr();

    // Test align
    SunmiPrinter.text(
      'left',
      styles: SunmiStyles(bold: true, underline: true),
    );
    SunmiPrinter.text(
      'center',
      styles:
      SunmiStyles(bold: true, underline: true, align: SunmiAlign.center),
    );
    SunmiPrinter.text(
      'right',
      styles: SunmiStyles(bold: true, underline: true, align: SunmiAlign.right),
    );

    // Test text size
    SunmiPrinter.text('Extra small text',
        styles: SunmiStyles(size: SunmiSize.xs));
    SunmiPrinter.text('Medium text', styles: SunmiStyles(size: SunmiSize.md));
    SunmiPrinter.text('Large text', styles: SunmiStyles(size: SunmiSize.lg));
    SunmiPrinter.text('Extra large text',
        styles: SunmiStyles(size: SunmiSize.xl));

    // Test row
    SunmiPrinter.row(
      cols: [
        SunmiCol(text: 'col1', width: 4),
        SunmiCol(text: 'col2', width: 4, align: SunmiAlign.center),
        SunmiCol(text: 'col3', width: 4, align: SunmiAlign.right),
      ],
    );

    // Test image
    ByteData bytes = await rootBundle.load('assets/images/logo-sfe.svg');
    final buffer = bytes.buffer;
    final imgData = base64.encode(Uint8List.view(buffer));
    SunmiPrinter.image(imgData);

    SunmiPrinter.emptyLines(10);
  }

}
