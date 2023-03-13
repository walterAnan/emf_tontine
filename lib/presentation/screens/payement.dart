import 'package:emf_tontine/data/apiProviders/dataApi.dart';
import 'package:flutter/material.dart';
class Payement extends StatefulWidget {
  const Payement({Key? key}) : super(key: key);

  @override
  State<Payement> createState() => _PayementState();

}

class _PayementState extends State<Payement> {

  dynamic ps ;

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SafeArea(child:
        Column(
          children: [
            const Center(
              child: Text('page de payement'),

            ),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('Enabled'),
            ),
            
            Text(ps.toString())
          ],
        ),

      ),
    );
  }
}
