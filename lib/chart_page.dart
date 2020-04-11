import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  /// Creates a [BarChart] with sample data and no transition.

  List<charts.Series<dynamic,String>> seriesList;
  bool animate;
  //  getGraphData(List<OrdinalSales> data) async {
  // final url = "https://api.covid19india.org/data.json";
  // final response = await http.get(url);
  // final List responseData = json.decode(response.body)['cases_time_series'];

  // responseData.forEach((element) {
  //   data.add(new OrdinalSales(element['date'], int.parse(element['totalconfirmed'])),);
  // });
  // return data;
  //   }
  @override
  void initState() {
    _createSampleData();
    super.initState();
  }

  _createSampleData() async {
    List<OrdinalSales> data = [];

    final url = "https://api.covid19india.org/data.json";
    final response = await http.get(url);
    final List responseData = json.decode(response.body)['cases_time_series'];
    print(responseData);
    responseData.forEach((element) {
      print(element['date']);
      data.add(
        OrdinalSales('Day 20', int.parse(element['totalconfirmed'])),
      );
    });
    seriesList = [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return seriesList == null
        ? CircularProgressIndicator()
        : new charts.BarChart(
            seriesList,
            animate: animate,
          );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
