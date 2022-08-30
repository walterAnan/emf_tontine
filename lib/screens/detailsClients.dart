

import 'package:flutter/material.dart';

class DetailsClients extends StatelessWidget {
  const DetailsClients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: Center(child: Text('Details Clients')),
    );
  }
}
