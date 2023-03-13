import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';



class Collecte extends StatefulWidget {
  const Collecte({Key? key}) : super(key: key);

  @override
  State<Collecte> createState() => _CollecteState();
}

class _CollecteState extends State<Collecte> {
  List nbr_mise = [

  ];
  int i = 0;


  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print('latitude: ${position.latitude}');
    print('longitude: ${position.longitude}');
  }
@override
  void initState() {
  double mise = 1500;
  double montant = 6500;
  double d = montant/mise;
  print(d);
  String roundedX = d.truncate().toString();

 i = int.parse(roundedX);
    // TODO: implement initState
    super.initState();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    int nbrJourRestant = 5;
  if(i<nbrJourRestant){
    nbr_mise = List<int>.generate(i, (int index) => index , growable: true);
  }else{
      nbr_mise = List<int>.generate(nbrJourRestant, (int index) => index , growable: true);
    }

    print(nbr_mise);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 50,),
          if(i>=2 && nbrJourRestant>=2)Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            child: DropdownButtonHideUnderline(
              child: GFDropdown(
                hint: const Text('Nombre de mise'),
                padding: const EdgeInsets.only(left: 100, right: 20),
                borderRadius: BorderRadius.circular(10),
                border: const BorderSide(
                    color: Colors.black12, width: 1),
                dropdownButtonColor: Colors.grey[100],
                // value: _selected_cycle,
                onChanged: (newValue) {
                  setState(() {
                    // _selected_cycle = newValue;

                  });
                },
                items:nbr_mise
                    .map((value) => DropdownMenuItem(
                  value: value,
                  child: value == 0 ? Text('${value + 1} ' ' jour'):Text('${value + 1} ' ' jours'),
                ))
                    .toList(),
              ),
            ),
          ),
          SizedBox(height: 100,),


          ElevatedButton(
            child:Text('Collecter'),
            onPressed: () async {
              getLocation();
            },
            style: ElevatedButton.styleFrom(
                primary: const Color(0xff4a9e04),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 80, vertical: 10),
                textStyle: const TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
