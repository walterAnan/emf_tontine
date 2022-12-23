

import 'package:flutter/material.dart';

class DetailsClients extends StatelessWidget {
  const DetailsClients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Object? client = ModalRoute.of(context)?.settings.arguments;
    return  Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Color(0xff4a9e04),
        elevation: 0,
      ),
      body: Center(child: Text('Details du: $client')),
    );
  }
}
