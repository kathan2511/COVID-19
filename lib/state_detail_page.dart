// import 'dart:convert';

import 'dart:convert';

import 'package:covid19/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as http;

class StateDetail extends StatefulWidget {
  static const routeName = '/state-detail';

  @override
  _StateDetailState createState() => _StateDetailState();
}

class _StateDetailState extends State<StateDetail> {
  // List data;

  var stateData;
  fetchAndSetData(String statename) async {
    final url = 'https://api.covid19india.org/v2/state_district_wise.json';
    final response = await http.get(url);
    final List data = json.decode(response.body);
    data.forEach((element) {
      if (element['state'] == statename) {
        setState(() {
          stateData = element['districtData'];
        });
        return;
      }
      return;
    });
    // stateData = data.firstWhere(
    //   (element) => (element['state'].(statename)),
    // );
  }

  Widget buildInfoCard(
    String district,
    String active,
  ) {
    return Container(
      height: 70,
      child: Card(
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text(
                district,
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text(
                active,
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                      color: Colors.red[900],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleCard(
      String title, String number, String variation, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Card(
          color: color,
          elevation: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Text(
                '[ +$variation ] ',
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(color: Colors.white)),
              ),
              Text(
                number,
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(color: Colors.white)),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenArguments args = ModalRoute.of(context).settings.arguments;
    fetchAndSetData(args.state);

    // Future fetchAndSetData() async {
    //   final url = 'https://api.covid19india.org/state_district_wise.json';
    //   final response = await http.get(url);
    //   final responseBody = json.decode(response.body);
    //   setState(() {
    //     stateData = responseBody[args.state];
    //   });
    //   DateTime dateTime = DateTime.parse("28 March 2019");
    //   print(dateTime);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(args.state),
      ),
      body: stateData == null
          ? CircularProgressIndicator()
          : Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildTitleCard('CNFMD', args.active,
                        args.deltaTotalConfirmed, Colors.red),
                    _buildTitleCard('ACTIVE', args.totalConfirmed,
                        args.deltaActive, Colors.blue),
                    _buildTitleCard(
                        'RCVRD', args.cured, args.deltaCured, Colors.green),
                    _buildTitleCard(
                        'DCSD', args.dead, args.deltaDead, Colors.grey),
                  ],
                ),
                buildInfoCard('District', 'Cases'),
                Flexible(
                  child: ListView.builder(
                    itemCount: stateData.length,
                    itemBuilder: (context, index) => buildInfoCard(
                      stateData[index]['district'],
                      stateData[index]['confirmed'].toString(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
