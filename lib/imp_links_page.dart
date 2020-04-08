import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ImportantLinks extends StatelessWidget {
  static const routeName = '/imp-links';
  Widget _buildInfoItem(String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        _launchURL(subtitle);
      },
          child: Container(
        height: 140,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(color: Colors.white70,child: Padding(
            
            padding: const EdgeInsets.all(15.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start,  children: <Widget>[
              
              Text(title, style: GoogleFonts.oswald(textStyle : TextStyle(fontWeight: FontWeight.bold,fontSize: 20 )),),
              Text(subtitle, style: GoogleFonts.oswald(textStyle : TextStyle(fontWeight: FontWeight.bold,color: Colors.blue )),),
            ],),
          ),),
        ),
      ),
    );
  }
_launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
              child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child: Center(child: Text('IMPORTANT     LINKS', textAlign: TextAlign.center,style: GoogleFonts.oswald(textStyle : TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),),),),
              _buildInfoItem('HELPLINE NUMBERS [BY STATE]', 'HTTPS://WWW.MOHFW.GOV.IN/CORONVAVIRUSHELPLINENUMBER.PDF'),
              _buildInfoItem('MINISTRY OF HEALTH AND FAMILY WELFARE, GOV. OF INDIA', 'HTTPS://WWW.MOHFW.GOV.IN/'),
              _buildInfoItem('WHO : COVID-19 HOME PAGE', 'HTTPS://WWW.WHO.INT/EMERGENCIES/DISEASES/NOVEL-CORONAVIRUS-2019'),
              _buildInfoItem('CDC', 'HTTPS://WWW.CDC.GOV/CORONAVIRUS/2019-NCOV/FAQ.HTMLCOVID-19 GLOBAL TR'),
              _buildInfoItem('COVID-19 GLOBAL TRACKER', 'HTTPS://CORONAVIRUS.THEBASELAB.COM/'),
            ],
          ),
        ),
      ),
    );
  }
}
