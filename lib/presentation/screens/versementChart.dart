
import 'package:emf_tontine/data/models/cotisation.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class VersementChart extends StatelessWidget {
  final List<Cotisation> data;

  const VersementChart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Cotisation, String>> series = [
      charts.Series(
          id: "cotisations",
          data: data,
          domainFn: (Cotisation series, _) => series.jour,
          measureFn: (Cotisation series, _) => series.montant,
          colorFn: (Cotisation series, _) => series.barColor
      )
    ];

    return charts.BarChart(series, animate: true);
  }

}