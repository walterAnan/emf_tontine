
import 'package:emf_tontine/presentation/screens/choix_client.dart';
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


  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      if(_scanBarcode != null){

        print('qr_code $_scanBarcode');
        //API DE RECUPERATION DE L'ID DU CLIENT APRESCLE SCANNE DU CODE QR
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChoixClient()));


      }

    });
  }
 @override
  void initState() {
   scanQR();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
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