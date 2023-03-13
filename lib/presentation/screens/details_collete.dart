import 'package:flutter/material.dart';

class DetailsCollecte extends StatefulWidget {
  const DetailsCollecte({Key? key}) : super(key: key);

  @override
  State<DetailsCollecte> createState() => _DetailsCollecteState();
}

class _DetailsCollecteState extends State<DetailsCollecte> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Details d\'une collecte'),),
    );
  }
}
