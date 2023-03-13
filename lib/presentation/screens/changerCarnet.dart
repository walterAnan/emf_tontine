import 'package:flutter/material.dart';
class ChangerCarnet extends StatefulWidget {
  const ChangerCarnet({Key? key}) : super(key: key);

  @override
  State<ChangerCarnet> createState() => _ChangerCarnetState();
}

class _ChangerCarnetState extends State<ChangerCarnet> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> donnee = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Changer carnet'),
            Text('donnée: $donnee'),
          ],
        ),
      ),
    );
  }
}
