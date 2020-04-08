import 'dart:convert';
import 'package:covid19/state_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class ScreenArguments {
  final String state;
  final String totalConfirmed;
  final String active;
  final String cured;
  final String dead;
  final String deltaTotalConfirmed;
  final String deltaActive;
  final String deltaCured;
  final String deltaDead;

  ScreenArguments(
    this.state,
    this.totalConfirmed,
    this.active,
    this.cured,
    this.dead,
    this.deltaTotalConfirmed,
    this.deltaActive,
    this.deltaCured,
    this.deltaDead,
  );
}

class _HomePageState extends State<HomePage> {
  List data;
  var data2;
  var exp;
  Future fetchAndSetdata() async {
    final url = "https://api.covid19india.org/data.json";
    final response = await http.get(url);

    this.setState(() {
      final jsonResponse = json.decode(response.body);
      data = jsonResponse['statewise'];
      exp = jsonResponse['statewise'][0]['lastupdatedtime'];
    });
  }

//   MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['flutterio', 'beautiful apps'],
//   contentUrl: 'https://flutter.io',
//  // or MobileAdGender.female, MobileAdGender.unknown
//   testDevices: <String>[], // Android emulators are considered test devices
// );

// BannerAd myBanner = BannerAd(
//   // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//   // https://developers.google.com/admob/android/test-ads
//   // https://developers.google.com/admob/ios/test-ads
//   adUnitId: BannerAd.testAdUnitId,
//   size: AdSize.smartBanner,

//   listener: (MobileAdEvent event) {
//     print("BannerAd event is $event");
//   },
// );

  Widget buildInfoCard(
    String state,
    String active,
    String totalConfirmed,
    String cured,
    String dead,
    String deltaTotalConfirmed,
    String deltaActive,
    String deltaCured,
    String deltaDead,
  ) {
    return Container(
      height: 70,
      child: GestureDetector(
        onTap: state == 'State/UT'
            ? () {}
            : () {
                Navigator.pushNamed(
                  context,
                  StateDetail.routeName,
                  arguments: ScreenArguments(
                    state,
                    active,
                    totalConfirmed,
                    cured,
                    dead,
                    deltaTotalConfirmed,
                    deltaActive,
                    deltaCured,
                    deltaDead,
                  ),
                );
              },
        child: Card(
          elevation: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Text(
                  state,
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
                width: MediaQuery.of(context).size.width * 0.15,
                child: Text(
                  totalConfirmed,
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                        color: Colors.red[900],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: Text(
                  active,
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: Text(
                  cured,
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.12,
                child: Text(
                  dead,
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleCard(
      String title, String number, String variation, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
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
                      fontSize: 20),
                ),
              ),
              Text(
                '[ +$variation ] ',
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Text(
                number,
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(color: Colors.white, fontSize: 30)),
              ),
            ],
          )),
    );
  }

  @override
  void initState() {
    fetchAndSetdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-3221433309689968/2271664024').then((value) {
    //       myBanner..load()..show( anchorOffset: 58.0,
    // // Positions the banner ad 10 pixels from the center of the screen to the right
    // horizontalCenterOffset: 10.0,

    // // Banner Position
    // anchorType: AnchorType.bottom);
    //    });
    return data == null
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: fetchAndSetdata,
            child: Column(
              children: <Widget>[
                SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Last Updated',
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                    
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              exp,
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
  
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              
                              textAlign: TextAlign.center,
                            ),
                 
                          ],

                        ),
                                   SizedBox(width: 20,)
                      ],
                    )),
                Row(
                  children: <Widget>[
                    _buildTitleCard('CNFMD', data[0]['confirmed'],
                        data[0]['deltaconfirmed'].toString(), Colors.red),
                    _buildTitleCard('ACTV', data[0]['active'],
                        data[0]['deltaconfirmed'].toString(), Colors.blue),
                    _buildTitleCard('RCVRD', data[0]['recovered'],
                        data[0]['deltarecovered'].toString(), Colors.green),
                    _buildTitleCard('DCSD', data[0]['deaths'],
                        data[0]['deltadeaths'].toString(), Colors.grey),
                  ],
                ),
                
                buildInfoCard('State/UT', 'ACTV', 'CNFMD', 'RCVRD', 'DCSD',
                    null, null, null, null),
                Flexible(
                  child: ListView.builder(
                    itemCount: 36,
                    itemBuilder: (context, index) => buildInfoCard(
                      data[index + 1]['state'],
                      data[index + 1]['active'],
                      data[index + 1]['confirmed'],
                      data[index + 1]['recovered'],
                      data[index + 1]['deaths'],
                      data[index + 1]['deltaconfirmed'].toString(),
                      data[index + 1]['deltaconfirmed'].toString(),
                      data[index + 1]['deltarecovered'].toString(),
                      data[index + 1]['deltadeaths'].toString(),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
