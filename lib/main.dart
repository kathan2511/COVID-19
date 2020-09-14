// import 'package:covid19/chart_page.dart';
import 'package:covid19/home.dart';
import 'package:covid19/imp_links_page.dart';
import 'package:covid19/new_page.dart';
import 'package:covid19/state_detail_page.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        NewsPage.routeName: (context) => NewsPage(),
        StateDetail.routeName: (context) => StateDetail(),
        ImportantLinks.routeName: (context)=> ImportantLinks(),
      },
      title: 'COVID-19 India Tracker',
      theme: ThemeData(
        primaryColor: Colors.red[900]
      ),
      home: MyHomePage(title: 'COVID-19 India Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
   
    ImportantLinks(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text(widget.title),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
         
            BottomNavigationBarItem(
              icon: Icon(Icons.share),
              title: Text('Links'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red[900],
          onTap: _onItemTapped,
        ),
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
