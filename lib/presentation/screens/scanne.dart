
import 'package:emf_tontine/presentation/screens/ajouterProduit.dart';
import 'package:emf_tontine/presentation/screens/changerCarnet.dart';
import 'package:emf_tontine/presentation/screens/choix_client.dart';
import 'package:emf_tontine/presentation/screens/registerClient.dart';
import 'package:emf_tontine/presentation/screens/registerClientMorale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Scanner> createState() => _Scanner();
}



class _Scanner extends State<Scanner> {
  final GlobalKey _gLobalkey = GlobalKey();
  String _scanBarcode = '';
 Object? provenance;


  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      print('ma deuxième provenace: $provenance');
      print('le ptype de la variable provenance: ${provenance.runtimeType}');
      if(_scanBarcode != null){

        print('qr_code $_scanBarcode');
        //API DE RECUPERATION DE L'ID DU CLIENT APRESCLE SCANNE DU CODE QR
        if(provenance is String){
          if(provenance == 'nouveau0'){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ChoixClient()));
          }else{
            if(provenance == 'nouveau'){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RegisterClient()));
            }else{
                if(provenance=='nouveau1'){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ClientMoral()));
                }
              }
          }
        }else{
          Map<String, dynamic> nouvelleProvenance = provenance as Map<String, dynamic>;
          if(nouvelleProvenance['arg1'] == 'carnet'){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ChangerCarnet(),
            settings: RouteSettings(arguments: nouvelleProvenance)));
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AjouterProduit(),
                settings: RouteSettings(arguments: nouvelleProvenance)));
          }

        }




      }

    });
  }
 @override
  void initState() {

   scanQR();
   print('ma provenance: $provenance');
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    provenance = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
              height: 400,
              width: 400,
            ),
          Text('Scanne', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}