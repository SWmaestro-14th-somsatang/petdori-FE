import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../../utils/constants.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;
  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<charts.Series<TimeSeriesData, DateTime>>? seriesList;
  bool? animate;

  @override
  void initState() {
    super.initState();
    animate = true;
    fetchData();

    Timer.periodic(const Duration(hours: 1), (Timer timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://52.78.73.7:8080/api/charts/lines'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      setState(() {
        seriesList = [
          charts.Series<TimeSeriesData, DateTime>(
            id: 'BloodSugar',
            domainFn: (TimeSeriesData data, _) => data.timestamp,
            measureFn: (TimeSeriesData data, _) => data.pastBloodSugar,
            colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue),
            data: responseData.map((data) {
              return TimeSeriesData(
                DateTime.parse(data['timestamp']),
                data['pastBloodSugar'].toDouble(),
              );
            }).toList(),
          ),
        ];
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (seriesList != null)
          SizedBox(
            height: 200,
            child: charts.TimeSeriesChart(
              seriesList!,
              animate: animate!,
              defaultRenderer:
                  charts.LineRendererConfig(includeArea: true, stacked: false),
              domainAxis: const charts.DateTimeAxisSpec(
                // tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
                tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                  day: charts.TimeFormatterSpec(
                    format: 'MMM/d HH:mm',
                    transitionFormat: 'MMM/d HH:mm',
                  ),
                ),
              ),
              primaryMeasureAxis: const charts.NumericAxisSpec(
                tickProviderSpec:
                    charts.BasicNumericTickProviderSpec(desiredTickCount: 7),
              ),
              behaviors: [
                charts.RangeAnnotation(
                  [
                    charts.RangeAnnotationSegment(
                      70,
                      100,
                      charts.RangeAnnotationAxisType.measure,
                      color: charts.ColorUtil.fromDartColor(
                          Colors.green.withOpacity(0.2)),
                    )
                  ],
                  defaultLabelPosition: charts.AnnotationLabelPosition.margin,
                ),
              ],
            ),
          ),
        if (seriesList == null)
          SizedBox(
            height: 200,
            child: const Center(
              child: Text('No data available'),
            ),
          ),
      ],
    );
  }
}

class TimeSeriesData {
  final DateTime timestamp;
  final double pastBloodSugar;

  TimeSeriesData(this.timestamp, this.pastBloodSugar);
}
