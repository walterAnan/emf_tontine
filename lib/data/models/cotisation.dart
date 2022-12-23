import 'package:charts_flutter/flutter.dart' as charts;
class Cotisation {
  final String jour;
  final int montant;
  final charts.Color barColor;

  const Cotisation({
   required this.jour,
    required this.montant,
    required this.barColor,
  });

  Map<String, dynamic> toJason() {
    return {
      'jour': jour,
      'age': montant,
      'graphique': barColor,
    };
  }
  @override
  String toString() {
    return 'Cotisation{id: $jour, name: $barColor, age: $montant}';
  }


}
