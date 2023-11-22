import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class PieChartWidget extends StatefulWidget {
  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  final List<charts.Series<LinearSales, String>> seriesList = [
    charts.Series(
      id: 'Sales',
      data: [
        LinearSales('정상 혈당', 40),
        LinearSales('저혈당', 30),
        LinearSales('고혈당', 20),
        LinearSales('위험 수치', 10),
      ],
      domainFn: (LinearSales sales, _) => sales.category,
      measureFn: (LinearSales sales, _) => sales.amount,
      colorFn: (LinearSales sales, _) {
        // Use different colors for each slice
        if (sales.category == '정상 혈당') {
          return charts.ColorUtil.fromDartColor(Colors.blue);
        } else if (sales.category == '저혈당') {
          return charts.ColorUtil.fromDartColor(Colors.lightBlue);
        } else if (sales.category == '고혈당') {
          return charts.ColorUtil.fromDartColor(Colors.lightBlueAccent);
        } else if (sales.category == '위험 수치') {
          return charts.ColorUtil.fromDartColor(Colors.blueAccent);
        }
        return charts.ColorUtil.fromDartColor(Colors.grey); // Default color
      },
      labelAccessorFn: (LinearSales sales, _) => '${sales.category}: ${sales.amount}',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: charts.PieChart<String>(
            seriesList,
            animate: true,
            defaultRenderer: charts.ArcRendererConfig(
              arcRendererDecorators: [
                charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.auto,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LinearSales {
  final String category;
  final int amount;

  LinearSales(this.category, this.amount);
}
